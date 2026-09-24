# Module 4, Lesson 6: Add Moving Platforms

**Status:** Validated

## By the end

Build a platform that travels back and forth and carries the Player with it.
Everything solid so far has stayed where it was put. This one moves under the
Player's feet, and the Player goes along for the ride.

- `res://levels/moving_platform.tscn` is a reusable scene: one moving surface
  you can drop into any level, with a deck painted from the tiles you already
  have rather than drawn as a fixed picture.
- `moving_platform.gd` walks it between two points and turns it around.
- Two exported values, `travel` and `speed`, decide where a copy goes and how
  fast, so a second copy can be a lift without touching the script.
- `level_1.tscn` holds one instance, reachable by a jump from the solid
  platform.
- Standing still on it moves the Player. Running, jumping, coyote time, jump
  buffering, and variable jump height are unchanged.

## Before you start

- Module 4, Lesson 5 is complete and validated.
- `level_1.tscn` contains a `Level` root, a `Terrain` layer, a `Platforms`
  layer holding the one-way strip, and a `PlayerSpawn` marker.
- `main.tscn` lists `Level` first and `Player` second.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Build the moving platform scene

1. In **FileSystem**, right-click `res://levels/` and choose **Create New >
   Scene...**.
2. Set the root node type to **Other Node**, search for `AnimatableBody2D`,
   and create it.

> 💡 `AnimatableBody2D` sits between the two bodies you know. A `StaticBody2D`
> never moves, and a `CharacterBody2D` is an actor that drives itself around.
> An `AnimatableBody2D` is a solid surface that code moves, and it tells the
> physics engine it is moving so that anything standing on it comes too.

3. Rename the root `MovingPlatform` with `F2`.
4. Save the scene as `res://levels/moving_platform.tscn`.
5. Select `MovingPlatform` and add a child node of type **TileMapLayer**.
6. Rename it `Deck` with `F2`.
7. Drag `res://levels/tiles/terrain_tileset.tres` from **FileSystem** onto the
   `Deck`'s **Tile Set** property in the Inspector.
8. Still on `Deck`, find **Collision Enabled** in the Inspector and turn it
   **off**.

> 💡 This is the easy step to skip. A `TileMapLayer` builds its own collision
> from its tiles, and that collision does not report that the platform is
> moving. Leave it on and the Player lands on the tiles and is left behind
> while the platform slides away. With it off, the `CollisionShape2D` you add
> in step 13 is the only thing that is solid.

9. Open the **TileMap** tab, choose its **Terrains** tab, select the `Ground`
   terrain and the **Connect** painting mode, as in Lesson 2.

> 💡 Use `Ground`, not `Platform`, even though this is a platform. In this
> project `Platform` is the pale blue pass-through strip from Lesson 4.5, and
> this deck is solid, so its artwork should not suggest otherwise.

10. Paint three cells in a row: `(0, 0)`, `(1, 0)` and `(2, 0)`.
11. Set the `Deck`'s Position to `(-96, -32)`, so the painted strip sits
    centred on the platform's own origin.

> 💡 A `TileMapLayer` lays its cells out to the right of and below its own
> origin. Moving it by half the strip's size puts the middle of the strip on
> the platform's origin, where the collision shape sits.

12. Set the `Deck`'s **Modulate** to the hex value `FFCC99`.
13. Select `MovingPlatform` again and add a child node of type
    **CollisionShape2D**, leaving it at Position `(0, 0)`.
14. In the Inspector, set its **Shape** to a **New RectangleShape2D**, then
    open the shape and set **Size** to `(192, 64)`.

> 💡 Every copy of this scene shares one `RectangleShape2D`, so resizing the
> shape on one platform in a level resizes them all. A platform of a different
> width is a copy of the scene with more cells painted and a matching Size.

15. Confirm the collision rectangle covers the painted strip exactly.
16. Save the scene with `Ctrl+S`.

> 💡 A `TileMapLayer` is a `Node2D` like any other, so it moves with the
> platform. Because the deck is painted with a terrain, a wider platform is
> just more cells, which the learner exercise uses.

