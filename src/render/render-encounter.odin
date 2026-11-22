package render

import "../state"

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

animTimer : f32 = 0.0
rollAngle : f32 = 0.0

DrawEncounter :: proc(deltaT:f32) {
  rl.DrawTexturePro(state.encounterBackgrounds, rl.Rectangle{f32(128*state.encounterBGIndex), 0, 128, 72}, rl.Rectangle{0, -150, 1280, 720}, rl.Vector2{0,0}, 0.0, rl.WHITE)
  
  if state.isAnimating && !state.isRolling {
    AnimateEncounterEntry(deltaT)
    return
  }

  rl.DrawTexturePro(state.playerSprite, rl.Rectangle{0, 0, 28, 52}, rl.Rectangle{550, 290, 168, 312}, rl.Vector2{0, 0}, 0, rl.WHITE)
  DrawEncounterEntity()

  DrawEncounterDialogue(state.currentEncounter.title, state.currentEncounter.description, state.currentEncounter.passPercentage, state.currentEncounter.passCount)
  DrawBagMenu(state.player.bag)

  // Hide the status bar while animating to prevent spoiling the results; 
  // maybe do something different with this later
  if !state.isAnimating {
    DrawStatus()
  }

  if state.isRolling {
    DrawRoll(state.rollResults, deltaT)
  }
}

DrawEncounterDialogue :: proc(title:cstring, description:cstring="", passPercentage:f32=-1, passCount:int=-1) {
  rl.DrawRectangle(0, 570, 1280, 150, rl.BLACK)
  
  rl.DrawText(title, 20, 590, 32, rl.WHITE)
  rl.DrawLineEx(rl.Vector2{40 + f32(rl.MeasureText(title, 32)), 632}, rl.Vector2{80 + f32(rl.MeasureText(title, 32)), 572}, 5, rl.YELLOW)
  rl.DrawLineEx(rl.Vector2{0, 632}, rl.Vector2{42 + f32(rl.MeasureText(title, 32)), 632}, 5, rl.YELLOW)

  rl.DrawText(description, 20, 650, 28, rl.WHITE)
  if passPercentage != -1 { // Only draw when there's an actual value
    rs := state.ApplyStaminaToRoll(state.player.cStamina, state.player.stamina, passPercentage)
    rl.DrawText(fmt.ctprintf("Roll Success: %d%%   Successes to Pass: %d", int(rs*100), passCount), 20, 688, 28, rl.WHITE)
  }
  
  rl.DrawLineEx(rl.Vector2{0, 577}, rl.Vector2{1280, 577}, 10, rl.YELLOW)
  rl.DrawRectangle(0, 570, 1280, 10, rl.PURPLE)
}

selectToggle := false
selectTogglePrevT : f64 = 0.0

DrawBagMenu :: proc(inventory:[dynamic]state.Payload) {
  rl.DrawRectangle(800, 0, 480, 570, rl.BLACK)
  if !state.isAnimating {
    currentTime := rl.GetTime()
  
    for payload, i in inventory {
      c := rl.WHITE
      if i == state.bagSelected {
        c = rl.YELLOW

        rl.DrawLine(1260, i32(43 + 32 * i), 1240, i32(33 + 32 * i), rl.PURPLE)
        rl.DrawLine(1260, i32(23 + 32 * i), 1240, i32(33 + 32 * i), rl.PURPLE)

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

  DrawStatus()

  if animTimer >= math.sum(secTimers) || (state.currentEncounter.image == "" && animTimer >= secTimers[0]) {
    // Cleanup at the end of the animation
    state.isAnimating = false
    animTimer = 0.0
  }
}

DrawRoll :: proc (results : [5]bool, deltaT: f32) {
  rl.DrawRectangle(0, 210, 1280, 300, rl.ColorAlpha(rl.BLACK, 0.6))

  diceWidth : f32 = 175.0
  if !state.isRollComplete {
    rollAngle += 6 // degrees / 1/60 second ~ this is about 1 rotation per second
    animTimer += deltaT
  }

  for result, i in results {
    if animTimer < f32(i)/2 + 1.0 && !state.isRollComplete { // Added integer let's them roll a little before stopping
      rl.DrawRectanglePro(rl.Rectangle{190+225*f32(i), 360, diceWidth, diceWidth}, rl.Vector2{diceWidth/2, diceWidth/2}, rollAngle, rl.PURPLE)
      rl.DrawRectanglePro(rl.Rectangle{190+225*f32(i), 360, diceWidth-10, diceWidth-10}, rl.Vector2{(diceWidth)/2-5, (diceWidth)/2-5}, rollAngle, rl.YELLOW)
    
    } else {
      c := rl.RED
      t : cstring= "FAIL"
      if result {
        c = rl.GREEN
        t = "PASS"
      }

      rl.DrawRectanglePro(rl.Rectangle{190+225*f32(i), 360, diceWidth, diceWidth}, rl.Vector2{diceWidth/2, diceWidth/2}, 0, rl.PURPLE)
      rl.DrawRectanglePro(rl.Rectangle{190+225*f32(i), 360, diceWidth-10, diceWidth-10}, rl.Vector2{(diceWidth)/2-5, (diceWidth)/2-5}, 0, c)

      rl.DrawText(t, i32(190 + 225*i) - rl.MeasureText(t, 55)/2, 332, 55, rl.WHITE)
    }

    // Draw PASSED or FAILED depending on outcome of the rolls vs the encounter
    if state.isRollComplete {
      successes := 0
      for result in results {
        if result {
          successes += 1
        }
      }

      c := rl.RED
      t : cstring = "FAILED"

      if successes >= state.currentEncounter.passCount {
        c = rl.GREEN
        t = "PASSED"
      }

      rl.DrawText(t, 640 - rl.MeasureText(t, 60)/2, 215, 60, c)
    }
  }

  // Cleanup
  if animTimer > 3.5 {
    animTimer = 0.0
    rollAngle = 0.0
    state.isAnimating = false
    state.isRollComplete = true
  }
}