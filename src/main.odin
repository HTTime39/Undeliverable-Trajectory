package main

import "state"
import "render"
import "input"

import rl "vendor:raylib"

main :: proc() {
  rl.InitWindow(render.WINDOW_WIDTH, render.WINDOW_HEIGHT, "Undeliverable Trajectory")
  defer rl.CloseWindow()
  rl.SetTargetFPS(60)

  // Load delivery menu data
  state.LoadDeliveriesData()

  for(!rl.WindowShouldClose() && state.isRunning) {
    // deltaT := rl.GetFrameTime()

    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    switch state.gameState {
      case .TITLE:
        input.ControlTitleMenu()
        render.DrawTitle(input.titleMenuSelected)
      case .DELIVERY_MENU:
        input.ControlDeliveryMenu()
        render.DrawDeliveryMenu()
      case .MAP:
        input.ControlMap()
        render.DrawMap()
    }

		rl.EndDrawing()
  }
}