> ⚠️ **If something differs**
>
> - If painting leaves cells empty, confirm the **Terrains** tab is set to
>   `Ground` and not `Platform`. The moving platform is solid.
> - If the strip looks like the middle of a longer bar with no end pieces,
>   more than three cells were painted, or a cell was painted on a second row.
> - If the artwork sits up and to the left of the collision rectangle, the
>   `Deck` Position is still `(0, 0)`. It belongs at `(-96, -32)`.
> - If **Size** under **Shape** cannot be edited, the shape is still empty.
>   Choose **New RectangleShape2D** first, then click it to open it.

### Part 2: Put one in the level

1. Open `res://levels/level_1.tscn`.
2. Drag `moving_platform.tscn` from **FileSystem** onto the `Level` root, so
   the instance becomes a child of `Level`.
3. Select the new `MovingPlatform` instance and set its Position to
   `(1504, 736)`.
4. Confirm the platform sits at the same height as the solid platform, to the
   right of it, with a visible gap between the two.
5. Save `level_1.tscn` with `Ctrl+S`.
6. Open `res://scenes/main.tscn`, run it with `F6`, and confirm the Player can
   jump the gap and stand on the new platform. It does not move yet.
7. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the platform lands somewhere unexpected, dropping a scene into the 2D
>   viewport places it where the mouse was. Set the Position by hand.
> - If the instance is a child of `Terrain` or `Platforms` rather than of
>   `Level`, drag it onto the `Level` row directly.
> - If the Player falls through the platform, the `CollisionShape2D` in
>   `moving_platform.tscn` has no shape, or its **Size** is still `(0, 0)`.
> - If the Player lands on empty air beside the artwork, the `Deck` and the
>   collision shape are not in the same place. The `Deck` belongs at
>   `(-96, -32)` and the `CollisionShape2D` at `(0, 0)`.

### Part 3: Give it a path to travel

1. Open `res://levels/moving_platform.tscn`, select the `MovingPlatform` root,
   and attach a new script saved as `res://levels/moving_platform.gd`.
2. Replace the generated contents with a single line:

   ```gdscript
   extends AnimatableBody2D
   ```

3. Add a blank line, then the two settings a level is allowed to change:

   ```gdscript
   ## How far the platform travels from where it is placed, in pixels.
   @export var travel: Vector2 = Vector2(256, 0)

   ## How fast the platform moves along its path, in pixels per second.
   @export_range(0.0, 600.0, 10.0)
   var speed: float = 150.0
   ```

4. Save `moving_platform.gd` with `Ctrl+S`.
5. Select the `MovingPlatform` root and confirm that **Travel** shows `x 256`
   and `y 0`, and that **Speed** shows `150`, in the Inspector.
6. Hover over each and confirm the tooltips describe the distance travelled
   and the speed along the path.

> 💡 `travel` is an offset, not a destination. `(256, 0)` means 256 pixels to
> the right of wherever this copy sits, so moving the platform in the editor
> moves its whole path with it. A destination would have to be retyped every
> time the platform moved.

> ⚠️ **If something differs**
>
> - If **Travel** does not appear in the Inspector, its `@export` line is
>   missing or is not directly above the variable it belongs to.
> - If **Speed** appears as a plain number box instead of a slider, the
>   annotation is `@export` rather than `@export_range()`.

7. Add a blank line, then the three variables the platform uses to keep track
   of its own path:

   ```gdscript
   var start_position: Vector2
   var end_position: Vector2
   var target: Vector2
   ```

8. Save the script and confirm that none of the three appear in the Inspector.

> 💡 These three have no starting value because the platform cannot know its
> path until it has been placed. The obvious shortcut,
> `var start_position: Vector2 = position`, does not work: a line like that
> runs the moment the node is created, before Godot applies the position and
> **Travel** the level gave it, so it would read `(0, 0)` and the script's
> default `travel`. `_ready()` runs after both are in place.

9. Add two blank lines, then a function that works the path out once the
   platform exists:

   ```gdscript
   func _ready() -> void:
       start_position = position
       end_position = start_position + travel
       target = end_position
   ```

10. Save the script with `Ctrl+S`.

