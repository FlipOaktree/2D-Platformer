# Module 2, Lesson 8: Write Typed Horizontal Movement

**Status:** Validated

## By the end

Build the Player's horizontal movement script one part at a time. When you run
`main.tscn`, a temporary Player marker will move left with `A` or Left Arrow
and right with `D` or Right Arrow, then stop when you release the input.

This lesson adds only horizontal movement. Gravity, floor collision, jumping,
camera behavior, and player artwork will be added later.

## Before you start

- Module 2, Lesson 7 is complete.
- `res://actors/player.gd` is attached to the Player root and contains only
  `extends CharacterBody2D`.
- `main.tscn` contains one Player instance at Position `(128, 128)`.
- `res://actors/player.tscn` has the inherited `Visuals` attachment point.
- The Input Map contains the `move_left` and `move_right` actions from Lesson
  2.1.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Add a visible Player marker

1. Open `res://actors/player.tscn`.
2. In the **Scene** dock, select the inherited `Visuals` node.
3. Click **Add Child Node**, search for `Sprite2D`, and create it.
4. With the new `Sprite2D` selected, find **Texture** in the Inspector. Choose
   **Quick Load** and select `res://icon.svg`.
5. In the Inspector, expand **Transform** and set **Scale** to `(0.125, 0.125)`.
6. Leave the new `Sprite2D` at its default Position `(0, 0)` beneath `Visuals`.
7. Save the scene with `Ctrl+S`.

> 💡 This icon is a temporary visible marker for testing movement. It is not
> the Player's final artwork. The source icon is 1024 by 1024 pixels; a Scale
> of `(0.125, 0.125)` makes the marker 128 by 128 pixels, which keeps it easy
> to see during testing. Because it is beneath `Visuals`, it will inherit any
> later transform changes made to that branch.

> ⚠️ **If something differs**
>
> - If you cannot see `Visuals`, expand the inherited Actor nodes in the
>   **Scene** dock.
> - If the icon does not appear in the Texture picker, confirm that you chose
>   `res://icon.svg`, then save `player.tscn` before running the scene.

### Part 2: Add the movement speed

1. Open `res://actors/player.gd`.
2. Add a blank line beneath `extends CharacterBody2D`.
3. Add this typed variable:

   ```gdscript
   var speed: float = 300.0
   ```

4. Save the script with `Ctrl+S`.

> 💡 `speed` applies the variable syntax from Lesson 2.4 to the Player's
> movement speed. The `float` type matches the decimal values used for
> movement. Lesson 3.1 will make this value adjustable in the Inspector.

### Part 3: Add the physics callback

1. Add a blank line beneath the `speed` variable.
2. Add this function:

   ```gdscript
   func _physics_process(_delta: float) -> void:
       pass
   ```

`_physics_process()` is a callback Godot runs repeatedly at a steady rate. Each run is part of a physics update: a regular moment for handling movement, collisions, and other physics-related code for nodes such as the Player. Add code here when it needs to run continuously.

`_delta` is the time since the previous physics update. Don't worry about it for now, as we do not need it yet. The leading underscore marks it as unused.

> ⚠️ **If something differs**
>
> - If Godot marks the function as an error, check the colon after `void` and
>   confirm that `pass` is indented beneath the function line.

### Part 4: Read horizontal input

1. Delete the indented `pass` line.
2. In its place, add:

   ```gdscript
   var direction: float = Input.get_axis("move_left", "move_right")
   ```
`Input` is a built-in Godot tool for reading input from devices, such as a keyboard or controller. `get_axis()` is one of its methods. It reads two named movement actions passed in the parentheses and returns a number that represents their combined direction.

`Input.get_axis()` reads the negative action first and the positive action
second. With a keyboard or D-pad, left produces `-1.0`, right produces `1.0`,
and neither or both produces `0.0`. A controller stick can also produce values
between `-1.0` and `1.0`, so partially tilting it can produce a smaller value.

We place `Input.get_axis()` inside `_physics_process()` so it reads keyboard or controller input continuously.

