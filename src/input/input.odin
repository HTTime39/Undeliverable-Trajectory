package input

import rl "vendor:raylib"

Binding :: struct {
  key: rl.KeyboardKey,
  action: proc()
}