> 💡 This is `position`, not the `global_position` from Lesson 4.4. The
> platform moves itself inside its own level, so the level's coordinates are
> the right ones, and moving the whole level moves the path with it.

11. Add two blank lines, then the function that does the moving:

    ```gdscript
    func _physics_process(delta: float) -> void:
        position = position.move_toward(target, speed * delta)
    ```

12. Save the script and open `main.tscn`. Predict what the platform will do,
    and what happens to a Player standing on it, then run it with `F6`.
13. Confirm the platform slides to the right, then stops and stays there. Ride
    it to the end, and confirm the Player is carried the whole way.
14. Stop the scene with `F8`.

> 💡 `move_toward()` from Lesson 3.2 works on a `Vector2` too, walking a point
> toward a point. It never overshoots: on the final step it returns the
> target exactly.

> 💡 It has to be `_physics_process()`, not `_process()`. A solid body that
> moves has to move in step with the physics engine, or the Player's own
> collision checks will be testing against a position the platform has already
> left. Everything solid in this course moves on the physics clock for the
> same reason.

> ⚠️ **If something differs**
>
> - If Godot reports that `move_toward` expects a number, confirm you wrote
>   `position.move_toward(...)` and not the bare `move_toward(...)` used in
>   `player.gd`. The `Vector2` version is a method on the value.
> - If the platform does not move, confirm the script is attached to the
>   scene's root and that **Speed** is not zero.
> - If it moves but the Player is left behind, the root is the wrong node type.
>   Confirm it is an `AnimatableBody2D` and that **Sync To Physics** is on.

15. Add the turnaround to the end of `_physics_process()`, below the line you
    added in step 11:

    ```gdscript
        # Turn around on arrival.
        if position.is_equal_approx(target):
            if target == end_position:
                target = start_position
            else:
                target = end_position
    ```

16. Save the script and the scene with `Ctrl+S`.

> 💡 `is_equal_approx()` compares two positions while allowing for tiny
> rounding differences. Comparing decimal numbers with `==` is a habit worth
> avoiding.

> ⚠️ **If something differs**
>
> - If the platform still runs off and never returns, the turnaround block is
>   indented inside `_ready()` rather than `_physics_process()`.
> - If every platform travels 256 pixels to the right no matter what its
>   **Travel** says, and each one snaps to the top-left corner before it
>   starts, the three values are being read where they are declared rather
>   than in `_ready()`.
> - If it shudders at one end instead of turning cleanly, the inner `if` is
>   comparing against `start_position` in both branches, so it is choosing the
>   end it has just reached.

### Part 4: Test that it carries the Player

1. Open `res://scenes/main.tscn` and run it with `F6`.
2. Confirm the platform slides right, stops, and comes back, over and over.
3. Run right along the solid platform and jump the gap onto the moving one.
4. Let go of every key and stand still. Confirm the Player travels with the
   platform instead of staying where it is.

> 💡 The Player's own script does nothing here: no input, no speed. It moves
> because `move_and_slide()` finds it is standing on a body that reports its
> own motion, and adds that motion to the Player's. This is what
> `AnimatableBody2D` is for.

5. Stay aboard through at least two turnarounds and confirm the Player does
   not slide off the end or sink into the deck.
6. Walk from one end of the moving deck to the other while it travels, and
   confirm walking and riding add up rather than fighting each other.
7. Jump straight up off the moving platform and confirm the Player lands back
   on it.
8. Step off the edge and confirm the Player falls to the ground, then jump
   from the ground back onto the platform.
9. Stand on the ground under the platform's path and jump straight up as it
   passes overhead. Confirm the Player's head stops against its underside
   rather than passing through.
10. Confirm the ground, the solid platform, and the one-way strip all behave as
    they did in Lesson 4.5.
11. If a compatible controller is connected, repeat the checks with it.
12. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player stands still while the platform slides out from under it,
>   the root is the wrong node type. Confirm it is an `AnimatableBody2D`, and
>   that **Sync To Physics** is on in the Inspector.
> - If the Player jitters or sinks slightly each frame, the platform is being
>   moved in `_process()` instead of `_physics_process()`.
> - If the Player is drawn behind the platform, the instance was added to
>   `main.tscn` rather than to the level, and is sitting after the Player in
>   the child order.
> - If the platform does not move at all, confirm the script is attached to
>   the scene's root and that **Speed** is not zero.

