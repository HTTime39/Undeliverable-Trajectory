package state

import "core:math/rand"

nodeMap : [dynamic][]int // Each row of the array is a layer of the map, indices stored here are used in reference to state.encounterNodeList
currentNodeLayer := 0 // The current encounter layer the player is at
currentLayerIndex := 0 // The current index of the current layer the player is at

RandomPickNodeIndex :: proc() -> int {
  return rand.int_range(0, len(encounterNodeList))
}

GenerateMap :: proc() {
  nodeMap = {} // Empty map
  append(&nodeMap, []int{-1}) // -1 will denote the starting node

  for i in 0..<currentDelivery.encounterLayers { // Alternate between layers with 2 and 3 nodes; 
    if i % 2 == 0 {
      append(&nodeMap, []int{RandomPickNodeIndex(),RandomPickNodeIndex()})
    } else {
      append(&nodeMap, []int{RandomPickNodeIndex(), RandomPickNodeIndex(), RandomPickNodeIndex()})
    }
  }

  append(&nodeMap, []int{-2}) // -2 will denote the finishing node
}