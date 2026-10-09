package render

import rl "vendor:raylib"

WINDOW_WIDTH :: 1280
WINDOW_HEIGHT :: 720\

TITLE_SIZE :: 64
TITLE_MENU_SIZE :: 48
TITLE_MENU_SPACING :: 70 // Vertical offsets

TITLE_MENU:[2]cstring = {"Play", "Exit"}

DrawTitle :: proc(menuSelected: int) {
  rl.DrawText("Undeliverable Trajectory", (WINDOW_WIDTH - rl.MeasureText("Undeliverable Trajectory", TITLE_SIZE)) / 2, 200, TITLE_SIZE, rl.WHITE)
  
  for i in 0..<len(TITLE_MENU) {
    if i == menuSelected {
      x : i32 = (WINDOW_WIDTH - rl.MeasureText(TITLE_MENU[i], TITLE_MENU_SIZE)) / 2
      y : i32 = i32(350 + TITLE_MENU_SPACING*i)
      // Drawing the same text at offsets to give selected element a border
      rl.DrawText(TITLE_MENU[i], x-2, y-2, TITLE_MENU_SIZE, rl.PURPLE)
      rl.DrawText(TITLE_MENU[i], x-2, y+2, TITLE_MENU_SIZE, rl.PURPLE)
      rl.DrawText(TITLE_MENU[i], x+2, y+2, TITLE_MENU_SIZE, rl.PURPLE)
      rl.DrawText(TITLE_MENU[i], x+2, y-2, TITLE_MENU_SIZE, rl.PURPLE)
      // Draw selected text in yellow
      rl.DrawText(TITLE_MENU[i], x, y, TITLE_MENU_SIZE, rl.YELLOW)
    } else {
      // Draw unselected text in white
      rl.DrawText(TITLE_MENU[i], (WINDOW_WIDTH - rl.MeasureText(TITLE_MENU[i], TITLE_MENU_SIZE)) / 2, i32(350 + TITLE_MENU_SPACING*i), TITLE_MENU_SIZE, rl.WHITE)
    }
  }
}