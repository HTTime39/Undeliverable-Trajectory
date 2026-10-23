package state

import "core:math/rand"

nodeMap : [dynamic][]int // Each row of the array is a layer of the map, indices stored here are used in reference to state.encounterNodeList
currentNodeLayer := 0 // The current encounter layer the player is at
currentLayerIndex := 0 // The current index of the current layer the player is at
nextNodeSelection := 0 // The node the player is highlighting for selection

RandomPickNodeIndex :: proc() -> int {
  return rand.int_range(0, len(encounterNodeList))
}

GenerateMap :: proc() {
  for layer in nodeMap {
    delete(layer)
  }
  delete(nodeMap)
  nodeMap = {} // Empty map
  startLayer := make([]int, 1)
  startLayer[0] = -1 // -1 will denote the starting node
  append(&nodeMap, startLayer)

  for i in 0..<currentDelivery.encounterLayers { // Alternate between layers with 2 and 3 nodes; 
    if i % 2 == 0 {
      layer := make([]int, 2)
      layer[0] = RandomPickNodeIndex()
      layer[1] = RandomPickNodeIndex()
      append(&nodeMap, layer)
    } else {
      layer := make([]int, 3)
      layer[0] = RandomPickNodeIndex()
      layer[1] = RandomPickNodeIndex()
      layer[2] = RandomPickNodeIndex()
      append(&nodeMap, layer)
    }
  }

  finishLayer := make([]int, 1)
  finishLayer[0] = -2 // -2 will denote the finishing node
  append(&nodeMap, finishLayer)
}