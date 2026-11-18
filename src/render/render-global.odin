package render

import "../state"

import "core:fmt"
import rl "vendor:raylib"

DrawStatus :: proc() {
  rl.DrawRectangle(0, 0, 410, 80, rl.BLACK)
  rl.DrawRectanglePro(
    rl.Rectangle{370, 40, 115, 60},
    rl.Vector2{0, 0},
    -45,
    rl.BLACK
  )
  rl.DrawRectangle(0, 78, 410, 2, rl.YELLOW)
  rl.DrawRectanglePro(
    rl.Rectangle{400, 83, 130, 3},
    rl.Vector2{0, 0},
    -45,
    rl.YELLOW
  )
  rl.DrawRectangle(0, 80, 410, 10, rl.PURPLE)
  rl.DrawRectanglePro(
    rl.Rectangle{403, 83, 130, 10},
    rl.Vector2{0, 0},
    -45,
    rl.PURPLE
  )

  fSize : i32 = 18
  yOffset : i32 = 8

  rl.DrawText("HP", 10, yOffset, fSize, rl.WHITE)
  rl.DrawRectangle(45, yOffset + 2, 200, 10, rl.GRAY)
  rl.DrawRectangle(45, yOffset + 2, i32(200*state.player.cHp/state.player.hp), 10, rl.GREEN)

  rl.DrawText("ST", 10, 2*yOffset + 16, fSize, rl.WHITE)
  rl.DrawRectangle(45, 2*yOffset + 18, 200, 10, rl.GRAY)
  rl.DrawRectangle(45, 2*yOffset + 18, i32(200*state.player.cStamina/state.player.stamina), 10, rl.YELLOW)

  rl.DrawText("PS", 10, 3*yOffset + 32, fSize, rl.WHITE)
  rl.DrawRectangle(45, 3*yOffset + 34, 200, 10, rl.GRAY)
  rl.DrawRectangle(45, 3*yOffset + 34, i32(200*state.player.cCargoStatus/state.player.cargoStatus), 10, rl.PINK)

  w, v := state.GetBagInfo(state.player)

  rl.DrawText(fmt.ctprintf("Weight %.1f / %.1f kg", w, state.player.bagCapacity), 265, yOffset, fSize, rl.WHITE)
  rl.DrawText(fmt.ctprintf("Volume %d / %d", v, state.player.bagVolume), 265, 2*yOffset+16, fSize, rl.WHITE)
}