package render

import "../state"

import "core:fmt"
import rl "vendor:raylib"

DrawDeliveryMenu :: proc() {
  xOffset: i32 = 30
  for i in 0..<len(state.deliveryList) {
    yOffset: i32 = 120*i32(i)
    fontColour := rl.WHITE
    borderColour := rl.WHITE
    if state.selectedDelivery == i {
      fontColour = rl.YELLOW
      borderColour = rl.PURPLE
    }

    rl.DrawText(state.deliveryList[i].title, xOffset, i32(20 + yOffset), 32, fontColour)
    rl.DrawText(
      fmt.ctprintf("to %s", state.deliveryList[i].destination), 
      xOffset, 52 + yOffset, 24, fontColour
    )
    rl.DrawText(
      fmt.ctprintf("Payloads:   S:%d   M:%d   L:%d", state.deliveryList[i].small, state.deliveryList[i].medium, state.deliveryList[i].large), 
      xOffset, 76 + yOffset, 24, fontColour
    )
    rl.DrawText(
      fmt.ctprintf("Distance: %d nodes", state.deliveryList[i].encounterLayers),
      xOffset, 100 + yOffset, 24, fontColour
    )

    rl.DrawLine(15, 10 + yOffset, 1265, 10 + yOffset, borderColour)
    rl.DrawLine(15, 126 + yOffset, 1265, 126 + yOffset, borderColour)

  }
}