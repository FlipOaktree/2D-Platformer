# Module 5, Lesson 5: Track Player Movement States

**Status:** Blueprint drafted

## By the end

Give the Player one named answer to the question "what is it doing right now?"
The script already contains the facts needed to answer it, but they are spread
across separate conditions and nothing stores the result.

- A `MovementState` list names the four states: `IDLE`, `RUN`, `RISE`, and
  `FALL`.
- `movement_state` holds the current state and updates every physics update.
- The state is decided after `move_and_slide()`, so it describes movement that
  has already been resolved.
- `movement_state` is runtime state, so it is not exported.
- The Player moves exactly as it did before. This lesson adds a description of
  the movement, not a change to it, and the next lesson uses that description
  to choose an animation.

## Before you start

- Module 5, Lesson 4 is complete and validated.
- `res://actors/player.gd` contains the validated movement logic from Module 3:
  acceleration, deceleration, gravity, grounded jump, coyote time, jump
  buffering, and variable jump height.
- The Player has imported character art and a working camera from Lessons 5.1
  through 5.4.
- A level from Module 4 is available to move and jump around in.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Find the states the script already implies

1. Open `res://actors/player.gd`.
2. Read `_physics_process()` and find these three existing conditions:

   ```gdscript
   if is_on_floor():
   if velocity.y < 0.0:
   if direction != 0.0:
   ```

3. Open `res://scenes/main.tscn` and run the current scene with `F6`.
4. Move, jump, and fall from the raised platform, then stop the scene with
   `F8`.

The Player clearly behaves differently while standing, running, rising, and
falling. Each of those situations is already decidable from the values above,
but the script never writes the answer down. Every part of the code that wants
to know what the Player is doing has to work it out again from scratch.

> 💡 A **movement state** is a single stored value naming what the Player is
> doing. Storing it once means later features can read one answer instead of
> repeating the same conditions. The next lesson uses this state to choose
> which animation to play.

> ⚠️ **If something differs**
>
> - If any of the three conditions is missing, compare `player.gd` with the
>   validated Module 3 movement script before continuing.

### Part 2: Name the states

1. In `player.gd`, immediately below the `extends CharacterBody2D` line, add a
   blank line and then:

   ```gdscript
   enum MovementState { IDLE, RUN, RISE, FALL }
   ```

> 💡 An `enum` creates a named list of related whole numbers. Writing
> `MovementState.IDLE` is clearer than writing `0`, but Godot stores it as a
> number: the names count up from zero, so `IDLE` is `0`, `RUN` is `1`, `RISE`
> is `2`, and `FALL` is `3`. `MovementState` is the name of the list, and the
> capitalized names inside the braces are its values.

The `enum` sits above the exported settings because it defines a type the
variables below it can use.

2. Immediately below the `jump_buffer_timer` declaration, add:

   ```gdscript
   var movement_state: MovementState = MovementState.IDLE
   ```

> 💡 The type hint is `MovementState`, so this variable can only hold one of
> the four names in the list. It starts as `IDLE` because the Player begins
> standing still. Like `coyote_timer` and `jump_buffer_timer`, it changes while
> the game runs, so it is not exported.

3. Save `player.gd` with `Ctrl+S`.
4. Confirm that the script editor reports no errors.
5. Open `res://actors/player.tscn`, select the Player root, and confirm that
   **Movement State** does **not** appear in the Inspector.

> ⚠️ **If something differs**
>
> - If the editor reports that `MovementState` is not declared, confirm that
>   the `enum` line sits at script-level scope, outside `_physics_process()`.
> - If Movement State appears in the Inspector, remove any export annotation
>   above it. The current state is runtime information, not a designer setting.

### Part 3: Decide the state after each update

1. In `_physics_process()`, immediately below the existing `move_and_slide()`
   line, add:

   ```gdscript
   # Describe the movement that this update produced.
   if is_on_floor():
       if velocity.x != 0.0:
           movement_state = MovementState.RUN
       else:
           movement_state = MovementState.IDLE
   else:
       if velocity.y < 0.0:
           movement_state = MovementState.RISE
       else:
           movement_state = MovementState.FALL
   ```

This block sits after `move_and_slide()` on purpose. That call moves the Player
and resolves its collisions, so afterward `is_on_floor()` and `velocity`
describe what actually happened during this update rather than what was
intended before it.

> 💡 The outer condition asks the bigger question first: is the Player on the
> floor? Each answer leads to a smaller question. A grounded Player is either
> running or idle; an airborne Player is either rising or falling. Only one of
> the four assignments runs each update.

`velocity.y < 0.0` means the Player is still moving upward, because 2D Y values
increase downward. At the very top of a jump the upward speed has been used up,
so the Player is reported as `FALL` slightly before it starts visibly
descending.

2. Below that block, add this temporary line to watch the state change:

   ```gdscript
   print(movement_state)
   ```

3. Save `player.gd` and run `main.tscn` with `F6`.
4. Open the **Output** panel and confirm each of these while playing:
   - Standing still on the Floor reports `0`.
   - Holding `A` or `D` reports `1`.
   - The rise of a jump reports `2`.
   - The fall back down reports `3`.
5. Stop the scene with `F8`.

> 💡 The Output repeats the same number many times because
> `_physics_process()` runs continuously. Watch for the moment the number
> changes rather than reading every line. You will remove this diagnostic in
> Part 5.

