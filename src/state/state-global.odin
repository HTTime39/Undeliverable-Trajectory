package state

import "core:os"
import "core:encoding/json"
import rl "vendor:raylib"

// Terminates the game loop when false
isRunning : bool = true

// The states the game can be in
GameState :: enum {
  TITLE, 
  DELIVERY_MENU,
  MAP,
  ENCOUNTER
}

// Current game state
gameState : GameState = GameState.TITLE

DecrementState :: proc() {
  gameState = GameState(int(gameState) - 1)
}

// The delivery selected at the start of the game
currentDelivery: Delivery

// --------------------------------------------------

// Contains all possible encounter nodes
encounterNodeList : []EncounterNode 
currentEncounter : EncounterNode

Item :: struct {
  name: cstring,
  modifier: f32
}

EncounterNode :: struct {
  title: cstring,
  descriptions: cstring,
  passPercentage: f32,
  passCount: int,
  modifiers: []Item, // Items that have a modifer on the encounter
  reward: []string, // Items and events that occur on passing the encounter
  fail: []string, // Events that occur when the encounter is failed
  consume: []string // Consumption events that trigger when attempting the encounter
}

LoadEncounterNodes :: proc() {
  data, readError := os.read_entire_file("data/encounterNodes.json", context.allocator)
  if readError == nil {
    defer delete(data)
  
    parseError := json.unmarshal(data, &encounterNodeList)

    if parseError != nil {
      deliveryList = []Delivery{{title = "Couldn't load deliveries", destination = "", payloads = {}, encounterLayers = 0}}
    }
  } else {
    deliveryList = []Delivery{{title = "Couldn't load deliveries", destination = "", payloads = {}, encounterLayers = 0}}
  }
}

// --------------------------------------------------

encounterBackgrounds : rl.Texture2D
encounterBGIndex := 0

playerSprite : rl.Texture2D