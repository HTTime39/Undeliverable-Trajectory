package render

import rl "vendor:raylib"

WINDOW_WIDTH :: 1280
WINDOW_HEIGHT :: 720

TITLE_MENU:[2]cstring = {"Play", "Exit"}

drawTitle :: proc(menuSelected: int) {
  rl.DrawText("Undeliverable Trajectory", (WINDOW_WIDTH - rl.MeasureText("Undeliverable Trajectory", 48)) / 2, 200, 48, rl.WHITE)
  
  for i in 0..<len(TITLE_MENU) {
    if i == menuSelected {
      // Draw selected text in yellow
      rl.DrawText(TITLE_MENU[i], (WINDOW_WIDTH - rl.MeasureText(TITLE_MENU[i], 32)) / 2, i32(350 + 50*i), 32, rl.YELLOW)
    } else {
      // Draw unselected text in white
      rl.DrawText(TITLE_MENU[i], (WINDOW_WIDTH - rl.MeasureText(TITLE_MENU[i], 32)) / 2, i32(350 + 50*i), 32, rl.WHITE)
    }
  }
}