## Learner exercise

1. In `level_1.tscn`, add a second instance of `moving_platform.tscn` and set
   its Position to `(1504, 928)`, so it rests on the ground.
2. On that instance only, set **Travel** to `(0, -192)`.
3. Run the scene. Confirm the second platform is a lift, riding up and down,
   and that the Player is carried both ways.
4. Explain why this needed no change to `moving_platform.gd`, and which two
   things you changed instead.
5. Set the lift's **Speed** to `400` and ride it again. Describe what riding a
   fast lift downward feels like, and predict what would happen if it fell
   faster than gravity.
6. Set **Speed** back to `150`, delete the second instance, and save.
7. In **FileSystem**, duplicate `moving_platform.tscn` and name the copy
   `moving_platform_long.tscn`.
8. Open it, paint two more cells on the `Deck` so it is five wide, set the
   `Deck` Position to `(-160, -32)`, and set the collision **Size** to
   `(320, 64)`.
9. Place one in `level_1.tscn`, ride it, then delete it and save.
10. Explain why the wider platform needed a copy of the scene rather than a
    setting on the instance, and what would break if you tried to change one
    instance's collision **Size** in the Inspector instead.
11. Explain why the platform stores `start_position` in `_ready()` rather than
    writing the two endpoints into the script.

## Verification checklist

- [ ] `res://levels/moving_platform.tscn` exists with an `AnimatableBody2D`
      root named `MovingPlatform`.
- [ ] The root's **Sync To Physics** is on.
- [ ] The scene has one `TileMapLayer` named `Deck`, using
      `terrain_tileset.tres`, at Position `(-96, -32)`.
- [ ] The `Deck` holds exactly three cells, `(0, 0)` to `(2, 0)`, painted
      with the `Ground` terrain, showing two end pieces and one middle.
- [ ] The `Deck`'s **Collision Enabled** is off.
- [ ] The `Deck`'s **Modulate** is `FFCC99`.
- [ ] The scene has one `CollisionShape2D` holding a `RectangleShape2D` of
      Size `(192, 64)`, at Position `(0, 0)`.
- [ ] `res://levels/moving_platform.gd` is attached to the scene's root.
- [ ] The script exports `travel` as a `Vector2` and `speed` as a float with
      an `@export_range()` annotation.
- [ ] `start_position`, `end_position` and `target` are declared with no
      starting value and assigned in `_ready()`.
- [ ] The learner can explain why `var start_position: Vector2 = position`
      would not work.
- [ ] The platform is moved in `_physics_process()`, not `_process()`.
- [ ] `level_1.tscn` contains exactly one `MovingPlatform` instance, a child
      of `Level`, at Position `(1504, 736)`.
- [ ] The platform travels 256 pixels right and returns, without drifting from
      its starting point over repeated trips.
- [ ] A Player standing still on the platform is carried, and does not sink,
      bounce, or slide off over at least two turnarounds.
- [ ] The moving platform is solid from below: a jump from underneath stops
      against it rather than passing through.
- [ ] Running, jumping, coyote time, jump buffering, and variable jump height
      are unchanged.
- [ ] The ground, the solid platform, and the one-way strip behave as they did
      in Lesson 4.5.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner made a vertical lift from the same scene by changing only
      its Position and **Travel**.
- [ ] The learner built a five-tile-wide platform by copying the scene and
      painting it, and can explain why the width is not an instance setting.
- [ ] The learner can explain why a moving surface is an `AnimatableBody2D`
      rather than a `StaticBody2D` or a `CharacterBody2D`.
- [ ] The learner can explain why the platform uses `position` here when
      Lesson 4.4 used `global_position`.

## References

- [AnimatableBody2D](https://docs.godotengine.org/en/4.7/classes/class_animatablebody2d.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [Using CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
- [Vector2](https://docs.godotengine.org/en/4.7/classes/class_vector2.html)
