package main

import "render"
import "input"

import rl "vendor:raylib"

GameState :: enum {
  TITLE, 
}

main :: proc() {
  rl.InitWindow(render.WINDOW_WIDTH, render.WINDOW_HEIGHT, "Undeliverable Trajectory")
  defer rl.CloseWindow()
  rl.SetTargetFPS(60)

  gameState := GameState.TITLE

  for(!rl.WindowShouldClose()) {
    // deltaT := rl.GetFrameTime()

    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    switch gameState {
      case .TITLE:
        input.ControlTitleMenu()
        render.drawTitle(input.menuSelected)
    }

		rl.EndDrawing()
  }
}