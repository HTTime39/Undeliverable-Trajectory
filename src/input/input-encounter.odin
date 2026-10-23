package input

import "../state"

import rl "vendor:raylib"

ENCOUNTER_BINDINGS:[]Binding = {
  {.BACKSPACE, state.DecrementState},
  // {.A, NodeSelectLeft},
  // {.LEFT, NodeSelectLeft},
  // {.D, NodeSelectRight},
  // {.RIGHT, NodeSelectRight},
  {.ENTER, Temp}
}

Temp :: proc() {
  if state.currentLayerIndex != 9 {
    state.gameState = .MAP
  }
}

ControlEncounter :: proc() {
  for bind in ENCOUNTER_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}