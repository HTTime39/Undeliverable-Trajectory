package render

import "../state"

import rl "vendor:raylib"

DrawEncounter :: proc() {
  rl.DrawTexturePro(state.encounterBackgrounds, rl.Rectangle{f32(128*state.encounterBGIndex), 0, 128, 72}, rl.Rectangle{0, 0, 1280, 720}, rl.Vector2{0,0}, 0.0, rl.WHITE)

  rl.DrawTexturePro(state.playerSprite, rl.Rectangle{0, 0, 28, 52}, rl.Rectangle{584, 300, 140, 260}, rl.Vector2{0, 0}, 0, rl.WHITE)

}