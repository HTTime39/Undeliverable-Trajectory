package input

import "../render"

import rl "vendor:raylib"

Binding :: struct {
  key: rl.KeyboardKey,
  action: proc()
}

// Variable holding currently selected menu item
menuSelected := 0

// Procedures for controlling the title menu
menuUp :: proc() { 
  // Move up menu list
  menuSelected = abs((menuSelected - 1) % len(render.TITLE_MENU))
}
menuDown :: proc() {
  // Move down menu list
  menuSelected = abs((menuSelected + 1) % len(render.TITLE_MENU))
}
menuEnter :: proc() {
  // Load whatever is selected

}

TITLE_BINDINGS:[5]Binding = {
  {.W, menuUp},
  {.UP, menuUp},
  {.S, menuDown},
  {.DOWN, menuDown},
  {.ENTER, menuEnter}
}

ControlTitleMenu :: proc() {
  for bind in TITLE_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}