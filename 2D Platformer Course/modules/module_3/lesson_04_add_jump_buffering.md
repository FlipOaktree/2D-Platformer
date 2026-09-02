# Module 3, Lesson 4: Add Jump Buffering

**Status:** Blueprint drafted

## By the end

Remember a jump press made shortly before the Player lands, then start the jump
as soon as landing makes jumping possible. This makes slightly early input feel
more responsive without adding an air jump.

- **Jump Buffer Time** defaults to `0.1` seconds.
- The setting appears in the Player Inspector with a documentation tooltip and
  a safe range from `0.0` to `0.5` seconds in steps of `0.01`.
- A script-level countdown remembers a recent jump request.
- The jump condition separates whether a jump was requested from whether the
  Player is currently allowed to jump.
- The raised platform from Lesson 3.3 remains above the original Floor so the
  buffered landing can be tested repeatedly.

## Before you start

- Module 3, Lesson 3 is complete and validated.
- `res://actors/player.gd` contains the validated acceleration, deceleration,
  gravity, grounded jump, and coyote-time logic.
- `res://scenes/main.tscn` contains the original Floor and the centered raised
  `CoyoteTestPlatform`.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Test what an early jump press does now

1. Open `res://scenes/main.tscn`.
2. In the editor's **Debug** menu, confirm that **Visible Collision Shapes** is
   enabled.
3. Run the current scene with `F6`.
4. Jump from the raised platform while moving toward either edge so the Player
   falls toward the original Floor.
5. During the fall, press jump shortly before the Player lands.
6. Confirm that the Player lands but does not immediately jump again, then stop
   the scene with `F8`.

> 💡 **Jump buffering** briefly remembers a jump press made before jumping is
> allowed. If the Player lands while that request is still remembered, the jump
> begins immediately. It does not permit a jump in midair.

Starting with the jump from the platform consumes the coyote-time countdown.
This makes the failed pre-landing press a clear test of the missing behavior,
not a coyote jump.

> ⚠️ **If something differs**
>
> - If the Player jumps before landing, make sure the first jump began while
>   standing on the platform and that jump was not pressed again until the
>   Player was close to the Floor.
> - If the Player misses the Floor, confirm that the original Floor remains at
>   Position `(576, 560)` with its 1152-by-64 rectangle shape.
> - If the Player cannot use the raised platform, compare `main.tscn` and
>   `player.gd` with the validated Lesson 3.3 result before continuing.

### Part 2: Add the buffer setting and countdown

1. Open `res://actors/player.gd`.
2. Immediately below the `coyote_time` declaration, add:

   ```gdscript
   ## Seconds before landing during which a jump press is remembered.
   @export_range(0.0, 0.5, 0.01)
   var jump_buffer_time: float = 0.1
   ```

3. Immediately below the `coyote_timer` declaration, add:

   ```gdscript
   var jump_buffer_timer: float = 0.0
   ```

> 💡 `jump_buffer_time` is the configurable duration. `jump_buffer_timer` is
> the countdown that changes while the game runs. This is the same
> setting-and-runtime-value pattern used for coyote time, but this countdown
> remembers input instead of remembering the floor.

4. Save `player.gd` with `Ctrl+S`.
5. Open `res://actors/player.tscn` and select the Player root.
6. Confirm that **Jump Buffer Time** displays `0.1` in the Inspector.
7. Hover over the property and confirm that its tooltip describes how long a
   jump press is remembered before landing.
8. Confirm that the control stays between `0.0` and `0.5` and changes in steps
   of `0.01`.

> ⚠️ **If something differs**
>
> - If Jump Buffer Time does not appear, confirm that its documentation
>   comment, annotation, and variable remain together at script-level scope.
> - If `jump_buffer_timer` appears in the Inspector, remove any export
>   annotation above it. The countdown is runtime state, not a designer
>   setting.

### Part 3: Remember and consume a jump request

1. In `_physics_process()`, immediately below the existing coyote-timer block,
   add:

   ```gdscript
   var jump_requested: bool = Input.is_action_just_pressed("jump")
   if jump_requested:
       jump_buffer_timer = jump_buffer_time
   else:
       jump_buffer_timer = move_toward(jump_buffer_timer, 0.0, delta)
   ```

`jump_requested` is true only on the physics update when the button is first
pressed. That press fills the countdown. Later updates reduce the remembered
time toward `0.0` until the request is accepted or expires.

2. Keep the existing `can_jump` declaration, then add this declaration
   immediately below it:

   ```gdscript
   var has_jump_request: bool = jump_requested or jump_buffer_timer > 0.0
   ```

> 💡 The two Boolean values answer different questions. `can_jump` asks,
> "Is jumping allowed now?" `has_jump_request` asks, "Did the player ask to
> jump now or recently?" A jump starts only when permission and a request
> overlap.

Keeping `jump_requested` in the condition is important. When Jump Buffer Time
is `0.0`, an immediate grounded or coyote jump still works even though there is
no time stored in the countdown.

3. Replace the existing jump comment and condition:

   ```gdscript
   # Allow one jump from the floor or during the grace period.
   if Input.is_action_just_pressed("jump") and can_jump:
       velocity.y = jump_velocity
       coyote_timer = 0.0
   ```

   with:

   ```gdscript
   # Start a jump when a request and permission overlap.
   if has_jump_request and can_jump:
       velocity.y = jump_velocity
       coyote_timer = 0.0
       jump_buffer_timer = 0.0
   ```

