package state

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

bagSelected := 0
usingItems : [dynamic]bool // These are the items that will get used, indices

encounterSprites: map[string]rl.Texture2D

ClearUsingItems :: proc() {
  for i in 0..<len(player.bag) {
    append(&usingItems, false)
  }
}

ModifyHealth :: proc(amount: int) {
  player.hp += amount
}

ModifyStamina :: proc(amount: int) {
  player.stamina += amount
}

AddItemToBag :: proc(item: string, amount: int) -> string {
  currentWeight : f32 = 0.0
  currentVolume := 0

  for payload in player.bag {
    currentWeight += payload.weight
    switch payload.size {
      case "s":
        currentVolume += 1
      case "m": 
        currentVolume += 2
      case "l":
        currentVolume += 4
      case:
        // Does nothing, should never hit this
    }
  }
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