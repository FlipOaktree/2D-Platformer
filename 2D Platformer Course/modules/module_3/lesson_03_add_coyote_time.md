# Module 3, Lesson 3: Add Coyote Time

**Status:** Validated

## By the end

Give the Player a short grace period for jumping after walking off a ledge.
The Player will still jump normally from the floor, but a slightly late button
press will feel more forgiving.

- **Coyote Time** defaults to `0.1` seconds.
- The setting appears in the Player Inspector with a documentation tooltip and
  a safe range from `0.0` to `0.5` seconds in steps of `0.01`.
- A script-level countdown tracks the remaining grace time.
- A raised `CoyoteTestPlatform` provides a repeatable ledge while the original
  temporary Floor remains below it as a safe landing surface.

## Before you start

- Module 3, Lesson 2 is complete and validated.
- `res://actors/player.gd` contains the validated exported movement settings,
  target-based horizontal movement, gravity, and grounded jump.
- `main.tscn` contains the Player and the temporary full-width Floor.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Create a raised coyote test platform

1. Open `res://scenes/main.tscn`.
2. Select the `Floor` root and duplicate it with `Ctrl+D`.
3. Rename the duplicate `CoyoteTestPlatform` with `F2`.
4. With `CoyoteTestPlatform` selected, set its Position to `(576, 470)`.
5. Select `CoyoteTestPlatform/CollisionShape2D`. In the Inspector, open the
   menu beside **Shape** and choose **New RectangleShape2D**.
6. Select the new rectangle resource and set its Size to `(320, 32)`.
7. Confirm that `CoyoteTestPlatform/CollisionShape2D` remains at local
   Position `(0, 0)`.
8. Select the original `Floor` and confirm that it still has Position
   `(576, 560)` and its 1152-by-64 rectangle shape.
9. Save `main.tscn` with `Ctrl+S`.
10. In the editor's **Debug** menu, confirm that **Visible Collision Shapes** is
   enabled.
11. Run the current scene with `F6` and let the Player land on the original
    Floor.
12. Move to either side of the raised platform, then jump while moving toward
    it to land on top.
13. Walk off either edge of the raised collision outline, then press the jump
    button immediately afterward.
14. Confirm that the Player does not jump once it has left the platform and
    lands safely on the original Floor below, then stop the scene with `F8`.

> 💡 **Coyote time** is a short grace period during which a Player may still
> jump after leaving a ledge. It does not add an air jump. It briefly remembers
> that the Player was just standing on the floor, making slightly late input
> more forgiving.

> ⚠️ **If something differs**
>
> - If the Player misses the raised platform while falling, confirm that
>   `CoyoteTestPlatform` is at Position `(576, 470)` with a 320-by-32
>   rectangle shape, and that its collision shape remains at local Position
>   `(0, 0)`.
> - If changing the platform's shape also changes the original Floor, undo the
>   change and create a new `RectangleShape2D` on the platform before setting
>   its Size.
> - If the Player can already jump after leaving the ledge, compare
>   `player.gd` with the completed Lesson 3.2 script before continuing.
> - If the collision outline is hidden, stop the scene and enable **Visible
>   Collision Shapes** from the **Debug** menu.

### Part 2: Add the grace-period setting and countdown

1. Open `res://actors/player.gd`.
2. Immediately below the `jump_velocity` declaration, add:

   ```gdscript
   ## Seconds after leaving a ledge during which jumping remains allowed.
   @export_range(0.0, 0.5, 0.01)
   var coyote_time: float = 0.1
   ```

3. Add a blank line, then add this regular script-level variable:

   ```gdscript
   var coyote_timer: float = 0.0
   ```

> 💡 `coyote_time` is the configurable duration. `coyote_timer` is the current
> countdown used while the game runs. The countdown is not exported because it
> changes automatically and is not a setting the designer needs to edit.

4. Save `player.gd` with `Ctrl+S`.
5. Open `res://actors/player.tscn` and select the Player root.
6. Confirm that **Coyote Time** displays `0.1` in the Inspector.
7. Hover over the property and confirm that its tooltip describes how long
   jumping remains allowed after leaving a ledge.
8. Confirm that the control stays between `0.0` and `0.5` and changes in steps
   of `0.01`.

