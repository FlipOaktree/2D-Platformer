# Module 2, Lesson 7: Write Typed Horizontal Movement

**Status:** Blueprint drafted

## By the end

Build the Player's horizontal movement script one part at a time. When you run
`main.tscn`, the Player collision outline will move left with `A` or Left Arrow
and right with `D` or Right Arrow, then stop when you release the input.

This lesson adds only horizontal movement. Gravity, floor collision, jumping,
camera behavior, and player artwork will be added later.

## Before you start

- Module 2, Lesson 6 is complete.
- `res://actors/player.gd` is attached to the Player root and contains only
  `extends CharacterBody2D`.
- `main.tscn` contains one Player instance at Position `(128, 128)`.
- The Input Map contains the `move_left` and `move_right` actions from Lesson
  2.1.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Add the movement speed

1. Open `res://actors/player.gd`.
2. Add a blank line beneath `extends CharacterBody2D`.
3. Add this typed variable:

   ```gdscript
   var speed: float = 300.0
   ```

4. Save the script with `Ctrl+S`.

> 💡 `var` creates a value that code can read or change later. `speed` gives
> the Player's movement speed one clear name, and the `float` type matches the
> decimal values used for movement. A later gameplay feature can change
> `speed` when needed. Lesson 3.1 will make this variable adjustable in the
> Inspector.

### Part 2: Add the physics callback

1. Add a blank line beneath the `speed` variable.
2. Add this function:

   ```gdscript
   func _physics_process(_delta: float) -> void:
       pass
   ```

> 💡 `_physics_process()` is a Godot callback that runs at a steady rate
> for physics updates. A **parameter** is a value a function receives when it
> runs. Godot provides `_delta`, the time since the previous physics update.
> This lesson does not need that value yet, so the leading underscore marks it
> as intentionally unused. The temporary `pass` keeps the function valid until
> you add its movement instructions.

> ⚠️ **If something differs**
>
> - If Godot marks the function as an error, check the colon after `void` and
>   confirm that `pass` is indented beneath the function line.

### Part 3: Read horizontal input

1. Delete the indented `pass` line.
2. In its place, add:

   ```gdscript
   var direction: float = Input.get_axis("move_left", "move_right")
   ```

`Input.get_axis()` reads the negative action first and the positive action
second. With a keyboard or D-pad, left produces `-1.0`, right produces `1.0`,
and neither produces `0.0`. A controller stick can also produce decimal values
between `-1.0` and `1.0`, so partially tilting it can produce a smaller value.

> 💡 `Input.get_axis()` reads named actions rather than individual keys
> or controller buttons. Lesson 2.1 mapped both input devices to the same
> actions, so this one line supports either device. `direction` is a typed
> local variable because it is declared inside `_physics_process()`.

> ⚠️ **If something differs**
>
> - If Godot reports that `move_left` or `move_right` does not exist, check the
>   spelling in **Project → Project Settings → Input Map**. Action names are
>   case-sensitive.

### Part 4: Set the horizontal velocity

1. Add this indented line beneath the `direction` variable:

   ```gdscript
   velocity.x = direction * speed
   ```

`CharacterBody2D` provides the `velocity` property. This line changes only its
horizontal X value. The later gravity lesson can therefore use `velocity.y`
without replacing the horizontal movement.

### Part 5: Move the Player

1. Add this final indented line:

   ```gdscript
   move_and_slide()
   ```

`move_and_slide()` asks `CharacterBody2D` to move using its velocity and handle
collisions when collision geometry is added.

2. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   var speed: float = 300.0

   func _physics_process(_delta: float) -> void:
       var direction: float = Input.get_axis("move_left", "move_right")
       velocity.x = direction * speed
       move_and_slide()
   ```

3. Save the script with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If the script editor shows an error, compare every indentation level and
>   punctuation mark with the completed script, then save again.

### Part 6: Run and test horizontal movement

1. Open `res://scenes/main.tscn`.
2. In the top editor menu bar, enable **Debug → Visible Collision Shapes**.
3. Run the current scene with `F6`.
4. Hold `A` or Left Arrow and confirm that the Player collision outline moves
   left.
5. Hold `D` or Right Arrow and confirm that it moves right.
6. Release the input and confirm that the outline stops.
7. If a compatible controller is connected, test its configured D-pad and left
   stick directions too.
8. Confirm that `Project ready` and the project icon still appear.
9. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player does not move, confirm that `player.gd` is attached to the
>   Player root, the script was saved, and both action names match the Input
>   Map exactly.
> - If the Player moves vertically, check that the assignment is `velocity.x`,
>   not `velocity.y` or `velocity`.
> - If no outline is visible, confirm that **Visible Collision Shapes** is
>   enabled and that Player still has its inherited `CollisionShape2D`.

## Learner exercise

1. Change `speed` from `300.0` to `150.0`.
2. Run `main.tscn` and compare the slower movement.
3. Restore `speed` to `300.0`, save, and run the scene once more.
4. Explain why the speed currently belongs to Player rather than Actor, and why
   a variable is useful when a later gameplay feature needs to change it.

## Verification checklist

- [ ] `res://actors/player.gd` remains attached to the Player root.
- [ ] The script extends `CharacterBody2D`.
- [ ] The script uses typed `speed`, `_delta`, `direction`, and a `void` return
      type.
- [ ] `Input.get_axis()` uses the exact `move_left` and `move_right` action
      names.
- [ ] The script assigns horizontal velocity through `velocity.x` and calls
      `move_and_slide()`.
- [ ] `A`/Left Arrow moves the Player left, and `D`/Right Arrow moves it right.
- [ ] Releasing the input stops horizontal movement.
- [ ] Configured controller movement works when a compatible controller is
      available.
- [ ] `Project ready` and the project icon still appear when `main.tscn` runs.
- [ ] The speed exercise ends with `speed` restored to `300.0`.
- [ ] The Player has no gravity, jumping, camera, or artwork behavior yet.

## References

- [Using CharacterBody2D/3D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
