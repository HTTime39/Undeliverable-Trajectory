package input

import "../state"
import "../render"

import rl "vendor:raylib"

// Currently selected menu item
titleMenuSelected : int = 0

// Procedures for controlling the title menu
TitleMenuUp :: proc() { 
  // Move up menu list
  if titleMenuSelected == len(render.TITLE_MENU) {
    titleMenuSelected = len(render.TITLE_MENU) - 1
  } else {
    titleMenuSelected = abs((titleMenuSelected - 1) % len(render.TITLE_MENU))
  }
}
TitleMenuDown :: proc() {
  // Move down menu list
  titleMenuSelected = abs((titleMenuSelected + 1) % len(render.TITLE_MENU))
}
TitleMenuEnter :: proc() {
  // Load whatever is selected
  if titleMenuSelected == 0 {
    state.gameState = .DELIVERY_MENU
  } else if titleMenuSelected == 1 {
    state.isRunning = false
  }
  titleMenuSelected = 0
}

TITLE_BINDINGS:[5]Binding = {
  {.W, TitleMenuUp},
  {.UP, TitleMenuUp},
  {.S, TitleMenuDown},
  {.DOWN, TitleMenuDown},
  {.ENTER, TitleMenuEnter}
}

ControlTitleMenu :: proc() {
  for bind in TITLE_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}