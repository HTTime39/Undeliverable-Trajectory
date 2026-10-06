package render

import rl "vendor:raylib"

WINDOW_WIDTH :: 1280
WINDOW_HEIGHT :: 720

drawTitle :: proc() {
  rl.DrawText("Undeliverable Trajectory", (WINDOW_WIDTH - rl.MeasureText("Undeliverable Trajectory", 48)) / 2, 200, 48, rl.WHITE)
  
  rl.DrawText("Play", (WINDOW_WIDTH - rl.MeasureText("Play", 32)) / 2, 350, 32, rl.WHITE)

  rl.DrawText("Exit",  (WINDOW_WIDTH - rl.MeasureText("Exit", 32)) / 2, 400, 32, rl.WHITE)
}