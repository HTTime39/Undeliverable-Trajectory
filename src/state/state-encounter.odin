package state

bagSelected := 0
usingItems : [dynamic]bool // These are the items that will get used, indices

ClearUsingItems :: proc() {
  for i in 0..<len(player.bag) {
    append(&usingItems, false)
  }
}