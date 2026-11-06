package render

import "../state"

import rl "vendor:raylib"

DrawEncounter :: proc(deltaT:f32) {
  rl.DrawTexturePro(state.encounterBackgrounds, rl.Rectangle{f32(128*state.encounterBGIndex), 0, 128, 72}, rl.Rectangle{0, -150, 1280, 720}, rl.Vector2{0,0}, 0.0, rl.WHITE)

  rl.DrawTexturePro(state.playerSprite, rl.Rectangle{0, 0, 28, 52}, rl.Rectangle{550, 290, 168, 312}, rl.Vector2{0, 0}, 0, rl.WHITE)

  DrawEncounterDialogue(state.currentEncounter.title, state.currentEncounter.description)
  DrawBagMenu(state.player.bag)
}

DrawEncounterDialogue :: proc(title:cstring, description:cstring) {
  rl.DrawRectangle(0, 570, 1280, 150, rl.BLACK)
  
  rl.DrawText(title, 20, 590, 32, rl.WHITE)
  rl.DrawLineEx(rl.Vector2{40 + f32(rl.MeasureText(title, 32)), 632}, rl.Vector2{80 + f32(rl.MeasureText(title, 32)), 572}, 5, rl.YELLOW)
  rl.DrawLineEx(rl.Vector2{0, 632}, rl.Vector2{42 + f32(rl.MeasureText(title, 32)), 632}, 5, rl.YELLOW)

  rl.DrawText(description, 20, 650, 28, rl.WHITE)
  
  rl.DrawLineEx(rl.Vector2{0, 577}, rl.Vector2{1280, 577}, 10, rl.YELLOW)
  rl.DrawRectangle(0, 570, 1280, 10, rl.PURPLE)
}

selectToggle := false
selectTogglePrevT : f64 = 0.0

DrawBagMenu :: proc(inventory:[dynamic]state.Payload) {
  rl.DrawRectangle(800, 0, 480, 570, rl.BLACK)

  currentTime := rl.GetTime()

  for payload, i in inventory {
    c := rl.WHITE
    if i == state.bagSelected {
      c = rl.YELLOW
      if state.usingItems[i] {
        c = rl.YELLOW
        if currentTime - selectTogglePrevT >= 0.5 {
          selectToggle = !selectToggle
          selectTogglePrevT = currentTime
        }
        if selectToggle {
          c = rl.PURPLE
        }
      }
    } else if state.usingItems[i] {
      c = rl.PURPLE
    }

    rl.DrawText(payload.name, 820, i32(20 + 32 * i), 28, c)
    rl.DrawLine(825, i32(50 + 32 * i), 1265, i32(50 + 32 * i), rl.WHITE)
  }

  rl.DrawLineEx(rl.Vector2{807, 0}, rl.Vector2{807, 570}, 10, rl.YELLOW)
  rl.DrawRectangle(800, 0, 10, 570, rl.PURPLE)
} 