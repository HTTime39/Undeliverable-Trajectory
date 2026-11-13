package state

import "core:os"
import "core:encoding/json"
import rl "vendor:raylib"

// Terminates the game loop when false
isRunning : bool = true
isAnimating : bool = true

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

Event :: struct {
  name : string,
  amount : int,
}

EncounterNode :: struct {
  title: cstring,
  description: cstring,
  passPercentage: f32,
  passCount: int,
  modifiers: []Item, // Items that have a modifer on the encounter
  reward: []Event, // Items and events that occur on passing the encounter
  fail: []Event, // Events that occur when the encounter is failed
  consume: []Event, // Consumption events that trigger when attempting the encounter
  image: string // Name of the .png file associated with something that should be displayed in this encounter
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

// Contains all possible items, referenceable as a map
itemDictionary : map[string]ItemBagInfo

LoadItemDictionary :: proc() {
  data, readError := os.read_entire_file("data/payloads.json", context.allocator)
  if readError == nil {
    defer delete(data)
  
    parseError := json.unmarshal(data, &itemDictionary)

    if parseError != nil {
      itemDictionary["Couldn't load item dictionary"] = {size = "s", weight = 0.0}
    }
  } else {
    itemDictionary["Couldn't load item dictionary"] = {size = "s", weight = 0.0}
  }
}

// --------------------------------------------------

// Texture maps
encounterBackgrounds : rl.Texture2D
encounterBGIndex := 0

playerSprite : rl.Texture2D

// --------------------------------------------------

ItemBagInfo :: struct {
  size: cstring,
  weight: f32
}

PlayerState :: struct {
  hp : int,
  stamina : int,
  bagCapacity : f32,
  bagVolume : int, 
  bag : [dynamic]Payload, // Payloads make reference to item names to retrieve an associated modifier
}

player : PlayerState = {
  100,
  100,
  20.0,
  8,
  [dynamic]Payload{}
}