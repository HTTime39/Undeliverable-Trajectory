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
  // Preparing for roll
  rollSuccessChance := state.currentEncounter.passPercentage
  rollCount := state.currentEncounter.passCount

  // Applying modifiers
  fmt.println("Applying modifiers...")
  for payload, i in state.player.bag {
  // Iterate over items in the players bag
    if state.usingItems[i] {
    // If the item is being used
      for mod in state.currentEncounter.modifiers {
      // Iterate over items that have a modifier on the current event
        if payload.name == mod.name {
        // If the item being used has the same name as an item in the modifier list
          rollSuccessChance += mod.modifier
          fmt.println(mod)
        }
      }
    }
  }

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
      fmt.println("Success")
    } else {
      fmt.println("Fail")
    }
  }

  fmt.println(fmt.ctprint("Passing ", successes, " / ", state.currentEncounter.passCount))

  // Triggering reward effects
  if successes > state.currentEncounter.passCount {
    fmt.println("Triggering rewards...")
    for reward in state.currentEncounter.reward {
      switch reward.name {
        case "health":
          state.ModifyHealth(reward.amount)
        case "stamina":
          state.ModifyStamina(reward.amount)
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
      case:
        // This should never get reached
    }
    fmt.println(consume)
  }

  // Just print results for now, implement render later
  fmt.println(state.player.cHp)
  fmt.println(state.player.cStamina)
  fmt.println("-----COMPLETED ENCOUNTER-----")

  // Returning to the map
  state.ClearUsingItems()
  state.gameState = .MAP
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
  state.usingItems[state.bagSelected] = !state.usingItems[state.bagSelected]
}

ControlEncounter :: proc() {
  for bind in ENCOUNTER_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}