> ⚠️ **If something differs**
>
> - If Coyote Time does not appear, confirm that its documentation comment,
>   annotation, and variable remain together at script-level scope.
> - If `coyote_timer` appears in the Inspector, remove any `@export` annotation
>   above it; only the duration is a designer setting.

### Part 3: Track when jumping remains allowed

1. At the beginning of `_physics_process()`, above the existing jump condition,
   add:

   ```gdscript
   if is_on_floor():
       coyote_timer = coyote_time
   else:
       coyote_timer = move_toward(coyote_timer, 0.0, delta)

   var can_jump: bool = is_on_floor() or coyote_timer > 0.0
   ```

While the Player is grounded, the countdown is refreshed to the configured
duration on every physics update. After the Player leaves the floor,
`move_toward()` reduces it toward `0.0` by `delta`, reusing the time-based
pattern from Lesson 3.2 without allowing the value to pass below zero.

> 💡 `or` combines two conditions and produces `true` when either one is true.
> Here, `can_jump` is true while the Player is on the floor **or** while some
> coyote time remains. Keeping the normal floor check means setting Coyote Time
> to `0.0` disables only the grace period, not grounded jumping.

2. Move the existing gravity comment and condition so they sit immediately
   below the `can_jump` declaration, above the jump condition:

   ```gdscript
   # Skip gravity while the Player is grounded.
   if not is_on_floor():
       velocity.y += gravity * delta
   ```

Gravity is calculated before the jump so a jump accepted during coyote time
can replace the resulting vertical velocity with the exact `jump_velocity`.
Grounded and grace-period jumps therefore begin with the same upward velocity.

3. Replace the existing jump comment and condition:

   ```gdscript
   # Prevent another jump from starting while the Player is airborne.
   if Input.is_action_just_pressed("jump") and is_on_floor():
       velocity.y = jump_velocity
   ```

   with:

   ```gdscript
   # Allow one jump from the floor or during the grace period.
   if Input.is_action_just_pressed("jump") and can_jump:
       velocity.y = jump_velocity
       coyote_timer = 0.0
   ```

Setting `coyote_timer` to `0.0` consumes the grace period as soon as a jump
starts. Pressing jump again while airborne therefore cannot start another jump.

