package input

import "../state"

import rl "vendor:raylib"

NodeSelectLeft :: proc() {
  if (state.nextNodeSelection == 0) {
    state.nextNodeSelection = len(state.nodeMap[state.currentNodeLayer+1]) - 1
  } else {
    state.nextNodeSelection -= 1
  }
}

NodeSelectRight :: proc() {
  state.nextNodeSelection = (state.nextNodeSelection + 1) % len(state.nodeMap[state.currentNodeLayer+1])
}

NodeSelectEnter :: proc() {
  // Setting new values
  state.currentNodeLayer += 1
  state.currentLayerIndex = state.nextNodeSelection
  // Cleanup
  state.currentEncounter = state.encounterNodeList[state.nodeMap[state.currentNodeLayer][state.nextNodeSelection]]
  state.nextNodeSelection = 0
  state.gameState = .ENCOUNTER
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