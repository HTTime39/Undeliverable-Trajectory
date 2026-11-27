package state

rewardSelected := 0

CalculateScore :: proc(p:PlayerState, delivery:Delivery) -> (int, string) {
  hSegment := min(1.0, f32(p.cHp)/(f32(p.hp)/2)) * 100
  // Health segment starts with base score of 100
  // Score is lost for player health below 50% of their max hp
  // This scales linearly, so if base health is 100, each 1% below 50% subtract 2 score

  cSizeMult : f32 = 1.0 + f32(delivery.small)*0.1 + f32(delivery.medium)*0.3 + f32(delivery.large)*0.8
  // Score multiplier is gained for each package and its size
  // More score is added for larger packages incentivizing them over smaller packages

  cSegment := min(1.0, f32(p.cCargoStatus)/80) * cSizeMult * 250
  // The size multiplier is applied to the cargo status
  // Base score penalty is only incurred when cargo status falls below 80%
  // There is a base score of 250 that is raised and lowered by the modifiers

  totalScore := int(hSegment + cSegment)

  letterScore := "F"

  if totalScore > 500 {
    letterScore = "S"
  } else if totalScore > 400 {
    letterScore = "A"
  } else if totalScore > 300 {
    letterScore = "B"
  } else if totalScore > 200 {
    letterScore = "C"
  } else if totalScore > 100 {
    letterScore = "D"
  }

  return totalScore, letterScore
}

EndingSelectUp :: proc() {
  if rewardSelected == 0 {
    rewardSelected = 3
  } else {
    rewardSelected -= 1
  }
}

EndingSelectDown :: proc() {
  if rewardSelected == 3 {
    rewardSelected = 0
  } else {
    rewardSelected += 1
  }
}

HandleSelectedReward :: proc() {
  switch rewardSelected {
    case 0:
      player.hp += 15
    case 1: 
      player.stamina += 15
    case 2:
      player.bagCapacity += 15
    case 3: player.bagVolume += 1
  }
  rewardSelected = 0
}

EndingEnter :: proc() {
  HandleSelectedReward()
  ResetPlayer()
  SavePlayerState(player)
  gameState = .TITLE
}