4. Compare your completed script with this version:

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

   ## Seconds after leaving a ledge during which jumping remains allowed.
   @export_range(0.0, 0.5, 0.01)
   var coyote_time: float = 0.1

   var coyote_timer: float = 0.0

   func _physics_process(delta: float) -> void:
       if is_on_floor():
           coyote_timer = coyote_time
       else:
           coyote_timer = move_toward(coyote_timer, 0.0, delta)

       var can_jump: bool = is_on_floor() or coyote_timer > 0.0

       # Skip gravity while the Player is grounded.
       if not is_on_floor():
           velocity.y += gravity * delta

       # Allow one jump from the floor or during the grace period.
       if Input.is_action_just_pressed("jump") and can_jump:
           velocity.y = jump_velocity
           coyote_timer = 0.0

       var direction: float = Input.get_axis("move_left", "move_right")
       var target_speed: float = direction * speed

       if direction != 0.0:
           velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
       else:
           velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)

       move_and_slide()
   ```

5. Confirm that the gravity calculation and horizontal-movement section remain
   unchanged from Lesson 3.2; only the gravity block's position relative to the
   jump block has changed.
6. Save `player.gd` with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If grounded jumping stops working when Coyote Time is `0.0`, confirm that
>   `can_jump` checks `is_on_floor() or coyote_timer > 0.0`.
> - If the Player can jump twice in the air, confirm that the jump branch sets
>   `coyote_timer = 0.0` immediately after assigning `jump_velocity`.
> - If the timer grows while airborne, confirm that only the grounded branch
>   assigns `coyote_time` and the `else` branch moves the timer toward `0.0`.
> - If a grace-period jump is slightly lower than a grounded jump, confirm that
>   the gravity block appears before the jump block.

### Part 4: Ask Codex to review the timing logic

1. Return to the Codex project associated with this Godot folder.
2. Ask:

   > Review `actors/player.gd` without changing it. Check that grounded jumping
   > still works when `coyote_time` is `0.0`, the coyote timer counts down only
   > after leaving the floor, one jump consumes the timer, gravity is applied
   > before an accepted jump, and the existing acceleration and deceleration
   > remain before `move_and_slide()`. Report any mismatch with line references.

3. Read the response and inspect every referenced line in `player.gd`.
4. If Codex identifies a real mismatch, correct only that mismatch manually and
   compare the result with the completed script in Part 3.

This review is useful because a misplaced timer reset can look correct while
quietly allowing an extra air jump or disabling normal jumping. The final
decision still comes from inspecting the code and testing the behavior.

If Codex is unavailable, compare the four timer and jump requirements from the
prompt directly with the completed script in Part 3, then continue.

> ⚠️ **If something differs**
>
> - If Codex proposes unrelated rewrites, ignore them and keep the review
>   limited to the four requested timing checks.
> - If its description disagrees with the visible code, trust the code you can
>   inspect and verify the behavior in the next part.

### Part 5: Test the grace window and its limits

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. From either side of the platform, jump onto it and confirm that grounded
   jumping still works.
3. Walk off either edge and press jump immediately afterward. Confirm that
   the Player jumps during the short grace period.
4. Return to the platform from either side, walk off again, wait noticeably
   longer before pressing jump, and
   confirm that the Player does not jump and lands on the original Floor.
5. From the Floor, jump back onto the platform from its other side. The
   platform is 74 pixels higher than the Floor, so the default jump can still
   reach it.
6. Start a coyote-time jump, then press jump again while airborne. Confirm that
   a second jump does not start.
7. Confirm that acceleration, deceleration, reversal, gravity, and landing
   still behave as they did in Lesson 3.2.
8. If a compatible controller is connected, repeat the ledge and regression
   checks with its configured inputs.
9. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If jumping works for too long after leaving the ledge, confirm that the
>   airborne branch reduces `coyote_timer` by `delta` and that Coyote Time is
>   restored to `0.1`.
> - If the grace jump never works, confirm that `coyote_timer` is refreshed
>   while grounded and that the jump condition uses `can_jump`.
> - If the Player cannot reach the platform from the Floor, confirm that the
>   platform Position is `(576, 470)` and that `jump_velocity` still uses its
>   validated default of `-400.0`.

## Learner exercise

1. Change **Coyote Time** from `0.1` to `0.2` in the Player Inspector.
2. Predict how the longer grace period will affect a late jump after leaving
   the ledge.
3. Run `main.tscn` and check the prediction.
4. Change **Coyote Time** to `0.0` and run the scene again.
5. Confirm that jumping from the floor still works but jumping after leaving
   the ledge does not.
6. Restore **Coyote Time** to `0.1`, save `player.tscn`, and verify the default
   behavior once more.
7. Explain why `coyote_time` is exported while `coyote_timer` is not.

## Verification checklist

- [ ] The original Floor retains Position `(576, 560)` and its 1152-by-64
      rectangle collision shape.
- [ ] `CoyoteTestPlatform` is a duplicate `StaticBody2D` at Position
      `(576, 470)` with its own 320-by-32 rectangle collision shape at local
      Position `(0, 0)`.
- [ ] After walking off the raised platform, the Player lands safely on the
      original Floor and can jump back onto the platform from either side.
- [ ] `coyote_time` is an exported `float` with default `0.1`, range `0.0`
      through `0.5`, step `0.01`, and a useful documentation tooltip.
- [ ] `coyote_timer` is a non-exported script-level `float` with default `0.0`.
- [ ] The timer refreshes to `coyote_time` while grounded and approaches `0.0`
      by `delta` while airborne.
- [ ] `can_jump` is true while grounded or while coyote time remains.
- [ ] Starting a jump assigns `jump_velocity` and consumes the timer by setting
      it to `0.0`.
- [ ] Grounded jumping still works when Coyote Time is `0.0`.
- [ ] The Player can jump immediately after walking off the ledge but cannot
      jump after the grace period expires.
- [ ] The Player cannot start a second jump while airborne.
- [ ] Acceleration, deceleration, reversal, gravity, landing, and maximum speed
      remain unchanged.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] The exercise ends with Coyote Time restored to `0.1`.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner can explain the separate roles of `coyote_time`,
      `coyote_timer`, and `can_jump`.

## References

- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [GlobalScope `move_toward()`](https://docs.godotengine.org/en/4.7/classes/class_%40globalscope.html#class-globalscope-method-move-toward)
- [GDScript exported properties](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_exports.html)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
