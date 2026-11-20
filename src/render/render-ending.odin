package render

import "../state"

import "core:fmt"
import rl "vendor:raylib"

DrawEnding :: proc() {
  t := fmt.ctprintf("%s Reached", state.currentDelivery.destination)
  fSize : i32 = 60

  finalScore, letterGrade := state.CalculateScore(state.player, state.currentDelivery)
  scoreText := fmt.ctprintf("Final Score: %d     Delivery Grade: %s", finalScore, letterGrade)

  rl.DrawText(t, 640 - rl.MeasureText(t, fSize) / 2, 200, fSize, rl.WHITE)
  rl.DrawText(scoreText, 640 - rl.MeasureText(scoreText, fSize) / 2, 300, fSize, rl.WHITE)
}