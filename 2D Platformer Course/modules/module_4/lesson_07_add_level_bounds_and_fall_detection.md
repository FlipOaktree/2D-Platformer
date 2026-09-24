# Module 4, Lesson 7: Add Level Bounds and Fall Detection

**Status:** Validated

## By the end

Give the level an edge it will not let you past, and a floor of last resort
below it. Until now every surface has caught the Player. This lesson opens a
hole that does not, then decides what should happen when the Player goes
through it.

- `level_1.tscn` has a three-tile pit in the ground, wide enough to fall into
  and fair to jump.
- Walls at the far left and right keep the Player inside the level.
- A `FallLimit` marker says how far down is too far.
- `level.gd` answers a second question: how far down may the Player go?
- `player.gd` gains its first method that is not a callback: put yourself
  here, and stop moving.
- `main.gd` watches for the fall and puts the Player back at the spawn point.
- Every level file carries its own `FallLimit`, because the shared `level.gd`
  now requires one.

## Before you start

- Module 4, Lesson 6 is complete and validated.
- `level_1.tscn` contains a `Level` root, a `Terrain` layer, a `Platforms`
  layer, a `PlayerSpawn` marker, and a `MovingPlatform` instance.
- `main.gd` places the Player using `level.get_spawn_position()`.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Shape the level's edges

1. Open `res://levels/level_1.tscn` and select the `Terrain` layer.
2. Open the **TileMap** tab, choose its **Terrains** tab, and select the
   `Ground` terrain, as in Lesson 2.
3. Turn on the eraser, and erase the six ground cells `(7, 15)`, `(8, 15)`,
   `(9, 15)`, `(7, 16)`, `(8, 16)` and `(9, 16)`.

> 💡 Three tiles, not two. The Player is two tiles wide, so over a two-tile
> hole one corner always rests on solid ground and it walks straight across.
> A pit has to be wider than what falls into it.

4. Confirm that a three-tile hole now runs all the way through the ground,
   and that the cells either side of it have redrawn themselves as ends
   rather than middles.

> 💡 Erasing with a terrain selected repairs the edges: the cells either side
> of the hole switch from middle tiles to end tiles on their own.

5. Select the `Level` root and add a child node of type **StaticBody2D**.

> 💡 A wall never moves, so the plain `StaticBody2D` from Lesson 2.9 is the
> right body here. The walls sit just outside the frame, so you never see
> them, and they are too tall to jump over.

6. Rename it `LeftWall` and set its Position to `(-32, 544)`.
7. Add a **CollisionShape2D** to `LeftWall`, give it a **New
   RectangleShape2D**, and set the shape's **Size** to `(64, 2048)`.
8. Right-click `LeftWall` in the Scene dock and choose **Duplicate**.

> 💡 Duplicating a node shares its shape, so both walls use one
> `RectangleShape2D`. Here that is what you want, since the two walls should
> always be the same size. Lesson 4.6 showed the case where sharing is a trap.

9. Rename the copy `RightWall` and set its Position to `(1952, 544)`.
10. Save `level_1.tscn` with `Ctrl+S`.
11. Open `main.tscn` and run it with `F6`.
12. Run to the far left and the far right, and confirm the Player stops at
    the edges of the frame instead of walking out of the level.
13. Run at the pit and jump it. Then walk into it on purpose and watch the
    Player drop out of the bottom of the screen and never come back.
14. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the ground either side of the pit still looks like unbroken middle
>   tiles, the eraser was used without a terrain selected. Undo with `Ctrl+Z`
>   and confirm the **Terrains** tab shows `Ground` before erasing.
> - If the Player walks over the pit without falling, fewer than three cells
>   were erased, or only the top row was.
> - If the Player can still leave the level sideways, a wall's
>   `CollisionShape2D` has no shape, or its **Size** is still `(0, 0)`.
> - If the Player is stopped well short of the frame edge, a wall Position is
>   wrong. They belong at `x = -32` and `x = 1952`, not at `0` and `1920`.

### Part 2: Mark how far down is too far

1. With `level_1.tscn` open, select the `Level` root and add a child node of
   type **Marker2D**.
2. Rename it `FallLimit` with `F2`.
3. Set its Position to `(960, 1216)`.
4. Confirm the cross sits below the ground and below the blue frame.
5. Save `level_1.tscn` with `Ctrl+S`.

> 💡 Only the marker's `y` matters: a fall limit is a depth, not a place. It
> sits below the bottom of the frame so the Player is out of sight before it
> is caught.

> ⚠️ **If something differs**
>
> - If you cannot see the cross, scroll down. It is below the frame, outside
>   the area the game shows.
> - If it sits inside the ground, its Position is wrong. It belongs at
>   `(960, 1216)`, well below the ground's underside at `y = 1088`.

