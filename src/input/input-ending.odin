package input

import "../state"

import rl "vendor:raylib"

ENDING_BINDINGS:[5]Binding = {
  {.ENTER, state.EndingEnter},
  {.W, state.EndingSelectUp},
  {.UP, state.EndingSelectUp},
  {.S, state.EndingSelectDown},
  {.DOWN, state.EndingSelectDown},
}

ControlEnding :: proc() {
  for bind in ENDING_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}
