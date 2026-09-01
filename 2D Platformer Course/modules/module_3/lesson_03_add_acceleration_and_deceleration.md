# Module 3, Lesson 3: Add Acceleration and Deceleration

**Status:** Blueprint drafted

## By the end

Apply the target-based movement model from Lesson 3.2 to replace the Player's
instant horizontal starts and stops with configurable acceleration and
deceleration. Maximum speed will remain unchanged, while the Player will take
a short, visible amount of time to reach that speed and stop after input is
released.

- **Acceleration** defaults to `1200.0` pixels per second squared.
- **Deceleration** defaults to `1800.0` pixels per second squared.
- Both settings appear in the Player Inspector with documentation tooltips and
  safe ranges from `100.0` to `5000.0` in steps of `100.0`.
- Horizontal movement becomes smoother without changing gravity, floor
  collision, or grounded jumping.

## Before you start

- Module 3, Lesson 2 is complete.
- You can distinguish current velocity, target velocity, maximum speed,
  acceleration, and deceleration.
- You can identify the three arguments passed to `move_toward()` and explain
  why its returned value must be assigned.
- `res://actors/player.gd` contains the exported `speed`, `gravity`, and
  `jump_velocity` settings with their validated defaults.
- `_physics_process()` assigns `direction * speed` directly to `velocity.x`.
- `main.tscn` contains the Player and temporary Floor, and the validated
  movement and grounded jump work.

## Build steps

### Part 1: Confirm the instant movement baseline

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Hold `D` or Right Arrow and observe that the Player reaches full horizontal
   speed immediately.
3. Release the input and observe that the Player stops immediately.
4. Hold one direction, then quickly press the opposite direction. Observe that
   the Player reverses immediately.
5. Confirm that falling, landing, and grounded jumping still work.
6. If a compatible controller is connected, repeat the movement and jump
   checks with its configured inputs.
7. Stop the scene with `F8`.

This is the working baseline. The lesson will change how `velocity.x`
approaches a target without changing the maximum `speed` or vertical physics.

> ⚠️ **If something differs**
>
> - If the Player already starts or stops gradually, compare `player.gd` with
>   the completed Lesson 3.1 script before continuing.
> - If movement, falling, or jumping fails, return to the relevant earlier
>   verification before adding another behavior.

### Part 2: Add acceleration and deceleration settings

1. Open `res://actors/player.gd`.
2. Immediately below the `speed` declaration, add:

   ```gdscript
   ## How quickly horizontal speed increases toward its target.
   @export_range(100.0, 5000.0, 100.0)
   var acceleration: float = 1200.0

   ## How quickly horizontal speed decreases after input is released.
   @export_range(100.0, 5000.0, 100.0)
   var deceleration: float = 1800.0
   ```

The minimum is `100.0` so neither setting can disable its behavior and leave
the Player unable to start or stop. Deceleration starts higher than
acceleration so the Player gains speed smoothly but still stops promptly.

3. Save `player.gd` with `Ctrl+S`.
4. Open `res://actors/player.tscn` and select the Player root.
5. Confirm that **Acceleration** displays `1200.0` and **Deceleration** displays
   `1800.0` in the Inspector.
6. Hover over both properties and confirm that their tooltips describe
   increasing speed and stopping.
7. Confirm that both controls remain between `100.0` and `5000.0` and change
   in steps of `100.0`.

> ⚠️ **If something differs**
>
> - If a setting does not appear, confirm that its documentation comment,
>   annotation, and variable remain together at script-level scope.
> - If an Inspector value differs from the declared default, use the property's
>   revert button so the Player source scene uses the script default.

### Part 3: Apply target-based horizontal movement

1. In `_physics_process()`, locate:

   ```gdscript
   var direction: float = Input.get_axis("move_left", "move_right")
   velocity.x = direction * speed
   ```

2. Keep the `direction` line and replace the direct `velocity.x` assignment
   with:

   ```gdscript
   var target_speed: float = direction * speed

   if direction != 0.0:
       velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
   else:
       velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)
   ```

As traced in Lesson 3.2, the first branch moves current horizontal velocity
toward the input target. Without input, the second branch moves it toward
`0.0`. Multiplying each rate by `delta` limits the change for this physics
update.

