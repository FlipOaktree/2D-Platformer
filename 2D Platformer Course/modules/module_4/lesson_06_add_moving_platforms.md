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
3. Rename the root `MovingPlatform` with `F2`.
4. Save the scene as `res://levels/moving_platform.tscn`.
5. Select `MovingPlatform` and add a child node of type **TileMapLayer**.
6. Rename it `Deck` with `F2`.
7. Drag `res://levels/tiles/terrain_tileset.tres` from **FileSystem** onto the
   `Deck`'s **Tile Set** property in the Inspector.
8. Still on `Deck`, find **Collision Enabled** in the Inspector and turn it
   **off**.
9. Open the **TileMap** tab, choose its **Terrains** tab, select the `Ground`
   terrain and the **Connect** painting mode, as in Lesson 2.
10. Paint three cells in a row: `(0, 0)`, `(1, 0)` and `(2, 0)`.
11. Set the `Deck`'s Position to `(-96, -32)`, so the painted strip sits
    centred on the platform's own origin.
12. Set the `Deck`'s **Modulate** to the hex value `FFCC99`.
13. Select `MovingPlatform` again and add a child node of type
    **CollisionShape2D**, leaving it at Position `(0, 0)`.
14. In the Inspector, set its **Shape** to a **New RectangleShape2D**, then
    open the shape and set **Size** to `(192, 64)`.
15. Confirm the collision rectangle covers the painted strip exactly.
16. Save the scene with `Ctrl+S`.

> 💡 `AnimatableBody2D` is the third kind of physics body this course has
> used, and the gap between the other two is exactly where it belongs. Lesson
> 2.9 introduced `StaticBody2D` as a body that does not move through code, and
> Lesson 2.2 introduced `CharacterBody2D` as the body an actor drives around.
> A moving platform is neither: it is not an actor, and it does not stay put.
> `AnimatableBody2D` is a solid surface that expects to be moved by code, and
> unlike a `StaticBody2D` that has been shoved to a new position, it tells the
> physics engine it is moving so that anything standing on it comes too.

> 💡 Step 8 is the one that is easy to skip and expensive to skip. A
> `TileMapLayer` normally builds its own collision from the tiles, and that
> collision belongs to the layer rather than to the body around it. Leave it
> on and the Player lands on the tiles instead of on the platform, and the
> tiles do not report that they are moving, so the Player is simply left
> behind while the platform slides out from under it. Turning it off makes the
> layer purely something to look at, and hands every question about solidity
> to the `CollisionShape2D` in step 13.

> 💡 The deck is painted rather than drawn from a single image, and that is
> what makes the scene worth reusing. The `Ground` terrain picks the two end
> pieces and the middle for you, exactly as it does in a level, so a platform
> of a different width is a different number of cells rather than a different
> picture. The learner exercise builds a wider one that way.

> 💡 `Ground` is the right terrain even though this is a platform, and the
> names work against you here. In this project `Platform` does not mean "a
> thing you stand on"; it means the pass-through strip from Lesson 4.5, and
> its tiles carry the pale blue tint that says so. This platform is solid: a
> jump from underneath stops against it. Painting it with the pass-through
> artwork would promise something the platform does not do, which is the rule
> from Lesson 4.5 read backwards. The two tints would also multiply into a
> drab `BFB899` rather than the warm colour you asked for.

> 💡 The tiles' own collision does not enter into it either way, because step
> 8 turned it off. Whether a deck tile is one-way is a question with no
> effect here; the `CollisionShape2D` decides everything about what this
> platform is solid from, and a plain rectangle is solid from every side.

> 💡 A `TileMapLayer` is a `Node2D` like any other, so moving it moves its
> tiles. Nothing about tiles makes them fixed in place; what fixes a level's
> tiles is that nothing ever moves the layer they are on.

> 💡 Step 11 centres the artwork on the platform. A `TileMapLayer` lays its
> grid out from its own origin, so cells `(0, 0)` to `(2, 0)` run right and
> down from it, putting the painted strip to one side. Nudging the layer by
> half its width and half its height puts the middle of the strip on the
> platform's origin, which is where the collision shape already is.

