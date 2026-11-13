package main

import "state"
import "render"
import "input"

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
  rl.InitWindow(render.WINDOW_WIDTH, render.WINDOW_HEIGHT, "Undeliverable Trajectory")
  defer rl.CloseWindow()
  rl.SetTargetFPS(60)

  // Load delivery menu data
  state.LoadDeliveriesData()
  state.LoadEncounterNodes()
  
  state.LoadItemDictionary()

  // Load images
	state.encounterBackgrounds = rl.LoadTexture("assets/encounter-backgrounds.png")
  state.playerSprite = rl.LoadTexture("assets/player.png")

  // Load images for encounter specific sprites into map
  for node in state.encounterNodeList {
    if node.image != "" {
      state.encounterSprites[string(node.image)] = rl.LoadTexture(fmt.ctprintf("assets/%s.png", node.image))
    }
  }

  for(!rl.WindowShouldClose() && state.isRunning) {
    deltaT := rl.GetFrameTime()

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
        render.DrawEncounter(deltaT)
        if !state.isAnimating do input.ControlEncounter()
    }

		rl.EndDrawing()
  }
}