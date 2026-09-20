# Module 3, Lesson 5: Add Variable Jump Height

**Status:** Validated

## By the end

Let the length of the jump press control the height of the jump. A quick tap
produces a low hop, while holding the button produces the full jump the Player
already has.

- **Jump Release Multiplier** defaults to `0.5`.
- The setting appears in the Player Inspector with a documentation tooltip and
  a safe range from `0.0` to `1.0` in steps of `0.05`.
- Releasing the jump button while the Player is still rising keeps only that
  portion of the upward speed.
- Releasing the button while the Player is falling changes nothing.
- Grounded jumping, coyote time, and jump buffering continue to work unchanged.

## Before you start

- Module 3, Lesson 4 is complete and validated.
- `res://actors/player.gd` contains the validated acceleration, deceleration,
  gravity, grounded jump, coyote-time, and jump-buffering logic.
- `res://scenes/main.tscn` contains the original Floor and the centered raised
  `CoyoteTestPlatform`.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Test what a short press does now

1. Open `res://scenes/main.tscn`.
2. In the editor's **Debug** menu, confirm that **Visible Collision Shapes** is
   enabled.
3. Run the current scene with `F6`.
4. Stand on the original Floor beside the raised platform.
5. Press the jump button and release it immediately. Watch how high the Player
   rises.
6. Jump again, but hold the button down for the whole jump.
7. Confirm that both jumps reach the same height, then stop the scene with
   `F8`.

> 💡 **Variable jump height** lets a short press produce a lower jump and a
> held press produce the full jump. Rather than choosing a different jump
> velocity when the jump begins, it shortens a jump that is already rising once
> the button is released.

Every jump currently begins at exactly `jump_velocity`, whether the button is
tapped or held, because `Input.is_action_just_pressed()` reports only the first
update of a press. Nothing in the script reacts to the button being let go.

> ⚠️ **If something differs**
>
> - If the two jumps already reach different heights, compare `player.gd` with
>   the validated Lesson 3.4 script before continuing.
> - If the Player cannot jump at all, confirm that the `jump` action from
>   Lesson 2.1 is still assigned to Space and the controller's bottom button.

### Part 2: Add the jump release setting

1. Open `res://actors/player.gd`.
2. Immediately below the `jump_buffer_time` declaration, add:

   ```gdscript
   ## Portion of upward speed kept when the jump action is released early.
   @export_range(0.0, 1.0, 0.05)
   var jump_release_multiplier: float = 0.5
   ```

> 💡 This setting is a proportion, not a duration. At `0.5`, releasing the
> button early keeps half of the Player's current upward speed. At `1.0` the
> jump is never shortened, and at `0.0` the rise stops as soon as the button is
> released. The range stops at `1.0`, so the setting can only shorten a jump,
> never boost it.

Coyote time and jump buffering each needed a second variable to count down
while the game ran. This lesson needs none. The button release happens on a
single update, so the setting can be applied at that moment and nothing has to
be remembered afterward.

3. Save `player.gd` with `Ctrl+S`.
4. Open `res://actors/player.tscn` and select the Player root.
5. Confirm that **Jump Release Multiplier** displays `0.5` in the Inspector.
6. Hover over the property and confirm that its tooltip describes the portion
   of upward speed kept on an early release.
7. Confirm that the control stays between `0.0` and `1.0` and changes in steps
   of `0.05`.

> ⚠️ **If something differs**
>
> - If Jump Release Multiplier does not appear, confirm that its documentation
>   comment, annotation, and variable remain together at script-level scope.
> - If the control accepts values above `1.0`, confirm that the annotation
>   reads `@export_range(0.0, 1.0, 0.05)`.

### Part 3: Shorten the jump on an early release

1. In `_physics_process()`, immediately below the existing jump block and above
   the `var direction` line, add:

   ```gdscript
   # Shorten the jump when the action is released while the Player is rising.
   if Input.is_action_just_released("jump") and velocity.y < 0.0:
       velocity.y *= jump_release_multiplier
   ```

> 💡 `Input.is_action_just_released("jump")` is the counterpart to
> `Input.is_action_just_pressed()` from Lesson 2.11. It returns `true` only on
> the update when the button is let go, then returns `false` again. One reports
> the start of a press; the other reports its end.

`velocity.y < 0.0` limits the change to a Player that is still rising, because
2D Y values increase downward. Without that test, releasing the button during a
fall would reduce the Player's downward speed and produce a slow, floating
descent.

