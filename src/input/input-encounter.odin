package input

import "../state"

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

ENCOUNTER_BINDINGS:[]Binding = {
  {.BACKSPACE, state.DecrementState},
  {.W, InventorySelectUp},
  {.UP, InventorySelectUp},
  {.S, InventorySelectDown},
  {.DOWN, InventorySelectDown},
  {.SPACE, InventoryAddToUse},
  {.ENTER, RollEncounter}
}

RollEncounter :: proc() {
  if state.isRollComplete {
    // Returning to the map if the roll has already been made this encounter
    state.gameState = .MAP
    state.isRolling = false
    state.isRollComplete = false
    return
  }

  // Preparing for roll
  rollSuccessChance := state.ApplyStaminaToRoll(state.player.cStamina, state.player.stamina, state.currentEncounter.passPercentage)
  rollCount := state.currentEncounter.passCount
  fmt.println(rollSuccessChance)

  // Applying modifiers
  fmt.println("Applying modifiers...")
  rollSuccessChance = state.ApplyItemsToRoll(rollSuccessChance)

  // Assigning for rendering later
  state.currentRollPercentage = rollSuccessChance

  // Remove items being used from the player's bag
  for i := len(state.player.bag)-1; i >=0; i-=1 {
    if state.usingItems[i] {
      ordered_remove(&state.player.bag, i)
    }
  }

  // Make the rolls
  successes : int = 0

  fmt.println("Making rolls...")
  for i in 0..<5 {
    // Rolling the dice 5 times
    if rand.float32() <= state.currentEncounter.passPercentage {
    // Increment the success counter when a roll passes
      successes += 1
      state.rollResults[i] = true
      fmt.println("Success")
    } else {
      state.rollResults[i] = false
      fmt.println("Fail")
    }
  }

  fmt.println(fmt.ctprint("Passing ", successes, " / ", state.currentEncounter.passCount))

  // Triggering reward effects
  if successes >= state.currentEncounter.passCount {
    fmt.println("Triggering rewards...")
    for reward in state.currentEncounter.reward {
      switch reward.name {
        case "health":
          state.ModifyHealth(reward.amount)
        case "stamina":
          state.ModifyStamina(reward.amount)
        case "payloadStatus":
          state.ModifyPayloadStatus(reward.amount)
        case:
          state.AddItemToBag(reward.name, reward.amount)
      }
      fmt.println(reward)
    }

  // Triggering fail effects
  } else {
    fmt.println("Triggering penalties...")
    for penalty in state.currentEncounter.fail {
      switch penalty.name {
        case "health":
          state.ModifyHealth(penalty.amount)
        case "stamina":
          state.ModifyStamina(penalty.amount)
        case "payloadStatus":
          state.ModifyPayloadStatus(penalty.amount)
        case:
          state.AddItemToBag(penalty.name, penalty.amount)
          // Should add a cargo damaged function
      }
      fmt.println(penalty)
    }
  }

  fmt.println("Triggering consumptions...")
  // Triggering consumption effects
  for consume in state.currentEncounter.consume {
    switch consume.name {
      case "health":
        state.ModifyHealth(consume.amount)
      case "stamina":
        state.ModifyStamina(consume.amount)
      case "payloadStatus":
        state.ModifyPayloadStatus(consume.amount)
      case:
        // This should never get reached
    }
    fmt.println(consume)
  }

  // Just print results for now, implement render later
  fmt.println(state.player.cHp)
  fmt.println(state.player.cStamina)
  fmt.println(state.player.cCargoStatus)
  fmt.println("-----COMPLETED ENCOUNTER-----")

  // Cleanup
  state.ClearUsingItems()
  state.isAnimating = true
  state.isRolling = true
  state.bagSelected = 0
}

InventorySelectUp :: proc() {
  if state.bagSelected == 0 {
    state.bagSelected = len(state.player.bag) - 1
  } else {
    state.bagSelected = abs((state.bagSelected - 1) % len(state.player.bag))
  }
}

InventorySelectDown :: proc() {
  state.bagSelected = (state.bagSelected + 1) % len(state.player.bag)
}

InventoryAddToUse :: proc() {
// Adding a bag item to the pool of items to be used during this encounter
  // Prevent deliverable cargo from being selected for use
  if state.bagSelected < len(state.currentDelivery.payloads) {
    return
  }

  state.usingItems[state.bagSelected] = !state.usingItems[state.bagSelected]
}

ControlEncounter :: proc() {
  for bind in ENCOUNTER_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}