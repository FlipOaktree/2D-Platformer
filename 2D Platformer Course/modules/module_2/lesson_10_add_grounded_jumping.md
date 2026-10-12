# Module 2, Lesson 10: Add Grounded Jumping

**Status:** Implemented

## Lesson goals

Make the Player jump with the existing `jump` action, then use a condition
to prevent another jump while the Player is airborne. First you will see
what happens when the button alone starts a jump. Then you will add the
floor check that makes the same action work as a grounded jump.

- Giving the Player an upward jump velocity
- Using `if` to respond to a new jump-button press
- Combining that press with floor state using `and`

## Before you start

- Module 2, Lesson 9 is complete.
- `main.tscn` contains the temporary `Floor` `StaticBody2D` and the Player.
- The Player falls, lands on the floor, and retains horizontal movement.
- The `jump` action from Lesson 2.7 is assigned to Space and the
  controller's bottom button.
- `res://actors/player.gd` contains `velocity.y += gravity * delta` in
  `_physics_process()`.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Choose the upward speed

1. Open `res://actors/player.gd`.
2. Under the `gravity` variable, add:

   ```gdscript
   var jump_velocity: float = -1200.0
   ```

The negative value sends the Player upward because 2D Y values increase downward. When a jump begins, this value will replace `velocity.y`, the Player's vertical speed.

3. Save the script with `Ctrl+S`.

### Part 2: Jump when the button is pressed

1. In `_physics_process()`, immediately after the gravity line, add:

   ```gdscript
   if Input.is_action_just_pressed("jump"):
   	velocity.y = jump_velocity
   ```

An `if` statement checks a condition that produces `true` or `false`. Its indented instruction runs when the condition is `true` and is skipped when it is `false`. For example, a barista makes a cappuccino only if a customer orders one. Whether a customer ordered one is the condition; making the cappuccino is the instruction. Without that order, the instruction is skipped.

`Input.is_action_just_pressed()` is another `Input` method, like `get_axis()` from Lesson 2.8. It checks whether a named action has just started being pressed. It returns `true` for that new press, then `false` while the button remains held.

Here, the `if` statement uses `Input.is_action_just_pressed("jump")` to check the jump action. Godot checks this condition on every physics update because it is inside  `_physics_process()`. When the method returns `true`, `velocity.y = jump_velocity` replaces the Player’s current vertical speed with the upward jump value.

2. Save the script. Predict what one press of Space will do, then run
   `main.tscn` with `F6`.
3. Once the Player lands, press Space. Confirm that the Player jumps,
   slows as gravity acts, then falls back to the Floor.
4. Release Space, then press it again while the Player is airborne.
   Confirm that another jump starts in the air. This is the behavior you
   will fix in the next part.
5. Hold Space during a jump. Confirm that holding the key does not start
   more jumps; only a new press does.
6. If a compatible controller is connected, try its configured jump button too.
7. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player does not jump, check that `jump_velocity` is negative,
>   the action name is exactly `"jump"`, and the assignment is indented
>   beneath the `if` line.
> - If the Player rises but never falls, confirm that
>   `velocity.y += gravity * delta` remains above the new condition.

### Part 3: Allow a jump only from the floor

1. Add `and is_on_floor()` to the existing condition:

   ```gdscript
   if Input.is_action_just_pressed("jump") and is_on_floor():
   	velocity.y = jump_velocity
   ```

`and` combines two conditions. The indented instruction runs only when the jump action has just been pressed **and** the Player is on the floor.

`is_on_floor()` is a `CharacterBody2D` method that returns a `bool`. It returns `true` if the last `move_and_slide()` call detected a floor, and `false` otherwise. Requiring both a new jump press and contact with the floor lets the Player jump when grounded, but prevents jumping in midair.

2. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   var speed: float = 450.0
   var gravity: float = 2400.0
   var jump_velocity: float = -1200.0

   func _physics_process(delta: float) -> void:
   	velocity.y += gravity * delta

   	if Input.is_action_just_pressed("jump") and is_on_floor():
   		velocity.y = jump_velocity

   	var direction: float = Input.get_axis("move_left", "move_right")
   	velocity.x = direction * speed
   	move_and_slide()
   ```

Gravity is calculated before the jump assignment, so a new jump starts at
the full `jump_velocity`. Gravity changes that speed during later updates.

3. Save and run `main.tscn` again. Predict what a press during the initial
   fall will do, then press Space while the Player is falling. Confirm
   that it does not start a jump. Restart the scene if the Player lands
   before you press.
4. After the Player lands, release and press Space. Confirm that the
   Player jumps upward, falls, and lands again.
5. Release and press Space while the Player is airborne. Confirm that another jump does not start. Keep holding Space and confirm that landing does not start a new jump.
6. Move left and right during a jump and after landing. Confirm that
   horizontal movement and stopping still work.
7. If a compatible controller is connected, repeat the jump and
   horizontal-movement checks with its configured controls.
8. Confirm that neither `ProjectIcon` nor `Project ready` appears in
   Output, then stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player jumps in the air, confirm that `and is_on_floor()`
>   remains on the same `if` line.
> - If a floor press does not start a jump, release Space before pressing
>   it again; a held button is not a new press.

## Learner exercise

1. Temporarily change `jump_velocity` from `-1200.0` to `-600.0`.
2. Run the scene and compare the height of the jump with the original.
3. Restore `jump_velocity` to `-1200.0`.
4. Explain why both values move the Player upward, but one produces a
   lower jump.

## Verification checklist

- [ ] `jump_velocity` is a typed `float` with the value `-1200.0`.
- [ ] `velocity.y += gravity * delta` appears exactly once, before the
    jump condition, and runs every physics update.
- [ ] The jump condition uses
    `Input.is_action_just_pressed("jump") and is_on_floor()`.
- [ ] `velocity.y = jump_velocity` is indented beneath that condition.
- [ ] Space makes the Player jump, fall, and land on the Floor.
- [ ] Holding the jump button does not repeatedly start jumps.
- [ ] The Player cannot start another jump while airborne.
- [ ] Keyboard horizontal movement and stopping work in the air and on the floor.
- [ ] Configured controller jump and movement work when a compatible
    controller is available.
- [ ] Neither `ProjectIcon` nor `Project ready` appears when `main.tscn` runs.

## References

- [Input](https://docs.godotengine.org/en/4.7/classes/class_input.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
