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
4. Confirm that a three-tile hole now runs all the way through the ground,
   and that the cells either side of it have redrawn themselves as ends
   rather than middles.
5. Select the `Level` root and add a child node of type **StaticBody2D**.
6. Rename it `LeftWall` and set its Position to `(-32, 544)`.
7. Add a **CollisionShape2D** to `LeftWall`, give it a **New
   RectangleShape2D**, and set the shape's **Size** to `(64, 2048)`.
8. Right-click `LeftWall` in the Scene dock and choose **Duplicate**.
9. Rename the copy `RightWall` and set its Position to `(1952, 544)`.
10. Save `level_1.tscn` with `Ctrl+S`.
11. Open `main.tscn` and run it with `F6`.
12. Run to the far left and the far right, and confirm the Player stops at
    the edges of the frame instead of walking out of the level.
13. Run at the pit and jump it. Then walk into it on purpose and watch the
    Player drop out of the bottom of the screen and never come back.
14. Stop the scene with `F8`.

> 💡 A hole is the point of this lesson. Every surface built so far catches
> the Player: the ground is continuous, the platforms are above it, and the
> walls you just added close the sides. Without somewhere to fall, there is
> nothing for fall detection to detect. The pit is what makes the rest of the
> lesson mean something.

> 💡 Three tiles, not two, and the reason is the Player's own size. The Player
> is 128 pixels wide, which is exactly two tiles. Over a two-tile hole it
> always has at least one corner resting on solid ground, so it walks across
> as though the hole were not there. A pit has to be wider than the thing
> falling into it. Three tiles leaves a 64-pixel stretch where nothing is
> under the Player at all.

> 💡 The pit is 192 pixels across, and jumping it is fair rather than fussy.
> A run-up at full speed clears it from anywhere in the last 192 pixels before
> the lip, which is a window of about `0.43` seconds. That is the same kind of
> number as the coyote time from Lesson 3.3: what matters is not the single
> perfect moment but how much room there is around it.

> 💡 Erasing with a terrain selected repairs the edges for you. The cells at
> `(6, 15)` and `(10, 15)` were middles of a long run of ground a moment ago;
> now they are the ends either side of a hole, and Godot has swapped their
> tiles to match. This is the autotiling from Lesson 2 working in reverse, and
> it is why the pit has proper lips rather than a sliced-through look.

> 💡 The walls are `StaticBody2D`, the body type from Lesson 2.9, and here the
> oldest one is exactly right. Lesson 4.6 needed `AnimatableBody2D` because a
> moving platform moves. A wall never moves, never carries anybody, and has
> nothing to say to the physics engine beyond being in the way.

> 💡 Duplicating the first wall copies its `CollisionShape2D` and shares the
> shape itself, so both walls use one `RectangleShape2D` between them. Lesson
> 4.6 treated that sharing as a trap, and here it is the opposite: two walls
> holding the level in should be the same size, so one shape resized once is
> the behaviour you want. The rule is not that sharing is bad, but that it is
> worth knowing about. It is a problem when copies need to differ and a
> convenience when they must not.

> 💡 The walls sit just outside the frame, from `x = -64` to `0` and from
> `x = 1920` to `1984`, so you never see them. The Player stops with its own
> edge against the edge of the view: its centre comes to rest at `x = 64` on
> the left and `x = 1856` on the right. They are 2048 pixels tall so there is
> no jumping over them.

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

> 💡 This is the same `Marker2D` as the spawn point in Lesson 4.4, used for
> the same reason: the level is the only thing that knows its own shape, so
> the level is where the answer belongs. A level with a deeper pit would put
> its marker lower.

> 💡 Only the marker's `y` matters. A fall limit is a depth, not a place, so
> the `x` of `960` is there purely to put the cross in the middle of the
> level where it is easy to find. Dragging it left or right changes nothing.

> 💡 `1216` is below the frame on purpose, not merely below the ground. The
> ground's underside is at `y = 1088` and the visible frame ends at `1080`,
> so a Player falling through the pit is out of sight for about `0.13`
> seconds before it is caught. Putting the limit where it can still be seen
> would mean watching the Player stop in mid-air and vanish.

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

> 💡 The level can now answer two questions instead of one, and they are the
> same shape of promise. `get_spawn_position()` says where the Player starts;
> `get_fall_limit()` says how far down it may go. Neither tells anybody how
> the level is built inside, so the markers can be renamed or moved without a
> line changing anywhere else.

> 💡 It returns a `float`, not a `Vector2`, because a depth is one number. The
> marker has an `x` and the method deliberately throws it away. Returning the
> whole position would invite somebody to use the `x` for something, and then
> moving the cross sideways would start to matter.

> 💡 `global_position` again, for the reason Lesson 4.4 gave. The number
> leaves the level and is compared against the Player's own world position, so
> both sides have to be measuring from the same origin.

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

