# Module 2, Lesson 9: Add Gravity and Floor Collision

**Status:** Blueprint drafted

## By the end

Add a temporary floor to `main.tscn`, then give the Player gravity. When you
run the scene, the Player will fall, land on the floor, and retain the
horizontal movement from Lesson 2.8.

This lesson adds falling and floor collision only. Jumping will be added in
Lesson 2.10.

## Before you start

- Module 2, Lesson 8 is complete.
- `main.tscn` contains one Player instance at Position `(128, 128)`.
- The Player has its inherited 32-by-32 collision shape and temporary
  16-by-16 visual marker.
- `res://actors/player.gd` contains the validated horizontal movement code
  from Lesson 2.8.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Create a temporary floor

1. Open `res://scenes/main.tscn`.
2. In the **Scene** dock, select the `Main` root.
3. Click **Add Child Node**, search for `StaticBody2D`, and create it.
4. Rename the new node `Floor`.
5. With `Floor` selected, set its Inspector **Position** to `(576, 560)`.
6. Add a `CollisionShape2D` as a child of `Floor`.
7. Select the new `CollisionShape2D`. In the Inspector, choose **New
   RectangleShape2D** for its **Shape**.
8. Click the new rectangle resource to expand it, then set its **Size** to
   `(1152, 64)`.
9. Save the scene with `Ctrl+S`.

> 💡 A `StaticBody2D` is a physics body that does not move. It is useful for
> floors, walls, and other solid level geometry. Its `CollisionShape2D`
> defines the solid area but does not draw visible artwork. This floor is
> temporary test geometry; a later module will build reusable levels.

> ⚠️ **If something differs**
>
> - If `Floor` can move independently of `Main` in the Scene dock, confirm
>   that it is a direct child of `Main`.
> - If a warning icon remains beside `CollisionShape2D`, confirm that its
>   Shape contains a `RectangleShape2D`.
> - If your Inspector values differ, reselect `Floor` for Position and its
>   `CollisionShape2D` child for the rectangle Size.

### Part 2: Add a gravity value

1. Open `res://actors/player.gd`.
2. Add this typed variable beneath `speed`:

   ```gdscript
   var gravity: float = 980.0
   ```

3. Save the script with `Ctrl+S`.

> 💡 Gravity is an acceleration: it changes vertical speed over time. The
> value `980.0` means the Player's downward speed can increase by 980 pixels
> per second over one second. As established in Lesson 1.2, positive Y points
> downward in Godot's 2D coordinate system.

### Part 3: Apply gravity over time

1. In `_physics_process()`, rename the `_delta` parameter to `delta`:

   ```gdscript
   func _physics_process(delta: float) -> void:
   ```

2. Add this indented line at the beginning of the function, above the
   `direction` variable:

   ```gdscript
   velocity.y += gravity * delta
   ```

`delta` contains the time since the previous physics update. Multiplying
gravity by `delta` keeps the rate of falling consistent over time. The leading
underscore is removed from `delta` because the script now uses it.

> ⚠️ **If something differs**
>
> - If Godot reports that `delta` is not declared, confirm that `_delta` was
>   renamed in the function line as well as the gravity calculation.
> - If the gravity line causes an indentation error, align it with the
>   `direction`, `velocity.x`, and `move_and_slide()` lines.

### Part 4: Apply gravity only while airborne

1. Add this line immediately above the gravity calculation:

   ```gdscript
   if not is_on_floor():
   ```

2. Indent the gravity calculation one additional level so both lines read:

   ```gdscript
   if not is_on_floor():
       velocity.y += gravity * delta
   ```

> 💡 An `if` statement runs its indented instructions only when its condition
> is `true`. `is_on_floor()` reports whether `move_and_slide()` detected a
> floor during the previous movement. `not` reverses that result, so this
> condition applies gravity only while the Player is not on a floor.

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

`move_and_slide()` remains after the velocity calculations. It moves the
Player, handles the collision with the floor, and updates the floor state used
by `is_on_floor()` during the following physics update.

> ⚠️ **If something differs**
>
> - If the script editor reports an error on the `if` line, confirm that it
>   ends with a colon and that the gravity calculation is indented beneath it.

### Part 5: Run and test falling and landing

1. Open `res://scenes/main.tscn`.
2. In the editor's **Debug** menu, enable **Visible Collision Shapes**.
3. Run the current scene with `F6`.
4. Confirm that the Player falls and stops on top of the floor.
5. Hold `A` or Left Arrow, then `D` or Right Arrow. Confirm that horizontal
   movement still works while the Player is on the floor.
6. Release the input and confirm that the Player stops horizontally without
   falling through the floor.
7. If a compatible controller is connected, test its configured horizontal
   controls too.
8. Confirm that `Project ready` and the project icon still appear.
9. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player falls through the floor, confirm that both the Player and
>   Floor have a `CollisionShape2D` with a rectangle Shape assigned.
> - If the Player does not fall, confirm that the calculation changes
>   `velocity.y` and is inside `_physics_process()`.
> - If the Player lands but does not move horizontally, compare the completed
>   script with the Lesson 2.8 movement lines and confirm none were removed.
> - If the scene runs without the Player or floor, stop it and confirm that
>   you opened and ran `main.tscn`, not `player.tscn`.

## Learner exercise

1. Change `gravity` from `980.0` to `490.0`.
2. Run `main.tscn` and observe how the lower value changes the fall.
3. Restore `gravity` to `980.0`, save, and run the scene again.
4. Explain why gravity is multiplied by `delta`.
5. Explain when the indented gravity calculation runs and when it is skipped.

## Verification checklist

- [ ] `main.tscn` contains a `Floor` `StaticBody2D` at Position `(576, 560)`.
- [ ] `Floor` has a `CollisionShape2D` using a `RectangleShape2D` with Size
      `(1152, 64)`.
- [ ] `res://actors/player.gd` declares typed `speed` and `gravity` variables.
- [ ] `_physics_process()` uses the `delta` parameter without a leading
      underscore.
- [ ] Gravity changes `velocity.y` by `gravity * delta` only when the Player
      is not on the floor.
- [ ] `move_and_slide()` remains after the vertical and horizontal velocity
      calculations.
- [ ] The Player falls, lands on the floor, and does not fall through it.
- [ ] Keyboard horizontal movement and stopping still work on the floor.
- [ ] Configured controller movement still works when a compatible controller
      is available.
- [ ] `Project ready` and the project icon still appear when `main.tscn` runs.
- [ ] The gravity exercise ends with `gravity` restored to `980.0`.
- [ ] The Player cannot jump yet.

## References

- [Using CharacterBody2D/3D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [StaticBody2D](https://docs.godotengine.org/en/4.7/classes/class_staticbody2d.html)
- [CollisionShape2D](https://docs.godotengine.org/en/4.7/classes/class_collisionshape2d.html)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
