# Module 2, Lesson 5: Write Typed Horizontal Movement

**Status:** Blueprint drafted

## By the end

Create a typed GDScript file for `Player` that reads the existing left and
right actions and moves the Player horizontally. When you run `main.tscn`, the
Player collision outline will move left with `A` or Left Arrow and right with
`D` or Right Arrow, then stop when you release the input.

This lesson adds only horizontal movement. Gravity, floor collision, jumping,
camera behavior, and player artwork will be added later.

## Before you start

- Module 2, Lesson 4 is complete.
- `res://actors/player.tscn` inherits from `res://actors/actor.tscn`.
- `main.tscn` contains one Player instance at Position `(128, 128)`.
- The Input Map contains the `move_left` and `move_right` actions from Lesson
  2.1.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Attach a script to Player

1. Open `res://actors/player.tscn`.
2. In the Scene dock, select the `Player` root node.
3. Select **Attach Script** from the Scene dock toolbar, or right-click
   `Player` and select **Attach Script**.
4. In the Create Script dialog, keep **Language** set to **GDScript** and set
   **Path** to `res://actors/player.gd`.
5. Select **Create**.
6. In the script editor, replace any generated text with:

   ```gdscript
   extends CharacterBody2D

   const SPEED: float = 300.0

   func _physics_process(_delta: float) -> void:
       var direction: float = Input.get_axis("move_left", "move_right")
       velocity.x = direction * SPEED
       move_and_slide()
   ```

7. Save the script with `Ctrl+S`.

> 💡 A script extends the behavior of the node it is attached to. This script
> belongs on `Player`, not shared `Actor`, because only the player should read
> the player's controls. `CharacterBody2D` provides the `velocity` property and
> `move_and_slide()` method used below.

> 💡 `func` starts a function: a named group of instructions. Functions use
> indentation to group their instructions. `_physics_process()` is a Godot
> callback: the engine calls it during each physics update. `const` creates a
> named value that should not change while the game runs, so `SPEED` is a typed
> constant. `_physics_process()` returns no value (`-> void`), and `direction`
> is a typed local variable. The underscore in `_delta` says that this required
> callback parameter is intentionally unused in this lesson.

> ⚠️ **If something differs**
>
> - If the script is attached to `Actor`, remove it from `Actor` and attach it
>   to the `Player` root instead. Shared Actor must remain free of
>   player-specific controls.
> - If Godot reports that `move_left` or `move_right` does not exist, check the
>   spelling in **Project → Project Settings → Input Map**. Action names are
>   case-sensitive.
> - If the script editor shows an error, compare every indentation level and
>   punctuation mark with the code above, then save again.

### Part 2: Understand the movement code

1. Read the `Input.get_axis("move_left", "move_right")` line.
2. Hold the left action to produce a direction from `-1.0` toward `0.0`, hold
   the right action to produce a direction from `0.0` toward `1.0`, and release
   both actions to produce `0.0`.
3. Read `velocity.x = direction * SPEED`. It sets only horizontal velocity, so
   the later gravity lesson can use `velocity.y` without replacing this line.
4. Read `move_and_slide()`. It asks `CharacterBody2D` to move using its
   velocity and handle collisions when collision geometry is added.

> 💡 `Input.get_axis()` reads named actions rather than individual keys or
> controller buttons. Lesson 2.1 mapped both input devices to the same actions,
> so this one line supports either device. `SPEED` is a constant for now so the
> first script stays focused; Lesson 3.1 will expose safe movement settings in
> the Inspector.

### Part 3: Run and test horizontal movement

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

1. Change `SPEED` from `300.0` to `150.0`.
2. Run `main.tscn` and compare the slower movement.
3. Restore `SPEED` to `300.0`, save, and run the scene once more.
4. Explain why the speed currently belongs to Player rather than Actor, and why
   it is kept as a constant until the later movement-settings lesson.

## Verification checklist

- [ ] `res://actors/player.gd` exists and is attached to the Player root.
- [ ] The script extends `CharacterBody2D`.
- [ ] The script uses typed `SPEED`, `_delta`, `direction`, and a `void` return
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
- [ ] The speed exercise ends with `SPEED` restored to `300.0`.
- [ ] The Player has no gravity, jumping, camera, or artwork behavior yet.

## References

- [Using CharacterBody2D/3D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
