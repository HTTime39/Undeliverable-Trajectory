package input

import "../state"

import rl "vendor:raylib"

// Procedures for controlling the delivery menu
DeliveryMenuUp :: proc() { 
  // Move up menu list
  if state.selectedDelivery == 0 {
    state.selectedDelivery = len(state.deliveryList) - 1
  } else {
    state.selectedDelivery = abs((state.selectedDelivery - 1) % len(state.deliveryList))
  }
}

DeliveryMenuDown :: proc() {
  // Move down menu list
  state.selectedDelivery = abs((state.selectedDelivery + 1) % len(state.deliveryList))
}

DeliveryMenuEnter :: proc() {
  state.currentDelivery = state.deliveryList[state.selectedDelivery]
  state.gameState = .MAP
  state.selectedDelivery = 0
}

DELIVERY_BINDINGS:[6]Binding = {
  {.W, DeliveryMenuUp},
  {.UP, DeliveryMenuUp},
  {.S, DeliveryMenuDown},
  {.DOWN, DeliveryMenuDown},
  {.ENTER, DeliveryMenuEnter},
  {.BACKSPACE, state.DecrementState}
}

ControlDeliveryMenu :: proc() {
  for bind in DELIVERY_BINDINGS {
    if rl.IsKeyPressed(bind.key) do bind.action()
  }
}