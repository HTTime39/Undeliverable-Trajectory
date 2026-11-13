package render

import "../state"

import "core:math"
import rl "vendor:raylib"

animTimer : f32 = 0.0

DrawEncounter :: proc(deltaT:f32) {
  rl.DrawTexturePro(state.encounterBackgrounds, rl.Rectangle{f32(128*state.encounterBGIndex), 0, 128, 72}, rl.Rectangle{0, -150, 1280, 720}, rl.Vector2{0,0}, 0.0, rl.WHITE)
  
  if state.isAnimating {
    AnimateEncounterEntry(deltaT)
    return
  }

  rl.DrawTexturePro(state.playerSprite, rl.Rectangle{0, 0, 28, 52}, rl.Rectangle{550, 290, 168, 312}, rl.Vector2{0, 0}, 0, rl.WHITE)
  DrawEncounterEntity()

  DrawEncounterDialogue(state.currentEncounter.title, state.currentEncounter.description)
  DrawBagMenu(state.player.bag)
}

DrawEncounterDialogue :: proc(title:cstring, description:cstring="") {
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

DrawEncounterEntity :: proc() {
  if state.currentEncounter.image != "" {
    rl.DrawTexturePro(
      state.encounterSprites[state.currentEncounter.image], 
      rl.Rectangle{0, 0, 64, 64}, 
      rl.Rectangle{-100, -20, 540, 620}, 
      rl.Vector2{0, 0}, 0, rl.WHITE)
  }
}

AnimateEncounterEntry :: proc(deltaT:f32) {
  animTimer += deltaT
  secTimers : []f32 = {0.5, 1.0, 0.15, 0.30, 0.30, 0.15}
  // Player slide, entity slide, shake, shake shake

  // Slide in player
  rl.DrawTexturePro(
    state.playerSprite, 
    rl.Rectangle{0, 0, 28, 52}, 
    rl.Rectangle{max(550, 800-(250/secTimers[0])*animTimer), 290, 168, 312}, 
    // Kind of like position - velocity * time
    rl.Vector2{0, 0}, 0, rl.WHITE)

  // Slide in and shake entity
  if state.currentEncounter.image != "" {
    r : f32 = 0.0
    a : f32 = 10

    if animTimer > math.sum(secTimers[:5]) {
      r = a + (-a/secTimers[5])*(animTimer-math.sum(secTimers[:5]))
    }
    else if animTimer > math.sum(secTimers[:4]) {
      r = -a + (2*a/secTimers[4])*(animTimer-math.sum(secTimers[:4]))
      // Instead these are like angle + angular velocity * time
    } else if animTimer > math.sum(secTimers[:3]) {
      r = a + (-2*a/secTimers[3])*(animTimer-math.sum(secTimers[:3]))

    } else if animTimer > math.sum(secTimers[:2]) {
      r = (a/secTimers[2])*(animTimer-math.sum(secTimers[:2]))

    }

    rl.DrawTexturePro(
      state.encounterSprites[state.currentEncounter.image], 
      rl.Rectangle{0, 0, 64, 64}, 
      rl.Rectangle{min(170, -330+(500/secTimers[1])*(max(0, animTimer-secTimers[0]))), 290, 540, 620}, 
      rl.Vector2{270, 310}, r, rl.WHITE)
  }

  DrawEncounterDialogue(state.currentEncounter.title)
  DrawBagMenu({})

  if animTimer >= math.sum(secTimers) || (state.currentEncounter.image == "" && animTimer >= secTimers[0]) {
    // Cleanup at the end of the animation
    state.isAnimating = false
    animTimer = 0.0
  }
}