package input

import "../state"

import rl "vendor:raylib"

ENDING_BINDINGS:[1]Binding = {
  {.ENTER, EndingEnter}
}

ControlEnding :: proc() {
  for bind in ENDING_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}

EndingEnter :: proc() {
  state.gameState = .TITLE
}
