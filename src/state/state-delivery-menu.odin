package state

import "core:os"
import "core:encoding/json"

deliveryList : []Delivery

selectedDelivery := 0

currentDelivery: Delivery

Payload :: struct {
  name: cstring,
  size: cstring,
  weight: f32
}

Delivery :: struct {
  title: cstring,
  destination: cstring,
  payloads: []Payload,
  small: int,
  medium: int,
  large: int,
  encounterLayers: int
}

// Load and retain the data of this menu here
LoadDeliveriesData :: proc() {
  data, readError := os.read_entire_file("data/deliveries.json", context.allocator)
  if readError == nil {
    defer delete(data)
  
    parseError := json.unmarshal(data, &deliveryList)

    if parseError != nil {
      deliveryList = []Delivery{{title = "Couldn't load deliveries", destination = "", payloads = {}, encounterLayers = 0}}
    }
  } else {
    deliveryList = []Delivery{{title = "Couldn't load deliveries", destination = "", payloads = {}, encounterLayers = 0}}
  }
}