package state

// Terminates the game loop when false
isRunning : bool = true

// The states the game can be in
GameState :: enum {
  TITLE, 
  DELIVERY_MENU,
  MAP,
}

// Current game state
gameState : GameState = GameState.TITLE

DecrementState :: proc() {
  gameState = GameState(int(gameState) - 1)
}