3. Compare the completed script with this version:

   ```gdscript
   extends CharacterBody2D

   ## Maximum horizontal movement speed in pixels per second.
   @export_range(0.0, 1000.0, 10.0)
   var speed: float = 300.0

   ## How quickly horizontal speed increases toward its target.
   @export_range(100.0, 5000.0, 100.0)
   var acceleration: float = 1200.0

   ## How quickly horizontal speed decreases after input is released.
   @export_range(100.0, 5000.0, 100.0)
   var deceleration: float = 1800.0

   ## Downward acceleration in pixels per second squared.
   @export_range(0.0, 3000.0, 10.0)
   var gravity: float = 980.0

   ## Upward velocity applied when a grounded jump begins.
   @export_range(-1000.0, 0.0, 10.0)
   var jump_velocity: float = -400.0

   func _physics_process(delta: float) -> void:
       # Prevent another jump from starting while the Player is airborne.
       if Input.is_action_just_pressed("jump") and is_on_floor():
           velocity.y = jump_velocity

       # Skip gravity while the Player is grounded.
       if not is_on_floor():
           velocity.y += gravity * delta

       var direction: float = Input.get_axis("move_left", "move_right")
       var target_speed: float = direction * speed

       if direction != 0.0:
           velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
       else:
           velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)

       move_and_slide()
   ```

4. Confirm that the existing defaults, comments, vertical calculations, input
   action names, and `move_and_slide()` call remain unchanged.
5. Save the script and run `main.tscn`.
6. Hold a horizontal direction and confirm that the Player takes a short time
   to reach full speed.
7. Release the input and confirm that the Player travels a short additional
   distance while slowing to a complete stop.
8. Test a quick direction change and confirm that horizontal velocity changes
   smoothly instead of reversing instantly.
9. Confirm that the Player still falls, lands, and jumps only while grounded.
10. If a compatible controller is connected, repeat the movement and jump
    checks with its configured inputs.
11. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player never starts moving, confirm that the input branch uses
>   `velocity.x`, `target_speed`, and `acceleration * delta` in that order.
> - If the Player never stops, confirm that the `else` branch targets `0.0`
>   and uses `deceleration * delta`.
> - If the Player stops instantly, confirm that the old direct
>   `velocity.x = 0.0` assignment is absent.
> - If vertical behavior changes, compare the jump and gravity sections with
>   the completed code block; this lesson changes only horizontal movement.

### Part 4: Tune the two rates

1. Open `res://actors/player.tscn` and select the Player root.
2. Change **Acceleration** from `1200.0` to `600.0`.
3. Run `main.tscn` and confirm that reaching the same maximum speed takes
   longer.
4. Restore **Acceleration** to `1200.0` and save `player.tscn`.
5. Change **Deceleration** from `1800.0` to `600.0`.
6. Run `main.tscn` and confirm that the Player slides farther after input is
   released.
7. Restore **Deceleration** to `1800.0`, save, and run the scene again.
8. Confirm that the default response has returned and that gravity and
   grounded jumping still work.

Changing acceleration affects how long the Player takes to reach the target;
it does not change the target itself. Changing deceleration affects stopping
after input is released. The two settings can be tuned independently without
rewriting movement code.

> ⚠️ **If something differs**
>
> - If changing Acceleration changes the final maximum speed, confirm that
>   `target_speed` still uses `direction * speed`.
> - If the final test still uses a temporary value, restore both settings on
>   the Player source scene and save it before running again.

## Learner exercise

Without editing `player.gd`:

1. Change **Deceleration** from `1800.0` to `900.0` in the Player Inspector.
2. Predict how the change will affect stopping distance.
3. Run `main.tscn`, gain horizontal speed, release the input, and check the
   prediction.
4. Explain why this change does not alter maximum `speed` or jump height.
5. Restore **Deceleration** to `1800.0`, save `player.tscn`, and verify the
   default response again.
6. Explain the separate roles of `speed`, `target_speed`, `acceleration`, and
   `deceleration`.

## Verification checklist

- [ ] `speed`, `gravity`, and `jump_velocity` retain their validated defaults.
- [ ] `acceleration` is an exported `float` with default `1200.0`.
- [ ] `deceleration` is an exported `float` with default `1800.0`.
- [ ] Both new settings use a range of `100.0` through `5000.0` in steps of
      `100.0` and have useful documentation tooltips.
- [ ] `target_speed` is a typed local `float` calculated from
      `direction * speed`.
- [ ] Horizontal input moves `velocity.x` toward `target_speed` using
      `acceleration * delta`.
- [ ] Releasing horizontal input moves `velocity.x` toward `0.0` using
      `deceleration * delta`.
- [ ] `move_and_slide()` remains after all velocity calculations.
- [ ] The Player accelerates, decelerates to a complete stop, and reverses
      direction smoothly.
- [ ] Maximum horizontal speed remains controlled by `speed`.
- [ ] Falling, landing, floor collision, and grounded jumping still work.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] All tuning exercises end with defaults `1200.0` and `1800.0` restored.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors,
      or unexplained warnings.
- [ ] The learner can explain how the implementation applies the target-based
      model traced in Lesson 3.2.

## References

- [GlobalScope `move_toward()`](https://docs.godotengine.org/en/4.7/classes/class_%40globalscope.html#class-globalscope-method-move-toward)
- [GDScript exported properties](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_exports.html)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