> 💡 The collision rectangle is set by hand to match the deck rather than
> worked out from it, and its Size belongs to the scene rather than to any one
> copy. A `RectangleShape2D` is a resource, and every instance of this scene
> shares the same one, so resizing a single platform in a level resizes all of
> them. A platform of a different width is therefore a copy of this scene
> whose deck is painted wider and whose Size matches, which is what the
> learner exercise builds.

> 💡 The tint follows the rule from Lesson 4.5: a surface that behaves
> differently should not look identical to one that does not. There the
> `Modulate` belonged to a tile; here it belongs to a node, and it tints
> everything that node draws. It is the same property applied one level up,
> and the node is the better place for it: the tint says "this one moves", and
> attaching it to the platform that moves means it cannot end up on anything
> that does not.

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

> 💡 `(1504, 736)` puts the deck at `y = 704`, the same surface height as the
> solid platform, and its left edge at `x = 1408`. The solid platform ends at
> `x = 1280`, so the gap is 128 pixels, two tiles wide.

> 💡 The gap is deliberate, and 128 pixels is not an arbitrary number. It has
> to be wide enough that the Player cannot walk across, so that getting aboard
> is a jump you have to time. It also keeps the two platforms from ever
> touching: a moving surface that comes to rest exactly flush against a fixed
> one leaves the Player able to stand half on each, supported by a sliver of
> the fixed platform's corner, which looks like standing on nothing.

> 💡 The platform is also reachable from the ground. A held jump rises 310
> pixels against the 256-pixel step from the ground surface at `y = 960` to
> the deck at `y = 704`, leaving 54 pixels of clearance. That is the same
> margin as the solid platform, so falling off is a setback and not a dead
> end.

> 💡 Placing it before writing a line of code is worth the extra step. An
> `AnimatableBody2D` with no script is simply a solid platform, so step 6
> proves the deck, the collision shape and the position are all right while
> there is nothing else that could be wrong. Every problem after this point
> belongs to the script.

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

> 💡 `travel` uses a plain `@export` while `speed` uses `@export_range()`. The
> range annotation from Lesson 3.1 puts a slider with a minimum, a maximum and
> a step on a single number, and a `Vector2` is two numbers, so there is no one
> range to give it. Godot shows it as an `x` and a `y` field instead.

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

> 💡 None of these are exported, for the same reason `coyote_timer` was not in
> Lesson 3.3: they change while the game runs and are not settings a designer
> picks. `travel` and `speed` describe the platform you want; these three are
> the platform's working notes about where it is going next.

> 💡 They are also the first variables in this course declared with no
> starting value, and the reason is timing rather than taste. It is worth
> knowing now, because the obvious thing to write is
> `var start_position: Vector2 = position`, and it does not work.

> 💡 A `var x = ...` line runs the moment the node is created, which is before
> Godot has applied anything the scene file or the level stored on it. At that
> moment the platform is still at `(0, 0)`, wherever the level means to put
> it, and `travel` still holds the default written in the script rather than
> the value the level set. The lift in the learner exercise would read a
> `travel` of `(256, 0)` and set off sideways. Reading both in `_ready()`,
> which runs after all of that, is what makes placement work at all.

9. Add two blank lines, then a function that works the path out once the
   platform exists:

   ```gdscript
   func _ready() -> void:
       start_position = position
       end_position = start_position + travel
       target = end_position
   ```

10. Save the script with `Ctrl+S`.

> 💡 The platform remembers where it was placed rather than being told where to
> go. `_ready()` runs once the node exists, reads the position it was dropped
> at, and works out the far end by adding `travel` to it. That is why the same
> scene can be dropped anywhere: the level decides the starting point by
> placement, and `travel` decides the rest.

> 💡 The `@onready` from Lesson 4.4 would work here too. It delays a variable
> until exactly the moment `_ready()` runs, so three `@onready` lines would
> read the same values this function does. The function is used instead
> because the three are worked out in order, each from the one before, and a
> function shows that order plainly. `@onready` earns its place when a
> variable only has to wait; a calculation with steps is clearer as a
> calculation.

