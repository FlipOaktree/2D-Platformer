# Module 2, Lesson 10: Use Conditions to Respond to Floor State

**Status:** Blueprint drafted

## By the end

Use the Player's floor state to make a decision with `if`, `else`, and `not`.
The Output will show whether the Player is airborne or standing on the floor.
You will then use that same condition to apply gravity only while the Player
is airborne.

This lesson does not add jumping. Lesson 2.11 will use the established floor
state to decide when the Player can jump.

## Before you start

- Module 2, Lesson 9 is complete.
- `main.tscn` contains the temporary `Floor` `StaticBody2D` and the Player.
- The Player falls, lands on the floor, and retains horizontal movement.
- `res://actors/player.gd` contains this gravity line in
  `_physics_process()`:

  ```gdscript
  velocity.y += gravity * delta
  ```

- The project runs without related errors or warnings.

## Build steps

### Part 1: Observe the Player's floor state

1. Open `res://actors/player.gd`.
2. In `_physics_process()`, add this code immediately above the gravity
   calculation:

   ```gdscript
   if is_on_floor():
       print("Player is on the floor.")
   else:
       print("Player is airborne.")
   ```

> 💡 An `if` statement runs its indented instructions only when its condition
> is `true`. `is_on_floor()` is a `CharacterBody2D` method that returns a
> `bool`: `true` when `move_and_slide()` detected a floor during the previous
> physics update, otherwise `false`. `else` supplies the instructions to run
> when the `if` condition is `false`.

3. Save the script with `Ctrl+S`.
4. Open `res://scenes/main.tscn` and run the current scene with `F6`.
5. Open the **Output** panel. Confirm that it first reports `Player is
   airborne.`, then reports `Player is on the floor.` after the Player lands.
6. Stop the running scene with `F8`.

> 💡 The messages repeat because `_physics_process()` runs continuously. They
> are a temporary way to see which branch runs; you will remove them before
> the lesson ends.

> ⚠️ **If something differs**
>
> - If the script editor reports an error, check the colon after `if` and
>   `else`, then confirm that each `print()` line is indented beneath its
>   branch.
> - If the Output never reports that the Player is on the floor, complete the
>   floor and collision checks from Lesson 2.9 before continuing.

### Part 2: Reverse a condition with `not`

1. Replace the temporary conditional with this version:

   ```gdscript
   if not is_on_floor():
       print("Player is airborne.")
   else:
       print("Player is on the floor.")
   ```

2. Save the script and run `main.tscn` again.
3. Confirm that the same two messages appear in the same order, then stop the
   scene.

> 💡 `not` reverses a `bool`. When `is_on_floor()` returns `false`, `not`
> changes that result to `true`, so the first branch runs while the Player is
> airborne. This is the condition that will control gravity in the next part.

### Part 3: Apply gravity only while airborne

1. Delete the `else:` line and its indented `print()` line.
2. Replace the remaining `print("Player is airborne.")` line with:

   ```gdscript
   velocity.y += gravity * delta
   ```

3. Compare your completed script with this version:

   ```gdscript
   extends CharacterBody2D

   var speed: float = 300.0
   var gravity: float = 980.0

   func _physics_process(delta: float) -> void:
       if not is_on_floor():
           velocity.y += gravity * delta

       var direction: float = Input.get_axis("move_left", "move_right")
       velocity.x = direction * speed
       move_and_slide()
   ```

4. Save the script with `Ctrl+S`.

When the Player is airborne, the condition is `true`, so gravity is added to
`velocity.y`. When the Player is on the floor, the condition is `false`, so
the indented calculation is skipped. The visible result remains falling and
landing, but the code now states that gravity applies only while airborne.

> ⚠️ **If something differs**
>
> - If the Player no longer falls, confirm that `not` appears before
>   `is_on_floor()` and that the gravity calculation is indented beneath the
>   `if` line.
> - If the Player falls through the floor, revisit the collision checks in
>   Lesson 2.9; this lesson does not change the floor setup.

### Part 4: Run and test the final condition

1. Run `main.tscn` with `F6`.
2. Confirm that the Player falls and lands on the floor.
3. Confirm that no temporary Output messages appear.
4. Hold `A` or Left Arrow, then `D` or Right Arrow. Confirm that horizontal
   movement still works while the Player is on the floor.
5. Release the input and confirm that the Player stops horizontally.
6. If a compatible controller is connected, test its configured horizontal
   controls too.
7. Confirm that `Project ready` still appears and that the Player marker is
   the only icon on screen.
8. Stop the running scene with `F8`.

## Learner exercise

1. Temporarily remove `not` from `if not is_on_floor():`.
2. Run `main.tscn` and observe that the Player remains at the starting
   position: before it has landed, `is_on_floor()` is `false`, so gravity is
   not applied.
3. Restore `not`, save, and run the scene again.
4. Explain why the Player falls only after `not` is restored.

## Verification checklist

- [ ] The temporary airborne and floor Output messages appeared during Part 1
      and were removed before the lesson ended.
- [ ] The final script uses `if not is_on_floor():`.
- [ ] The gravity calculation is indented beneath that condition.
- [ ] The final script contains no `else` branch or temporary `print()` calls.
- [ ] The Player falls, lands on the floor, and does not fall through it.
- [ ] Keyboard horizontal movement and stopping still work on the floor.
- [ ] Configured controller movement still works when a compatible controller
      is available.
- [ ] `Project ready` still appears, and the Player marker is the only icon on
      screen when `main.tscn` runs.
- [ ] The learner exercise ends with `not` restored.
- [ ] The Player cannot jump yet.

## References

- [Using CharacterBody2D/3D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
