package render

import "../state"

import "core:fmt"
import rl "vendor:raylib"

REWARDS : [4]cstring = {
  "Increase HP +15",
  "Increase Stamina +15",
  "Increase Carry Weight +15",
  "Increase Carry Capacity +1"
}

DrawEnding :: proc() {
  t := fmt.ctprintf("%s Reached", state.currentDelivery.destination)
  fSize : i32 = 60

  finalScore, letterGrade := state.CalculateScore(state.player, state.currentDelivery)
  scoreText := fmt.ctprintf("Final Score: %d     Delivery Grade: %s", finalScore, letterGrade)

  rl.DrawText(t, 640 - rl.MeasureText(t, fSize) / 2, 100, fSize, rl.WHITE)
  rl.DrawText(scoreText, 640 - rl.MeasureText(scoreText, fSize) / 2, 200, fSize, rl.WHITE)

  t = "Pick Permanent Upgrade"
  rl.DrawText(t, 640 - rl.MeasureText(t, 50) / 2, 295, 50, rl.WHITE)

  DrawRewards()
}

DrawRewards :: proc() {
  fSize : i32 = 40

  for reward, i in REWARDS {
    c := rl.WHITE

    if state.rewardSelected == i {
      c = rl.YELLOW
      rl.DrawLine(340, 365 + 50 * i32(i), 940, 365 + 50 * i32(i), c)
      rl.DrawLine(340, 415 + 50 * i32(i), 940, 415 + 50 * i32(i), c)
      rl.DrawLine(340, 365 + 50 * i32(i), 340, 365 + 50 * i32(i) + 10, c)
      rl.DrawLine(340, 415 + 50 * i32(i), 340, 415 + 50 * i32(i) - 10, c)
      rl.DrawLine(940, 365 + 50 * i32(i), 940, 365 + 50 * i32(i) + 10, c)
      rl.DrawLine(940, 415 + 50 * i32(i), 940, 415 + 50 * i32(i) - 10, c)
    }

    rl.DrawText(reward, 640 - rl.MeasureText(reward, fSize) / 2, 370 + 50 * i32(i), fSize, c)
  }
}