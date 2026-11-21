package render

import "../state"

import "core:fmt"
import rl "vendor:raylib"

REWARDS : [4]cstring = {
  "Increase HP +5",
  "Increase Stamina +5",
  "Increase Carry Weight +10",
  "Increase Carry Capacity +1"
}

DrawEnding :: proc() {
  t := fmt.ctprintf("%s Reached", state.currentDelivery.destination)
  fSize : i32 = 60

  finalScore, letterGrade := state.CalculateScore(state.player, state.currentDelivery)
  scoreText := fmt.ctprintf("Final Score: %d     Delivery Grade: %s", finalScore, letterGrade)

  rl.DrawText(t, 640 - rl.MeasureText(t, fSize) / 2, 200, fSize, rl.WHITE)
  rl.DrawText(scoreText, 640 - rl.MeasureText(scoreText, fSize) / 2, 300, fSize, rl.WHITE)

  DrawRewards()
}

DrawRewards :: proc() {
  fSize : i32 = 40

  for reward, i in REWARDS {
    c := rl.WHITE

    if state.rewardSelected == i {
      c = rl.YELLOW
      rl.DrawLine(340, 395 + 50 * i32(i), 940, 395 + 50 * i32(i), c)
      rl.DrawLine(340, 445 + 50 * i32(i), 940, 445 + 50 * i32(i), c)
      rl.DrawLine(340, 395 + 50 * i32(i), 340, 395 + 50 * i32(i) + 10, c)
      rl.DrawLine(340, 445 + 50 * i32(i), 340, 445 + 50 * i32(i) - 10, c)
      rl.DrawLine(940, 395 + 50 * i32(i), 940, 395 + 50 * i32(i) + 10, c)
      rl.DrawLine(940, 445 + 50 * i32(i), 940, 445 + 50 * i32(i) - 10, c)
    }

    rl.DrawText(reward, 640 - rl.MeasureText(reward, fSize) / 2, 400 + 50 * i32(i), fSize, c)
  }
}