> ⚠️ **If something differs**
>
> - If the Output never reports `0`, confirm that the grounded branch checks
>   `velocity.x != 0.0` and that the Player has come to a complete stop.
> - If jumping never reports `2`, confirm that the airborne branch checks
>   `velocity.y < 0.0` rather than `> 0.0`.
> - If the number stays the same while the Player is clearly airborne, confirm
>   that the block sits after `move_and_slide()` and not before it.
> - If the editor reports an indentation error, confirm that the inner `if` and
>   `else` lines sit one level deeper than the outer ones.

### Part 4: Ask Codex to review the state decisions

1. Return to the Codex project associated with this Godot folder.
2. Ask:

   > Review `actors/player.gd` without changing it. Check that exactly one
   > `movement_state` assignment can run per update, that a grounded Player is
   > reported as running or idle and an airborne Player as rising or falling,
   > that the state is decided after `move_and_slide()`, and that the existing
   > movement and jump behavior is unchanged. Report any mismatch with line
   > references.

3. Read the response and inspect every referenced line in `player.gd`.
4. If Codex identifies a real mismatch, correct only that mismatch manually and
   compare the result with the completed script in Part 5.

This review is useful because a nested condition can look correct while leaving
one situation unreachable. A state that never occurs is easy to miss by playing
and easy to see by reading. The final decision still comes from inspecting the
code and testing the behavior.

If Codex is unavailable, compare the four requirements in the prompt directly
with the completed script in Part 5, then continue.

> ⚠️ **If something differs**
>
> - If Codex proposes replacing the nested conditions with syntax this course
>   has not introduced, keep the version above.
> - If its description disagrees with the visible code, trust the code you can
>   inspect and verify the behavior in the next part.

### Part 5: Remove the diagnostic and confirm the movement is unchanged

1. Delete the temporary `print(movement_state)` line.
2. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   enum MovementState { IDLE, RUN, RISE, FALL }

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

   ## Portion of upward speed kept when the jump action is released early.
   @export_range(0.0, 1.0, 0.05)
   var jump_release_multiplier: float = 0.5

   var coyote_timer: float = 0.0
   var jump_buffer_timer: float = 0.0
   var movement_state: MovementState = MovementState.IDLE

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

       # Describe the movement that this update produced.
       if is_on_floor():
           if velocity.x != 0.0:
               movement_state = MovementState.RUN
           else:
               movement_state = MovementState.IDLE
       else:
           if velocity.y < 0.0:
               movement_state = MovementState.RISE
           else:
               movement_state = MovementState.FALL
   ```

3. Save `player.gd` with `Ctrl+S`.
4. Run `main.tscn` with `F6`.
5. Confirm that no numbers appear in the Output.
6. Confirm that acceleration, deceleration, reversal, gravity, landing, maximum
   speed, grounded jumping, coyote time, jump buffering, and variable jump
   height all behave exactly as they did before this lesson.
7. If a compatible controller is connected, repeat the movement and jump checks
   with its configured inputs.
8. Stop the scene with `F8`.

The Player looks and feels identical, because this lesson only records a
description of what the movement code already does. The stored state becomes
useful when a later feature needs to ask one question instead of repeating
these conditions.

> ⚠️ **If something differs**
>
> - If numbers still appear in the Output, confirm that the temporary
>   `print(movement_state)` line is deleted.
> - If any movement or jump behavior changed, confirm that the new block only
>   assigns `movement_state` and never changes `velocity`.
> - If the Player stops moving entirely, confirm that `move_and_slide()` still
>   runs before the new block.

## Learner exercise

1. Walk off the edge of the raised platform without pressing jump.
2. Predict which state the Player reports during that fall.
3. Temporarily add `print(movement_state)` below the state block, run
   `main.tscn`, and check the prediction.
4. Predict whether coyote time changes the reported state during that same
   fall, then check it.
5. Delete the temporary `print(movement_state)` line again and save.
6. Explain why the grounded check is the outer question and the horizontal and
   vertical checks are the inner ones.

## Verification checklist

- [ ] `MovementState` is an `enum` at script-level scope listing `IDLE`, `RUN`,
      `RISE`, and `FALL` in that order.
- [ ] `movement_state` is a non-exported script-level variable typed
      `MovementState` with the starting value `MovementState.IDLE`.
- [ ] **Movement State** does not appear in the Player Inspector.
- [ ] The state block sits after `move_and_slide()` in `_physics_process()`.
- [ ] `move_and_slide()` appears exactly once in the script.
- [ ] Each of the four `movement_state` assignments appears exactly once.
- [ ] A grounded Player with horizontal velocity reports `RUN`, and a grounded
      Player at rest reports `IDLE`.
- [ ] An airborne Player moving upward reports `RISE`, and an airborne Player
      otherwise reports `FALL`.
- [ ] The finished script contains no `print()` calls.
- [ ] Acceleration, deceleration, reversal, gravity, landing, maximum speed,
      grounded jumping, coyote time, jump buffering, and variable jump height
      remain unchanged.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner used a temporary `print()` to observe all four states and
      removed it before finishing.
- [ ] The learner can explain why an `enum` value is clearer to read than the
      number Godot stores.
- [ ] The learner can explain why the state is decided after
      `move_and_slide()`.

## References

- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
