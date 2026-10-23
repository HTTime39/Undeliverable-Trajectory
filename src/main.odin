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
  state.LoadEncounterNodes()

  for(!rl.WindowShouldClose() && state.isRunning) {
    // deltaT := rl.GetFrameTime()

    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    switch state.gameState {
      case .TITLE:
        render.DrawTitle(input.titleMenuSelected)
        input.ControlTitleMenu()
      case .DELIVERY_MENU:
        render.DrawDeliveryMenu()
        input.ControlDeliveryMenu()
      case .MAP:
        render.DrawMap()
        input.ControlMap()
      case .ENCOUNTER:
        render.DrawEncounter()
        input.ControlEncounter()
    }

		rl.EndDrawing()
  }
}