### Part 3: Let the level report its fall limit

1. Open `res://levels/level.gd`.
2. Below the existing `player_spawn` line, add:

   ```gdscript
   @onready var fall_limit: Marker2D = $FallLimit
   ```

3. At the end of the script, after `get_spawn_position()`, add two blank
   lines and then:

   ```gdscript
   ## How far down the Player may go before it counts as having left.
   func get_fall_limit() -> float:
       return fall_limit.global_position.y
   ```

4. Save the script with `Ctrl+S`.

> 💡 It returns a `float`, not a `Vector2`, because a depth is one number. The
> marker's `x` is deliberately ignored.

> ⚠️ **If something differs**
>
> - If Godot reports that `fall_limit` is null, check `$FallLimit` against the
>   node's name in the Scene dock.
> - If it complains the return type is wrong, confirm the line ends in
>   `.global_position.y` and not `.global_position`.

### Part 4: Give the Player a way to be put back

1. Open `res://actors/player.gd`.
2. At the end of the script, after `_physics_process()`, add two blank lines
   and then:

   ```gdscript
   ## Put the Player at a point and clear any motion it had.
   func respawn_at(point: Vector2) -> void:
       global_position = point
       velocity = Vector2.ZERO
   ```

3. Save the script with `Ctrl+S`.

> 💡 This is the Player's first method that is not a callback. Godot calls
> `_physics_process()` itself; `respawn_at()` is there for another node to
> call.

> 💡 Clearing the velocity matters. A Player caught at the fall limit is still
> falling fast, and without this line it would arrive at the spawn point still
> carrying that speed.

> ⚠️ **If something differs**
>
> - If Godot reports that `velocity` is unknown, the function was added to the
>   wrong script. It belongs in `player.gd`, which extends `CharacterBody2D`.
> - If the function is indented inside `_physics_process()`, it will never be
>   callable from outside. It belongs at the left margin, like the other
>   `func` lines.

### Part 5: Have Main watch for the fall

1. Open `res://scenes/main.gd`.
2. At the end of the script, after `_ready()`, add two blank lines and then:

   ```gdscript
   func _physics_process(_delta: float) -> void:
       if player.global_position.y > level.get_fall_limit():
           player.respawn_at(level.get_spawn_position())
   ```

3. Save the script with `Ctrl+S`. Before running anything, predict what
   will now happen when the Player walks into the pit.

> 💡 The parameter is called `_delta` rather than `delta` because this
> function never uses it. Godot requires the parameter to be there, and the
> leading underscore is how GDScript says "I know, and I meant it", which
> keeps the editor from warning about an unused value.

> 💡 Use `>`, not `==`. The Player falls many pixels per frame, so it almost
> never lands on the limit exactly; the question is whether it has gone past.

> ⚠️ **If something differs**
>
> - If nothing happens when the Player falls, confirm `get_fall_limit()` is
>   spelled the same in both files and that `level.gd` was saved.
> - If the Player is teleported to the spawn point constantly and can never
>   move, the comparison is the wrong way round, or the `FallLimit` marker is
>   above the ground rather than below it.
> - If Godot reports that `respawn_at` is not found, `player.gd` was not saved
>   after Part 4.

### Part 6: Give the second level a fall limit too

1. Open `res://levels/level_2.tscn`, the level you made in the Lesson 3
   exercise.
2. Select its `Level` root and confirm that `level.gd` is attached, and that
   it has a `PlayerSpawn` marker but no `FallLimit`.
3. Add a child node of type **Marker2D**, rename it `FallLimit`, and set its
   Position to `(960, 1216)`.
4. Save `level_2.tscn` with `Ctrl+S`.
5. In `main.tscn`, delete the `Level` instance and drag `level_2.tscn` into
   `Main` in its place, checking its Position is `(0, 0)`.
6. Run the scene. Confirm the Player spawns and that the **Output** panel
   stays quiet, with no errors.
7. Walk to a place where your second level's ground runs out and step off the
   end of it. Confirm the Player falls and is put back at its spawn point.
8. Put `level_1.tscn` back in `main.tscn`, again at Position `(0, 0)`, and
   save.

> 💡 One script shared by every level is one promise every level file has to
> keep: `level.gd` expects a `FallLimit` in each. Walls are different. No
> script asks for them, so a level without walls is not broken, only open at
> the sides.

> ⚠️ **If something differs**
>
> - If the **Output** panel fills with `null instance` errors, the marker is
>   missing or misspelled. It has to be called `FallLimit` exactly.
> - If the Player never comes back after running off the side, the marker is
>   above the level rather than below it.
> - If `level_2` has no `level.gd` attached, add it as the Lesson 4 exercise
>   described, then repeat this part.