> 💡 This is the Player's first method that is not a callback. Everything in
> `player.gd` so far has been Godot calling the Player: `_physics_process()`
> runs because the engine runs it. `respawn_at()` is different. It is there
> for somebody else to call, and it is the Player's answer to being told to
> start again.

> 💡 It pairs with `get_spawn_position()`, and the pair is the shape of the
> whole design. The level is asked a question. The Player is given an
> instruction. `Main` does neither job itself; it carries the answer from one
> to the other.

> 💡 Clearing the velocity is the half that is easy to leave out. A Player
> caught at the fall limit is moving at about `1240` pixels per second
> downward and `90` sideways, and without this line it arrives at the spawn
> point still carrying all of it. At this level's marker, which sits on the
> ground, the difference is under a pixel, because the floor stops it on the
> first frame. Move the marker into the air, as the Lesson 4.4 exercise does,
> and the Player drops from it as though it had never stopped falling.

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

3. Save the script with `Ctrl+S`.

> 💡 `Main` still knows nothing about the level. It has never heard of the
> pit, the walls, or either marker. It asks how far down is too far, compares
> that with where the Player is, and if the answer is bad it asks where the
> Player should start and tells the Player to go there. Every fact about the
> level stays inside the level.

> 💡 It has to be `_physics_process()`, not `_process()`. The position being
> read is the one physics moved, so the check belongs on the same clock. In
> `_process()` it would sometimes test a position from the previous physics
> frame and sometimes the current one, which is the kind of bug that happens
> only occasionally and is miserable to find.

> 💡 The parameter is called `_delta` rather than `delta` because this
> function never uses it. Godot requires the parameter to be there, and the
> leading underscore is how GDScript says "I know, and I meant it", which
> keeps the editor from warning about an unused value.

> 💡 `>` is the right comparison, not `==`. The Player passes the limit at
> whatever speed it happens to be falling, covering about 20 pixels in a
> single frame at the speeds involved here, so it would almost never land on
> the exact value. The question is not "is the Player at the limit" but "is
> the Player past it".

> ⚠️ **If something differs**
>
> - If nothing happens when the Player falls, confirm `get_fall_limit()` is
>   spelled the same in both files and that `level.gd` was saved.
> - If the Player is teleported to the spawn point constantly and can never
>   move, the comparison is the wrong way round, or the `FallLimit` marker is
>   above the ground rather than below it.
> - If Godot reports that `respawn_at` is not found, `player.gd` was not saved
>   after Part 4.

### Part 6: Test the whole boundary

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
10. Confirm the one-way strip, the solid platform, and the moving platform
    all behave as they did in Lesson 4.6.
11. If a compatible controller is connected, repeat the checks with it.
12. Stop the scene with `F8`.

> 💡 Step 9 is the check that the limit is in the right place. A fall limit
> set too high catches the Player during ordinary play, which feels like the
> game snatching you off a jump you had made. Everything in this level that
> is meant to be survivable ends on the ground at `y = 960`, far above the
> limit at `1216`.

> 💡 Falling is now a setback rather than an ending, and that is a design
> choice rather than a technical one. The Player loses its position and
> nothing else. Later modules add things worth losing, and this is the line
> of code they will hook into.

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
4. Open `level_2.tscn`, give it its own `FallLimit` marker and a pit of its
   own, and swap it into `main.tscn`. Confirm falling works there with no
   change to `main.gd` or `player.gd`.
5. Restore `level_1.tscn` in `main.tscn` at Position `(0, 0)`.
6. Explain why the fall check lives in `main.gd` rather than in `player.gd`,
   and what would have to be true for the Player to check for itself.
7. Explain why `get_fall_limit()` returns a number while
   `get_spawn_position()` returns a position.

## Verification checklist

- [ ] `level_1.tscn`'s `Terrain` layer has 64 painted cells, six fewer than
      the 70 it had at the end of Lesson 6.
- [ ] The pit is three tiles wide, spanning `x = 448` to `x = 640`, and goes
      through both ground rows.
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
- [ ] Repeated falls are handled the same way every time.
- [ ] A full-speed run and jump clears the pit from well before the lip.
- [ ] Stepping off the moving platform lands on the ground and does not
      trigger a respawn.
- [ ] Running, jumping, coyote time, jump buffering, and variable jump height
      are unchanged.
- [ ] The one-way strip and the moving platform behave as they did in Lesson
      4.6.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors,
      or unexplained warnings.
- [ ] The learner saw what a badly placed fall limit does, and can say why.
- [ ] The learner gave a second level its own pit and fall limit without
      editing `main.gd` or `player.gd`.
- [ ] The learner can explain why the check lives in `Main`.

## References

- [StaticBody2D](https://docs.godotengine.org/en/4.7/classes/class_staticbody2d.html)
- [Marker2D](https://docs.godotengine.org/en/4.7/classes/class_marker2d.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
