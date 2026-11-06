package input

import "../state"

import "core:slice"
import rl "vendor:raylib"

ENCOUNTER_BINDINGS:[]Binding = {
  {.BACKSPACE, state.DecrementState},
  {.W, InventorySelectUp},
  {.UP, InventorySelectUp},
  {.S, InventorySelectDown},
  {.DOWN, InventorySelectDown},
  {.SPACE, InventoryAddToUse},
  {.ENTER, Temp}
}

Temp :: proc() {
  if state.currentLayerIndex != 9 {
    state.gameState = .MAP
  }
}

InventorySelectUp :: proc() {
  if state.bagSelected == 0 {
    state.bagSelected = len(state.player.bag) - 1
  } else {
    state.bagSelected = abs((state.bagSelected - 1) % len(state.player.bag))
  }
}

InventorySelectDown :: proc() {
  state.bagSelected = (state.bagSelected + 1) % len(state.player.bag)
}

InventoryAddToUse :: proc() {
  state.usingItems[state.bagSelected] = !state.usingItems[state.bagSelected]
}

ControlEncounter :: proc() {
  for bind in ENCOUNTER_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}