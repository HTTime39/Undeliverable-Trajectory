package input

import "../state"

import "core:fmt"
import rl "vendor:raylib"
import "core:math/rand"

NodeSelectLeft :: proc() {
  minimum, maximum := GetMapSelectionBounds(state.currentLayerIndex, len(state.nodeMap[state.currentNodeLayer]), len(state.nodeMap[state.currentNodeLayer+1]))

  if (state.nextNodeSelection == minimum) {
    state.nextNodeSelection = maximum
  } else {
    state.nextNodeSelection -= 1
  }
}

NodeSelectRight :: proc() {
  minimum, maximum := GetMapSelectionBounds(state.currentLayerIndex, len(state.nodeMap[state.currentNodeLayer]), len(state.nodeMap[state.currentNodeLayer+1]))
  
  if (state.nextNodeSelection == maximum) {
    state.nextNodeSelection = minimum
  } else {
    state.nextNodeSelection += 1
  }
}

GetMapSelectionBounds :: proc(currentIndex:int, currentCount:int, nextCount:int) -> (int, int) {
  // Pass the index currently at, number of nodes at current layer, number of nodes at next layer
  minimum := 0
  maximum := 0

  if currentCount == 1 {
    minimum = 0
    maximum = 1
  } else if currentCount == 2 {
    minimum = min(currentIndex, nextCount-1)
    maximum = min(currentIndex+1, nextCount-1)
  } else if currentCount == 3 {
    minimum = min(max(0, currentIndex-1), nextCount-1)
    maximum = min(1, currentIndex, nextCount-1)
  }

  return minimum, maximum
}

NodeSelectEnter :: proc() {
  // Setting new values
  state.currentNodeLayer += 1
  state.currentLayerIndex = state.nextNodeSelection
  // Cleanup
  if state.nodeMap[state.currentNodeLayer][state.nextNodeSelection] != -2 {
    state.currentEncounter = state.encounterNodeList[state.nodeMap[state.currentNodeLayer][state.nextNodeSelection]]
  } else {
  // This is runs when the player has reached the ending node
    state.gameState = .ENDING
    return
  }

  minimum, maximum := GetMapSelectionBounds(state.currentLayerIndex, len(state.nodeMap[state.currentNodeLayer]), len(state.nodeMap[state.currentNodeLayer+1]))

  state.nextNodeSelection = minimum
  state.gameState = .ENCOUNTER
  state.encounterBGIndex = rand.int_range(0, 9)

  // Setup
  state.ClearUsingItems()
  state.isAnimating = true
}

MAP_BINDINGS:[6]Binding = {
  {.BACKSPACE, state.DecrementState},
  {.A, NodeSelectLeft},
  {.LEFT, NodeSelectLeft},
  {.D, NodeSelectRight},
  {.RIGHT, NodeSelectRight},
  {.ENTER, NodeSelectEnter}
}

ControlMap :: proc() {
  for bind in MAP_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}