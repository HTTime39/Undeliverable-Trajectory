package state

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

bagSelected := 0
usingItems : [dynamic]bool // These are the items that will get used, indices

isRolling : bool = false // Whether or not the dice roll animation is playing
isRollComplete : bool = false
currentRollPercentage : f32 = 0
rollResults : [5]bool

encounterSprites: map[string]rl.Texture2D

ClearUsingItems :: proc() {
  usingItems = {}

  for i in 0..<len(player.bag) {
    append(&usingItems, false)
  }
}

ModifyHealth :: proc(amount: int) {
  player.cHp += amount
}

ModifyStamina :: proc(amount: int) {
  player.cStamina += amount
}

ModifyPayloadStatus :: proc(amount: int) {
  player.cCargoStatus += amount
}

AddItemToBag :: proc(item: string, amount: int) -> string {
  currentWeight, currentVolume := GetBagInfo(player)

  // Translating item size into an integer
  itemSize : int
  switch itemDictionary[item].size {
    case "s":
      itemSize = 1
    case "m":
      itemSize = 2
    case "l":
      itemSize = 4
    case:
      // Does nothing, should never hit this
  }

  // Adds to bag if it fits
  if currentVolume + itemSize <= player.bagVolume && currentWeight + itemDictionary[item].weight <= player.bagCapacity {
    append(&player.bag, Payload{name=strings.clone_to_cstring(item), size=itemDictionary[item].size, weight=itemDictionary[item].weight})
    return string(fmt.ctprintf("Added %s to bag", item))
  } else {
    return string(fmt.ctprintf("No room to add %s to bag", item))
  }
}

ApplyStaminaToRoll :: proc(st:int, stMax:int, rs:f32) -> f32 {
  if st < stMax/2 {
  // Apply a modifier when the player stamina is below half
    maxPenalty : f32 = 0.30 // Maximum chance reduction of 30%
    penalty : f32 = (1 - f32(st) / f32(stMax/2)) * maxPenalty // Incur penalty up to 30% scaling linearly over the remaining stamina

    return max(rs - penalty, 0) // Minimizing the return value at 0 to prevent negative numbers
  }
  return rs
}

ApplyItemsToRoll :: proc(rollSuccessChance:f32) -> f32 {
  result := rollSuccessChance

  for payload, i in player.bag {
  // Iterate over items in the players bag
    if usingItems[i] {
    // If the item is being used
      for mod in currentEncounter.modifiers {
      // Iterate over items that have a modifier on the current event
        if payload.name == mod.name {
        // If the item being used has the same name as an item in the modifier list
          result += mod.modifier
          fmt.println(mod)
        }
      }
    }
  }

  return result
}