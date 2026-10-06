package main

import "render"

import rl "vendor:raylib"

main :: proc() {
  rl.InitWindow(render.WINDOW_WIDTH, render.WINDOW_HEIGHT, "Undeliverable Trajectory")
  defer rl.CloseWindow()
  rl.SetTargetFPS(60)

  for(!rl.WindowShouldClose()) {
    // deltaT := rl.GetFrameTime()

    rl.BeginDrawing()

    render.drawTitle()

		rl.EndDrawing()
  }
}