> 💡 "move_left" and "move_right" are the Input Map action names you created in Lesson 2.1. Godot checks the keyboard and controller events assigned to those actions, rather than checking individual keys or buttons directly.

> ⚠️ **If something differs**
>
> - If Godot reports that `move_left` or `move_right` does not exist, check the
>   spelling in **Project → Project Settings → Input Map**. Action names are
>   case-sensitive.

### Part 5: Set the horizontal velocity and move the Player

1. Add this indented line beneath the `direction` variable:

   ```gdscript
   velocity.x = direction * speed
   ```

`velocity` is a built-in `CharacterBody2D` property that stores how fast and in which direction the Player should move. It is a `Vector2`: `velocity.x` is horizontal speed, and `velocity.y` is vertical speed. Setting `velocity.x` alone does not move the Player; `move_and_slide()` uses the velocity to move it and handle collisions.

2. Add this final indented line beneath `velocity.x = direction * speed`:

   ```gdscript
   move_and_slide()
   ```

`move_and_slide()` is a method provided by `CharacterBody2D`. Because the Player script extends `CharacterBody2D`, it can call this method directly—without writing `CharacterBody2D.` first. The method moves the body using its `velocity` and handles collisions when the body has collision geometry, so you do not have to code that behavior yourself.

3. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   var speed: float = 300.0

   func _physics_process(_delta: float) -> void:
       var direction: float = Input.get_axis("move_left", "move_right")
       velocity.x = direction * speed
       move_and_slide()
   ```

4. Save the script with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If the script editor shows an error, compare every indentation level and
>   punctuation mark with the completed script, then save again.

### Part 6: Run and test horizontal movement

1. Open `res://scenes/main.tscn`.
2. In the **Scene** dock, select `ProjectIcon`, delete it, and save
   `main.tscn` with `Ctrl+S`.
3. Run the current scene with `F6`.
4. Hold `A` or Left Arrow and confirm that the temporary Player marker moves
   left.
5. Hold `D` or Right Arrow and confirm that the marker moves right.
6. Release the input and confirm that the marker stops.
7. If a compatible controller is connected, test its configured D-pad and left
   stick directions too.
8. Confirm that `Project ready` still appears and that the Player marker is
   the only icon on screen.
9. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player does not move, confirm that `player.gd` is attached to the
>   Player root, the script was saved, and both action names match the Input
>   Map exactly.
> - If the Player moves vertically, check that the assignment is `velocity.x`,
>   not `velocity.y` or `velocity`.
> - If no marker is visible, open `player.tscn` and confirm that the `Sprite2D`
>   is beneath `Visuals` and has `res://icon.svg` assigned as its Texture.

## Learner exercise

1. Change `speed` from `300.0` to `150.0`.
2. Run `main.tscn` and compare the slower movement.
3. Restore `speed` to `300.0`, save, and run the scene once more.
4. Explain why the speed currently belongs to Player rather than Actor.

## Verification checklist

- [ ] `res://actors/player.gd` remains attached to the Player root.
- [ ] The script extends `CharacterBody2D`.
- [ ] The script uses typed `speed`, `_delta`, `direction`, and a `void` return
      type.
- [ ] `Input.get_axis()` uses the exact `move_left` and `move_right` action
      names.
- [ ] The script assigns horizontal velocity through `velocity.x` and calls
      `move_and_slide()`.
- [ ] A `Sprite2D` with `res://icon.svg` is beneath the Player's `Visuals`
      node as a temporary test marker.
- [ ] `A`/Left Arrow moves the Player left, and `D`/Right Arrow moves it right.
- [ ] Releasing the input stops horizontal movement.
- [ ] Configured controller movement works when a compatible controller is
      available.
- [ ] `Project ready` still appears, and the Player marker is the only icon on
      screen when `main.tscn` runs.
- [ ] The speed exercise ends with `speed` restored to `300.0`.
- [ ] The Player has no gravity, jumping, camera, or final artwork yet.

## References

- [Using CharacterBody2D/3D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
