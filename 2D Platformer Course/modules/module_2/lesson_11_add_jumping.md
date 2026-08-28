# Module 2, Lesson 11: Add Jumping

**Status:** Validated

## By the end

Make the Player jump from the floor with the existing `jump` action. The
Player will jump when you press Space or the configured controller button, and
will not start another jump while airborne.

This completes the first basic Player movement set: horizontal movement,
gravity, floor detection, and jumping.

## Before you start

- Module 2, Lesson 10 is complete.
- `main.tscn` contains the Player and the temporary Floor.
- The Player falls, lands on the floor, and moves horizontally.
- `res://actors/player.gd` contains `if not is_on_floor():` above the gravity
  calculation.
- The `jump` action from Lesson 2.1 is still assigned to Space and the
  controller's bottom button.

## Build steps

### Part 1: Choose the jump velocity

1. Open `res://actors/player.gd`.
2. Under the `gravity` variable, add this typed variable:

   ```gdscript
   var jump_velocity: float = -400.0
   ```

   Your variables should now look like this:

   ```gdscript
   var speed: float = 300.0
   var gravity: float = 980.0
   var jump_velocity: float = -400.0
   ```

> 💡 The negative `jump_velocity` sends the Player upward because 2D Y values
> increase downward. Its name describes its purpose: when a jump begins, the
> value is assigned to `velocity.y`, which controls vertical movement.

3. Save the script with `Ctrl+S`.

### Part 2: Start a jump with the existing action

1. In `_physics_process()`, add this code above the gravity condition:

   ```gdscript
   if Input.is_action_just_pressed("jump"):
       velocity.y = jump_velocity
   ```

> 💡 `Input.is_action_just_pressed("jump")` is an `Input` method that checks
> the existing `jump` action. It returns `true` only when the action first
> starts being pressed, then returns `false` while the button remains held.
> This makes it useful for a one-time action, such as starting a jump.

2. Save the script and run `main.tscn` with `F6`.
3. Press Space once. Confirm that the Player jumps upward, then falls and
   lands on the floor.
4. While the Player is airborne, press Space again. Confirm that the Player
   starts another jump in the air. This is temporary; you will prevent it in
   the next part.
5. Hold Space briefly. Confirm that holding the key does not repeatedly start
   jumps.
6. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player does not jump, confirm that the action name is exactly `"jump"`
>   and that the code is inside `_physics_process()`.
> - If the script reports an error, check the colon after the `if` condition
>   and indent the `velocity.y` line beneath it.

### Part 3: Allow a jump only from the floor

1. Add `and is_on_floor()` to the end of the condition:

   ```gdscript
   if Input.is_action_just_pressed("jump") and is_on_floor():
       velocity.y = jump_velocity
   ```

> 💡 `and` combines two conditions. The indented instruction runs only when
> both are `true`: the `jump` action has just been pressed and the Player is
> on the floor. `is_on_floor()` was introduced in Lesson 2.10; it prevents an
> airborne Player from starting another jump.

`=` replaces the Player's current vertical velocity with the upward
`jump_velocity` value when the jump begins. The gravity condition then increases
`velocity.y` over later physics updates, so the Player slows down, falls, and
lands again.

2. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   var speed: float = 300.0
   var gravity: float = 980.0
   var jump_velocity: float = -400.0

   func _physics_process(delta: float) -> void:
       if Input.is_action_just_pressed("jump") and is_on_floor():
           velocity.y = jump_velocity

       if not is_on_floor():
           velocity.y += gravity * delta

       var direction: float = Input.get_axis("move_left", "move_right")
       velocity.x = direction * speed
       move_and_slide()
   ```

3. Save the script and run `main.tscn` again.
4. Press Space while the Player is standing on the floor. Confirm that the
   Player jumps upward, falls, and lands.
5. Press Space while the Player is airborne. Confirm that the Player does not
   start a second jump.
6. Hold Space. Confirm that the Player does not repeatedly jump while the
   button is held.
7. Hold `A` or Left Arrow while jumping, then hold `D` or Right Arrow during a
   later jump. Confirm that horizontal movement still works in the air and on
   the floor.
8. Release horizontal input. Confirm that the Player stops moving sideways.
9. If a compatible controller is connected, test its configured bottom button
   and horizontal controls.
10. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player does not jump, check that `jump_velocity` is negative and
>   that `velocity.y = jump_velocity` is indented beneath the jump condition.
> - If the Player can jump in the air, make sure `and is_on_floor()` remains
>   on the same `if` line.
> - If the Player rises but never falls, confirm that the gravity condition
>   from Lesson 2.10 is still present below the jump condition.

## Learner exercise

1. Temporarily change `jump_velocity` from `-400.0` to `-250.0`.
2. Run the scene and compare the height of the jump with the original.
3. Restore `jump_velocity` to `-400.0`.
4. Explain why both values make the Player move upward, but one produces a
   lower jump.

## Verification checklist

- [ ] `jump_velocity` is a typed `float` with the value `-400.0`.
- [ ] The final jump condition uses
      `Input.is_action_just_pressed("jump") and is_on_floor()`.
- [ ] `velocity.y = jump_velocity` is indented beneath that condition.
- [ ] Space makes the Player jump, fall, and land on the floor.
- [ ] Holding the jump button does not repeatedly start jumps.
- [ ] The Player cannot jump again while airborne.
- [ ] Keyboard horizontal movement and stopping still work in the air and on
      the floor.
- [ ] Configured controller jump and movement work when a compatible controller
      is available.

## References

- [Input](https://docs.godotengine.org/en/4.7/classes/class_input.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