`*=` multiplies the current value and stores the result, in the same way `+=`
adds to it in the gravity line. Multiplying keeps the change proportional to
whatever upward speed remains, so a release near the top of a jump barely
changes the height while a release just after takeoff changes it a great deal.

Placing this block below the jump block keeps the code in the order the events
happen: a jump starts, and then an early release shortens it.

2. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   ## Maximum horizontal movement speed in pixels per second.
   @export_range(0.0, 1000.0, 10.0)
   var speed: float = 450.0

   ## How quickly horizontal speed increases toward its target.
   @export_range(100.0, 5000.0, 100.0)
   var acceleration: float = 1800.0

   ## How quickly horizontal speed decreases after input is released.
   @export_range(100.0, 5000.0, 100.0)
   var deceleration: float = 2700.0

   ## Downward acceleration in pixels per second squared.
   @export_range(0.0, 3000.0, 10.0)
   var gravity: float = 2400.0

   ## Upward velocity applied when a grounded jump begins.
   @export_range(-1500.0, 0.0, 10.0)
   var jump_velocity: float = -1200.0

   ## Seconds after leaving a ledge during which jumping remains allowed.
   @export_range(0.0, 0.5, 0.01)
   var coyote_time: float = 0.1

   ## Seconds before landing during which a jump press is remembered.
   @export_range(0.0, 0.5, 0.01)
   var jump_buffer_time: float = 0.1

   ## Portion of upward speed kept when the jump action is released early.
   @export_range(0.0, 1.0, 0.05)
   var jump_release_multiplier: float = 0.5

   var coyote_timer: float = 0.0
   var jump_buffer_timer: float = 0.0

   func _physics_process(delta: float) -> void:
       if is_on_floor():
           coyote_timer = coyote_time
       else:
           coyote_timer = move_toward(coyote_timer, 0.0, delta)

       var jump_requested: bool = Input.is_action_just_pressed("jump")
       if jump_requested:
           jump_buffer_timer = jump_buffer_time
       else:
           jump_buffer_timer = move_toward(jump_buffer_timer, 0.0, delta)

       var can_jump: bool = is_on_floor() or coyote_timer > 0.0
       var has_jump_request: bool = jump_requested or jump_buffer_timer > 0.0

       # Skip gravity while the Player is grounded.
       if not is_on_floor():
           velocity.y += gravity * delta

       # Start a jump when a request and permission overlap.
       if has_jump_request and can_jump:
           velocity.y = jump_velocity
           coyote_timer = 0.0
           jump_buffer_timer = 0.0

       # Shorten the jump when the action is released while the Player is rising.
       if Input.is_action_just_released("jump") and velocity.y < 0.0:
           velocity.y *= jump_release_multiplier

       var direction: float = Input.get_axis("move_left", "move_right")
       var target_speed: float = direction * speed

       if direction != 0.0:
           velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
       else:
           velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)

       move_and_slide()
   ```

3. Confirm that the coyote-time, jump-buffer, gravity, jump, and
   horizontal-movement blocks are unchanged and that `_physics_process()` still
   ends with `move_and_slide()`.
4. Save `player.gd` with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If the Player drifts downward slowly after the button is released during a
>   fall, confirm that the condition includes `and velocity.y < 0.0`.
> - If tapping and holding still produce the same height, confirm that the
>   condition uses `is_action_just_released` and not `is_action_just_pressed`.
> - If a released jump becomes taller instead of shorter, confirm that the
>   operator is `*=` and that Jump Release Multiplier is not above `1.0`.
> - If buffered or coyote jumps stop working, confirm that the new block
>   changes only `velocity.y` and leaves both countdowns alone.

### Part 4: Ask Codex to review the release condition

1. Return to the Codex project associated with this Godot folder.
2. Ask:

   > Review `actors/player.gd` without changing it. Check that a jump is
   > shortened only when the `jump` action is just released and `velocity.y`
   > is negative, that the shortening multiplies `velocity.y` by
   > `jump_release_multiplier` instead of replacing it, and that the existing
   > jump, coyote time, jump buffering, and movement remain unchanged. Report
   > any mismatch with line references.

3. Read the response and inspect every referenced line in `player.gd`.
4. If Codex identifies a real mismatch, correct only that mismatch manually and
   compare the result with the completed script in Part 3.

This review is useful because the shortening is a single short condition whose
sign test is easy to leave out. The resulting slow fall looks like a gravity
problem, so a second reading of the exact condition saves time. The final
decision still comes from inspecting the code and testing the behavior.

If Codex is unavailable, compare the three requirements in the prompt directly
with the completed script in Part 3, then continue.

> ⚠️ **If something differs**
>
> - If Codex proposes unrelated rewrites, ignore them and keep the review
>   limited to the requested checks.
> - If its description disagrees with the visible code, trust the code you can
>   inspect and verify the behavior in the next part.

### Part 5: Test tapped and held jumps

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Stand on the original Floor beside the raised platform. Press the jump
   button and release it immediately. Confirm that the Player rises much less
   than before and does not reach the top of the platform.
3. Jump again while holding the button down. Confirm that the Player reaches
   its full height and can still land on the platform when moving toward it.
4. Jump once more, holding the button until the Player is near the top of the
   rise, then release. Confirm that the jump still reaches nearly its full
   height, unlike the immediate release in step 2.
5. While falling from the platform toward the Floor, press and release the jump
   button. Confirm that the Player keeps falling at its normal speed instead of
   drifting down slowly. If the press was recent enough, the buffered jump from
   Lesson 3.4 still starts on landing.
6. Walk off the platform edge, press jump during the grace period, and release
   it immediately. Confirm that the coyote jump starts and is shortened in the
   same way as a grounded jump.
7. Confirm that acceleration, deceleration, reversal, gravity, landing, and
   maximum speed still behave as before.
8. If a compatible controller is connected, repeat the tapped, held, and
   regression checks with its configured inputs.
9. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If a held jump no longer reaches the platform, confirm that Jump Release
>   Multiplier is `0.5` and that `jump_velocity` still uses its validated
>   default of `-1200.0`.
> - If tapping produces no visible difference, confirm that `player.gd` was
>   saved and that the new block sits inside `_physics_process()`.
> - If the tapped jump barely leaves the floor, confirm that Jump Release
>   Multiplier is `0.5` rather than a much smaller value.

## Learner exercise

1. Change **Jump Release Multiplier** from `0.5` to `1.0` in the Player
   Inspector.
2. Predict how a tapped jump and a held jump will compare.
3. Run `main.tscn` and test the prediction. Confirm that every jump reaches its
   full height again, matching the behavior from Lesson 3.4.
4. Change **Jump Release Multiplier** to `0.0` and run the scene again.
5. Confirm that releasing the button stops the Player's rise immediately.
6. Restore **Jump Release Multiplier** to `0.5`, save `player.tscn`, and verify
   the default behavior once more.
7. Explain why the shortening condition tests `velocity.y < 0.0` instead of
   `is_on_floor()`.

## Verification checklist

- [ ] `jump_release_multiplier` is an exported `float` with default `0.5`,
      range `0.0` through `1.0`, step `0.05`, and a useful documentation
      tooltip.
- [ ] `coyote_timer` and `jump_buffer_timer` remain the only runtime countdown
      variables in `player.gd`.
- [ ] The shortening condition uses both
      `Input.is_action_just_released("jump")` and `velocity.y < 0.0`.
- [ ] `velocity.y *= jump_release_multiplier` appears exactly once in the
      script.
- [ ] The shortening block sits after the jump block and before the
      horizontal-movement section.
- [ ] `_physics_process()` still ends with `move_and_slide()`.
- [ ] A tapped jump rises noticeably less than a held jump.
- [ ] A held jump still reaches the top of `CoyoteTestPlatform` from the
      original Floor.
- [ ] Releasing the jump button while falling does not change the fall speed.
- [ ] A coyote-time jump is shortened by an early release in the same way as a
      grounded jump.
- [ ] Buffered jumping, coyote time, gravity, and grounded jumping still work.
- [ ] Setting Jump Release Multiplier to `1.0` restores the fixed jump height
      from Lesson 3.4.
- [ ] Acceleration, deceleration, reversal, gravity, landing, and maximum speed
      remain unchanged.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] The exercise ends with Jump Release Multiplier restored to `0.5`.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner can explain the difference between
      `Input.is_action_just_pressed()` and `Input.is_action_just_released()`.
- [ ] The learner can explain why the shortening condition tests
      `velocity.y < 0.0` rather than `is_on_floor()`.

## References

- [Input](https://docs.godotengine.org/en/4.7/classes/class_input.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [GDScript exported properties](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_exports.html)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