Clearing both countdowns consumes the accepted jump. The Player cannot reuse
the same remembered press or the same coyote-time permission for another jump.

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

   ## Seconds before landing during which a jump press is remembered.
   @export_range(0.0, 0.5, 0.01)
   var jump_buffer_time: float = 0.1

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

       var direction: float = Input.get_axis("move_left", "move_right")
       var target_speed: float = direction * speed

       if direction != 0.0:
           velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
       else:
           velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)

       move_and_slide()
   ```

5. Confirm that the coyote-time, gravity, and horizontal-movement calculations
   remain in their previous order and still finish with `move_and_slide()`.
6. Save `player.gd` with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If setting Jump Buffer Time to `0.0` disables ordinary jumping, confirm
>   that `has_jump_request` includes `jump_requested`.
> - If one press causes another jump later, confirm that an accepted jump sets
>   `jump_buffer_timer` to `0.0`.
> - If an old coyote window permits an extra jump, confirm that the accepted
>   jump also sets `coyote_timer` to `0.0`.
> - If the buffer never expires, confirm that the `else` branch moves its
>   timer toward `0.0` by `delta`.

### Part 4: Ask Codex to review the two timing windows

1. Return to the Codex project associated with this Godot folder.
2. Ask:

   > Review `actors/player.gd` without changing it. Check that an immediate
   > jump still works when `jump_buffer_time` is `0.0`, a recent airborne jump
   > press is remembered until landing, an expired request does not jump, an
   > accepted jump consumes both countdowns, and the existing movement remains
   > before `move_and_slide()`. Report any mismatch with line references.

3. Read the response and inspect every referenced line in `player.gd`.
4. If Codex identifies a real mismatch, correct only that mismatch manually and
   compare the result with the completed script in Part 3.

This focused review is useful because coyote time and jump buffering use
similar countdowns for opposite sides of a landing. The final decision still
comes from inspecting the code and testing the behavior.

If Codex is unavailable, compare the five requirements in the prompt directly
with the completed script in Part 3, then continue.

> ⚠️ **If something differs**
>
> - If Codex proposes unrelated rewrites, ignore them and keep the review
>   limited to the requested timing checks.
> - If its description disagrees with the visible code, trust the code you can
>   inspect and verify the behavior in the next part.

### Part 5: Test the buffered jump and its limits

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Jump normally from the Floor and from the raised platform. Confirm that
   ordinary jumping still works.
3. Jump from the raised platform while moving toward either edge.
4. During the fall, press jump shortly before reaching the original Floor.
5. Confirm that the Player lands and immediately begins a new jump.
6. Repeat the platform jump, but press jump much earlier during the fall.
7. Confirm that the request expires, the Player lands, and no new jump begins.
8. Walk off the platform and press jump immediately afterward. Confirm that
   coyote time still works.
9. During a normal jump, press jump while well away from both the platform and
   the Floor. Confirm that the Player does not start a second air jump.
10. Confirm that acceleration, deceleration, reversal, gravity, landing, and
    maximum speed still behave as before.
11. If a compatible controller is connected, repeat the buffered-jump and
    regression checks with its configured inputs.
12. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player jumps in midair, confirm that the jump condition requires
>   both `has_jump_request` and `can_jump`.
> - If the early press is ignored on landing, confirm that it fills
>   `jump_buffer_timer` and that the timer remains above `0.0` until landing.
> - If a very early press still triggers a jump, confirm that the timer moves
>   toward `0.0` by `delta` and Jump Buffer Time is restored to `0.1`.
> - If coyote time stops working, confirm that `can_jump` still checks the
>   grounded state or a positive `coyote_timer`.

## Learner exercise

1. Change **Jump Buffer Time** from `0.1` to `0.2` in the Player Inspector.
2. Predict how much earlier a jump press can be remembered before landing.
3. Run `main.tscn` and test the prediction by jumping from the platform.
4. Change **Jump Buffer Time** to `0.0` and run the scene again.
5. Confirm that immediate grounded and coyote jumps still work, but an airborne
   press before landing is no longer stored.
6. Restore **Jump Buffer Time** to `0.1`, save `player.tscn`, and verify the
   default behavior once more.
7. Explain the difference between `can_jump` and `has_jump_request`.

## Verification checklist

- [ ] `jump_buffer_time` is an exported `float` with default `0.1`, range
      `0.0` through `0.5`, step `0.01`, and a useful documentation tooltip.
- [ ] `jump_buffer_timer` is a non-exported script-level `float` with default
      `0.0`.
- [ ] A new jump press fills the buffer countdown.
- [ ] Without a new press, the buffer countdown approaches `0.0` by `delta`.
- [ ] `has_jump_request` is true for an immediate press or while buffered time
      remains.
- [ ] `can_jump` still represents grounded or coyote-time permission.
- [ ] A jump begins only when a request and permission overlap.
- [ ] Starting a jump consumes both the coyote and jump-buffer countdowns.
- [ ] Grounded and coyote jumping still work when Jump Buffer Time is `0.0`.
- [ ] A press shortly before landing starts a jump when the Player lands.
- [ ] A press made too early expires without starting a jump upon landing.
- [ ] The Player cannot start a second jump while airborne.
- [ ] The Floor and `CoyoteTestPlatform` retain their validated Lesson 3.3
      positions and collision shapes.
- [ ] Acceleration, deceleration, reversal, gravity, landing, and maximum speed
      remain unchanged.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] The exercise ends with Jump Buffer Time restored to `0.1`.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner can explain the separate roles of `jump_buffer_time`,
      `jump_buffer_timer`, `jump_requested`, `has_jump_request`, and
      `can_jump`.

## References

- [Input](https://docs.godotengine.org/en/4.7/classes/class_input.html)
- [GlobalScope `move_toward()`](https://docs.godotengine.org/en/4.7/classes/class_%40globalscope.html#class-globalscope-method-move-toward)
- [GDScript exported properties](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_exports.html)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