> 💡 This uses `position`, not the `global_position` from Lesson 4.4, and the
> difference matters both times. There the level had to hand a point to
> somebody outside it, so it had to be in world coordinates. Here the platform
> is moving itself inside its own parent, so the level's own coordinates are
> the right ones. Move the whole level and the platform's path moves with it,
> which is what you want.

11. Add two blank lines, then the function that does the moving:

    ```gdscript
    func _physics_process(delta: float) -> void:
        position = position.move_toward(target, speed * delta)
    ```

12. Save the script, open `main.tscn`, and run it with `F6`.
13. Confirm the platform slides to the right, then stops and stays there. Ride
    it to the end, and confirm the Player is carried the whole way.
14. Stop the scene with `F8`.

> 💡 `move_toward()` is the function from Lesson 3.2, now doing the same job
> one dimension up. There it walked a number toward a number; here it walks a
> point toward a point, along the straight line between them. It never
> overshoots: when the remaining distance is smaller than one step it returns
> the target exactly.

> 💡 It has to be `_physics_process()`, not `_process()`. A solid body that
> moves has to move in step with the physics engine, or the Player's own
> collision checks will be testing against a position the platform has already
> left. Everything solid in this course moves on the physics clock for the
> same reason.

> 💡 A platform that travels once and parks is already most of the work, and it
> is worth stopping to watch. The Player riding it proves the hard part is
> done: a moving surface that carries what stands on it. What is missing is
> only that nothing ever sends it back.

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

> 💡 Arriving and turning around are two separate questions, which is why there
> are two `if` statements. The first asks whether the platform has got where it
> was going. The second asks which end it has reached, so it knows which one to
> head for next. Swapping the two targets is the whole of going back and forth.

> 💡 The arrival test is reliable because `move_toward()` snaps exactly. A
> position that merely gets close to its target would need a tolerance, and
> picking one is the sort of number that works until the speed changes.
> `is_equal_approx()` is used anyway, because comparing two decimal numbers for
> exact equality is a habit worth not forming.

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

> 💡 Step 4 is the whole lesson. The Player's own script is not involved: it
> reads no input, has no horizontal speed, and does nothing at all. It moves
> because `move_and_slide()` asks what it is standing on, finds a body that
> reports its own motion, and adds that motion to the Player's. Swap
> `AnimatableBody2D` for `StaticBody2D` and step 4 stops working while
> everything else still looks right.

> 💡 Step 9 is the contrast from Lesson 4.5, now with a surface that moves.
> The jump rises 64 pixels instead of the full 310, because the Player's head
> is already that close to the underside. The one-way strip lets a jump
> through; this platform stops it, which is what the `Ground` artwork on the
> deck promised.

> 💡 Step 7 works for the same reason, and is worth noticing. The Player
> leaves the platform carrying its speed, so it drifts along with it while
> airborne and comes down roughly where it left. A jump straight up off a
> moving train lands you back on the train, not on the tracks behind it.

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
- [ ] The script reads its starting point in `_ready()` rather than having
      endpoints written into it.
- [ ] `start_position`, `end_position` and `target` are declared with no
      starting value and assigned in `_ready()`.
- [ ] The learner can explain why `var start_position: Vector2 = position`
      would not work.
- [ ] The platform is moved in `_physics_process()`, not `_process()`.
- [ ] `level_1.tscn` contains exactly one `MovingPlatform` instance, a child
      of `Level`, at Position `(1504, 736)`.
- [ ] The platform travels 256 pixels right and returns, without drifting from
      its starting point over repeated trips.
- [ ] The deck sits at `y = 704` and the gap to the solid platform is 128
      pixels.
- [ ] A Player standing still on the platform is carried, and does not sink,
      bounce, or slide off over at least two turnarounds.
- [ ] A jump straight up from the moving platform lands back on it.
- [ ] The moving platform is solid from below: a jump from underneath stops
      against it rather than passing through.
- [ ] Running, jumping, coyote time, jump buffering, and variable jump height
      are unchanged.
- [ ] The ground, the solid platform, and the one-way strip behave as they did
      in Lesson 4.5.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner stood on the platform before it had a script, and rode it
      once before it could turn around.
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
