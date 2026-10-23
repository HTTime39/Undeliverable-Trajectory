package input

import "../state"

import rl "vendor:raylib"

ENCOUNTER_BINDINGS:[6]Binding = {
  {.BACKSPACE, state.DecrementState},
  {.A, NodeSelectLeft},
  {.LEFT, NodeSelectLeft},
  {.D, NodeSelectRight},
  {.RIGHT, NodeSelectRight},
  {.ENTER, NodeSelectEnter}
}

ControlEncounter :: proc() {
  for bind in MAP_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}