### Part 7: Test the whole boundary

1. Open `res://scenes/main.tscn` and run it with `F6`.
2. Confirm the Player starts at the spawn marker as it did in Lesson 4.4.
3. Run at the pit and jump it. Confirm the jump is comfortable rather than
   exact, and that you can take off well before the lip and still land.
4. Walk into the pit on purpose. Confirm the Player drops out of sight and
   is back at the spawn point about half a second later.
5. Confirm the Player is standing still when it reappears, not sliding or
   dropping.
6. Fall in several times in a row and confirm it works every time.
7. Run into the left wall and the right wall and confirm the Player stops at
   the edges of the frame.
8. Jump against each wall and confirm it cannot be climbed or cleared.
9. Ride the moving platform and step off the far end. Confirm the Player
   lands on the ground rather than being caught by the fall limit.

> 💡 A fall limit set too high would catch the Player here, snatching it off a
> landing it had made. This level's lowest safe surface is the ground at
> `y = 960`, well above the limit at `1216`.

10. Confirm the one-way strip, the solid platform, and the moving platform
    all behave as they did in Lesson 4.6.
11. If a compatible controller is connected, repeat the checks with it.
12. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player respawns after an ordinary landing, the `FallLimit` marker
>   is too high. It belongs below the ground, not above it.
> - If the Player falls forever, `main.gd` has no `_physics_process()`, or it
>   was saved without the comparison.
> - If the Player reappears already falling, the `velocity = Vector2.ZERO`
>   line is missing from `respawn_at()`.

## Learner exercise

1. Move `FallLimit` up to `(960, 800)`, above the ground, and run the scene.
   Watch what happens, and explain it in one sentence.
2. Put `FallLimit` back at `(960, 1216)` and save.
3. Widen the pit to four tiles by erasing `(10, 15)` and `(10, 16)` as well.
   Run and confirm the jump is noticeably harder, then undo with `Ctrl+Z`.
4. Open `level_2.tscn` and give it a pit of its own, then swap it into
   `main.tscn` and confirm falling into it works with no change to `main.gd`
   or `player.gd`.
5. Restore `level_1.tscn` in `main.tscn` at Position `(0, 0)`.
6. Explain why the fall check lives in `main.gd` rather than in `player.gd`,
   and what would have to be true for the Player to check for itself.
7. Explain why `get_fall_limit()` returns a number while
   `get_spawn_position()` returns a position.

## Verification checklist

- [ ] `level_1.tscn`'s `Terrain` layer has 64 painted cells, six fewer than
      the 70 it had at the end of Lesson 6.
- [ ] The ground cells either side of the pit show end pieces, not middles.
- [ ] `level_1.tscn` contains `LeftWall` and `RightWall`, both
      `StaticBody2D`, at Positions `(-32, 544)` and `(1952, 544)`, each with a
      `CollisionShape2D` using a `RectangleShape2D` of Size `(64, 2048)`.
- [ ] The Player comes to rest against the walls at `x = 64` and `x = 1856`.
- [ ] `level_1.tscn` contains a `Marker2D` named `FallLimit` at Position
      `(960, 1216)`.
- [ ] `level.gd` declares `fall_limit` with `@onready` and typed as
      `Marker2D`.
- [ ] `get_fall_limit()` returns a `float` taken from `global_position.y`.
- [ ] `player.gd` has a `respawn_at(point: Vector2)` method that sets
      `global_position` and clears `velocity`.
- [ ] `main.gd` compares the Player's `global_position.y` against
      `level.get_fall_limit()` inside `_physics_process()`.
- [ ] `main.gd` names no node inside the level, and mentions neither the pit
      nor the walls.
- [ ] Walking into the pit puts the Player back at the spawn point, standing
      still, about half a second later.
- [ ] Stepping off the moving platform lands on the ground and does not
      trigger a respawn.
- [ ] Running, jumping, coyote time, jump buffering, and variable jump height
      are unchanged.
- [ ] The one-way strip and the moving platform behave as they did in Lesson
      4.6.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors,
      or unexplained warnings.
- [ ] The learner saw what a badly placed fall limit does, and can say why.
- [ ] `level_2.tscn` has its own `FallLimit` marker, and swapping it into
      `main.tscn` produces no `null instance` errors in **Output**.
- [ ] The learner gave a second level a pit of its own without editing
      `main.gd` or `player.gd`.
- [ ] The learner can explain why the check lives in `Main`.

## References

- [StaticBody2D](https://docs.godotengine.org/en/4.7/classes/class_staticbody2d.html)
- [Marker2D](https://docs.godotengine.org/en/4.7/classes/class_marker2d.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
