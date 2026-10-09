package input

import "../state"

import rl "vendor:raylib"

MAP_BINDINGS:[1]Binding = {
  {.BACKSPACE, state.DecrementState}
}

ControlMap :: proc() {
  for bind in MAP_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}