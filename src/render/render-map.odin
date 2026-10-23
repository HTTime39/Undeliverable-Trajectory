package render

import "../state"

import rl "vendor:raylib"
import "core:math"

HEXAGON_SIZE :: 75
ROW_OFFSET := []i32{460, 150}
TRIPLET_OFFSET := []i32{303, 603, 903}
TWIN_OFFSET := []i32{453, 753}
NODE_TITLE_FSIZE :: 24

// x and y components of vectors used to contruct hexagons
xCompF := math.round(f32(HEXAGON_SIZE) * 0.5) // 0.5 = cos(60)
xComp := i32(xCompF)
yCompF := math.round(f32(HEXAGON_SIZE) * 0.866025) // 0.866025 ~ sin(60)
yComp := i32(yCompF)

// x and y are the pixel coordinates of the top right corner of the hexigon
DrawHexagon :: proc(x: i32, y: i32, colour: rl.Color, sLength: i32, isFilled: bool) { 
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

DrawHexConnectors :: proc(currentLayerSize : i32, nextLayerSize : i32) {
  // Draws connecting lines between hexagons based on the number in the current and next node layers
  if currentLayerSize == 1 && nextLayerSize == 2 {
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[1]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TWIN_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TWIN_OFFSET[1]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
  } else if currentLayerSize == 2 && nextLayerSize == 3 {
    rl.DrawLineEx(
      rl.Vector2{f32(TWIN_OFFSET[0]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TWIN_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TWIN_OFFSET[1]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TWIN_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[2]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
  } else if currentLayerSize == 3 && nextLayerSize == 2 {
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TWIN_OFFSET[0]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[1]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TWIN_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TWIN_OFFSET[1]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[2]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TWIN_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
  } else if currentLayerSize == 2 && nextLayerSize == 1 {
    rl.DrawLineEx(
      rl.Vector2{f32(TWIN_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TWIN_OFFSET[1]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
  } else if currentLayerSize == 3 && nextLayerSize == 1 {
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[0]+HEXAGON_SIZE), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE/2), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE/2), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
    rl.DrawLineEx(
      rl.Vector2{f32(TRIPLET_OFFSET[2]), f32(ROW_OFFSET[0])}, 
      rl.Vector2{f32(TRIPLET_OFFSET[1]+HEXAGON_SIZE), f32(ROW_OFFSET[1]+2*yComp)}, 
      5, rl.WHITE)
  }
}

DrawNodeTitles :: proc() {
  for i in 0..<2 {
    for j in 0..<len(state.nodeMap[state.currentNodeLayer + i]) {
      textYOffset : i32
      if i == 1 { // In the top row
        textYOffset = ROW_OFFSET[i] - NODE_TITLE_FSIZE - 5

      } else { // In the bottom row
        textYOffset = ROW_OFFSET[i] + 5 + 2*yComp

      }

      if state.nodeMap[state.currentNodeLayer + i][j] == -1 { // Starting node
        rl.DrawText("START", TRIPLET_OFFSET[1] + (HEXAGON_SIZE - rl.MeasureText("START", NODE_TITLE_FSIZE))/2, textYOffset, NODE_TITLE_FSIZE, rl.WHITE)

      } else if state.nodeMap[state.currentNodeLayer + i][j] == -2 { // Ending node
        rl.DrawText(state.currentDelivery.destination, TRIPLET_OFFSET[1] + (HEXAGON_SIZE - rl.MeasureText(state.currentDelivery.destination, NODE_TITLE_FSIZE))/2, textYOffset, NODE_TITLE_FSIZE, rl.WHITE)
        
      } else { // All nodes that aren't the starting and ending nodes
        titleHalf := rl.MeasureText(state.encounterNodeList[state.nodeMap[state.currentNodeLayer + i][j]].title, NODE_TITLE_FSIZE)

        if len(state.nodeMap[state.currentNodeLayer + i]) == 2 { 
          // When the current node layer has 2 nodes
          rl.DrawText(state.encounterNodeList[state.nodeMap[state.currentNodeLayer + i][j]].title, TWIN_OFFSET[j] + (-titleHalf + HEXAGON_SIZE)/2, textYOffset, NODE_TITLE_FSIZE, rl.WHITE)

        } else {
          // All else, which is just when the node layer has 3 nodes
          rl.DrawText(state.encounterNodeList[state.nodeMap[state.currentNodeLayer + i][j]].title, TRIPLET_OFFSET[j] + (-titleHalf + HEXAGON_SIZE)/2, textYOffset, NODE_TITLE_FSIZE, rl.WHITE)
        }
      }
    }
  }
}

DrawMap :: proc() {
  DrawHexConnectors(i32(len(state.nodeMap[state.currentNodeLayer])), i32(len(state.nodeMap[state.currentNodeLayer + 1])))

  for i in 0..<2 {
    for j in 0..<len(state.nodeMap[state.currentNodeLayer + i]) {
      if len(state.nodeMap[state.currentNodeLayer + i]) == 2 { 
        // When the current node layer has 2 nodes
        DrawHexagon(TWIN_OFFSET[j], ROW_OFFSET[i], rl.PURPLE, HEXAGON_SIZE, true)

        if i == 1 && j == state.nextNodeSelection{
          DrawHexagon(TWIN_OFFSET[j], ROW_OFFSET[i], rl.YELLOW, HEXAGON_SIZE, true)
        }

      } else if len(state.nodeMap[state.currentNodeLayer + i]) == 3 { 
        // When the current node layer has 3 nodes
        DrawHexagon(TRIPLET_OFFSET[j], ROW_OFFSET[i], rl.PURPLE, HEXAGON_SIZE, true)
        
        if i == 1 && j == state.nextNodeSelection{
          DrawHexagon(TRIPLET_OFFSET[j], ROW_OFFSET[i], rl.YELLOW, HEXAGON_SIZE, true)
        }

      } else { 
        // When the current node layer has 1 node
        DrawHexagon(TRIPLET_OFFSET[1], ROW_OFFSET[i], rl.PURPLE, HEXAGON_SIZE, true)

        if i == 1 && j == state.nextNodeSelection{
          DrawHexagon(TRIPLET_OFFSET[1], ROW_OFFSET[i], rl.YELLOW, HEXAGON_SIZE, true)
        }
      }
    }
  }

  DrawNodeTitles()
}