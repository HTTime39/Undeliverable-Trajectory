package render

import rl "vendor:raylib"
import "core:math"

DrawHexigon :: proc(x: i32, y: i32, colour: rl.Color, sLength: i32, isFilled: bool) { // x and y are the pixel coordinates of the top right corner of the hexigon
  xCompF := math.round(f32(sLength) * 0.5) // 0.5 = cos(60)
  xComp := i32(xCompF)
  yCompF := math.round(f32(sLength) * 0.866025)
  yComp := i32(yCompF)
  
  rl.DrawLine(x, y, x+sLength, y, colour) // Top, wind clockwise
  rl.DrawLine(x+sLength, y, x+sLength+xComp, y+yComp, colour)
  rl.DrawLine(x+sLength+xComp, y+yComp, x+sLength, y+2*yComp, colour)
  rl.DrawLine(x+sLength, y+2*yComp, x, y+2*yComp, colour)
  rl.DrawLine(x, y+2*yComp, x-xComp, y+yComp, colour)
  rl.DrawLine(x-xComp, y+yComp, x, y, colour)

  if isFilled {
    rl.DrawRectangle(x, y, sLength, 2*yComp, colour)
    rl.DrawRectanglePro(rl.Rectangle{x = f32(x+sLength), y = f32(y), width = f32(sLength), height = f32(2*yComp)}, rl.Vector2{f32(0), f32(0)}, 60, colour)
    rl.DrawRectanglePro(rl.Rectangle{x = f32(x-xComp), y = f32(y+yComp), width = f32(sLength), height = f32(2*yComp)}, rl.Vector2{f32(0), f32(0)}, -60, colour)
  }
}

DrawMap :: proc() {
  DrawHexigon(100, 100, rl.PURPLE, 75, false)
}