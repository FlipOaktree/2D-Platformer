# Module 4, Lesson 4: Add Player Spawn Points

**Status:** Validated

## By the end

Let each level say where the Player starts, instead of the Player sitting at a
position somebody typed into `main.tscn`. This is the first time two nodes
talk to each other in this course, and the first script that is not the
Player's.

- `level_1.tscn` contains a `PlayerSpawn` marker showing where the Player
  begins.
- `level.gd` lets the level answer one question: where is your spawn point?
- `main.gd` asks that question when the game starts and puts the Player there.
- Moving the marker moves where the Player starts, with no other change.
- A different level brings its own spawn point, and `main.tscn` needs no edit
  to use it.

## Before you start

- Module 4, Lesson 3 is complete and validated.
- `main.tscn` contains the Player and one `Level` instance of
  `res://levels/level_1.tscn`.
- `level_1.tscn` has a `Level` root with the `Terrain` layer inside it.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Add a spawn marker to the level

1. Open `res://levels/level_1.tscn`.
2. Select the `Level` root and add a child node of type **Marker2D**.
3. Rename it `PlayerSpawn` with `F2`.
4. Set its Position to `(256, 896)`.
5. Confirm that a small cross appears in the 2D editor, sitting just above the
   ground near the left of the level.
6. Save `level_1.tscn` with `Ctrl+S`.

> 💡 A `Marker2D` is a position and nothing else. It draws a cross in the
> editor so you can see and move it, and draws nothing at all when the game
> runs. It exists to answer "where?", which is exactly what a spawn point is.

> 💡 `(256, 896)` is where the Player's centre goes, not where its feet go.
> The Player's collider is 128 tall, so a centre at `896` puts its feet on the
> ground surface at `y = 960`. Marking the centre keeps the level from having
> to know how tall the Player is.

> 💡 The spawn point belongs to the level, not to `Main`. The level is the
> only thing that knows where its own ground is. `Main` has no idea which
> level it is holding or what shape it has, and it should not need to.

> ⚠️ **If something differs**
>
> - If you cannot see the cross, confirm the node is a `Marker2D` and not a
>   plain `Node2D`, which draws nothing.
> - If the marker sits inside the ground, confirm its Position is `(256, 896)`
>   and that you set it on `PlayerSpawn` rather than on `Level`.

### Part 2: Let the level report its spawn point

1. With `level_1.tscn` open, select the `Level` root and attach a new script
   saved as `res://levels/level.gd`.
2. Replace the generated contents with:

   ```gdscript
   extends Node2D

   @onready var player_spawn: Marker2D = $PlayerSpawn


   ## Where the Player should be placed when this level starts.
   func get_spawn_position() -> Vector2:
       return player_spawn.global_position
   ```

3. Save the script with `Ctrl+S`, then save the scene.

> 💡 `$PlayerSpawn` finds a child node by its name. It is shorthand, and the
> name has to match the node in the Scene dock exactly.

> 💡 `@onready` delays a variable until the node is ready, which is the first
> moment its children exist. Without it the script would look for
> `PlayerSpawn` while the scene is still being built and find nothing.

> 💡 `global_position` is where the marker actually is in the world.
> `position` would be where it sits relative to `Level`. They are the same
> number today only because `Level` sits at the origin, so either would appear
> to work. Move the level 128 pixels up, as the exercise does, and `position`
> still reports the old number: the Player arrives 128 pixels below the
> marker, misses the ground, and falls. `global_position` is the one that
> stays correct wherever the level is placed.

> 💡 The level offers a method rather than letting anyone reach in and grab
> the marker. `get_spawn_position()` is a promise about what the level can
> answer, not about how it is built inside. The level can rename or move
> `PlayerSpawn` later and nothing outside it breaks.

> ⚠️ **If something differs**
>
> - If the editor reports that `player_spawn` is null, check the spelling of
>   `$PlayerSpawn` against the node's name.
> - If it complains that `Marker2D` is not the expected type, confirm you
>   added a `Marker2D` in Part 1 rather than another node type.

### Part 3: Place the Player from Main

1. Open `res://scenes/main.tscn`.
2. Select the `Main` root and attach a new script saved as
   `res://scenes/main.gd`.
3. Replace the generated contents with:

   ```gdscript
   extends Node2D

   @onready var level: Node2D = $Level
   @onready var player: CharacterBody2D = $Player


   func _ready() -> void:
       player.global_position = level.get_spawn_position()
   ```

4. Save the script and the scene with `Ctrl+S`.

> 💡 This is the orchestrator's job. `Main` owns the Player and the level,
> and its work is to introduce them. It asks the level one question and acts
> on the answer. It does not know the level's shape, its tiles, or where its
> marker sits.

> 💡 `_ready()` runs once when the scene is set up. That is the right moment
> to place the Player: after both the Player and the level exist, and before
> the first physics frame moves anything.

> ⚠️ **If something differs**
>
> - If Godot reports that `get_spawn_position` is not found, confirm that
>   `level.gd` is attached to the `Level` root inside `level_1.tscn`, not to
>   the instance in `main.tscn`.
> - If the Player still appears where it used to, confirm `main.gd` is
>   attached to `Main` and that `_ready()` is spelled with both underscores.

### Part 4: Test that the level decides

1. Run `main.tscn` with `F6`.
2. Confirm that the Player appears at the marker and settles on the ground
   there, rather than falling from the old position.
3. Stop with `F8`.
4. Open `level_1.tscn`, move `PlayerSpawn` to a different spot above the
   ground, and save.
5. Run `main.tscn` again and confirm the Player now starts at the new spot,
   with no change made to `main.tscn`.
6. Return `PlayerSpawn` to `(256, 896)` and save.
7. Select the `Player` in `main.tscn`, change its Position to anything, and
   run again. Confirm the Player still starts at the marker.
8. Confirm that running, jumping, coyote time, jump buffering, and variable
   jump height all behave as they did in Lesson 3.
9. If a compatible controller is connected, repeat the movement checks.
10. Stop with `F8`.

> 💡 Step 7 is the real test. The Player's own position in `main.tscn` no
> longer decides anything, which is the point: the level decides, and the
> Player is simply put there.

> ⚠️ **If something differs**
>
> - If the Player spawns at the top-left corner, `get_spawn_position()` is
>   probably returning `(0, 0)` because `player_spawn` never found the marker.
> - If the Player falls through the ground, the marker is below the ground
>   surface rather than above it.
> - If the Player arrives correctly but the whole level looks shifted, the
>   `Level` instance in `main.tscn` is not at Position `(0, 0)`. The spawn
>   still works, because it is read relative to the level, which is exactly
>   what `global_position` buys you.

## Learner exercise

1. Open `level_2.tscn` and give it its own `PlayerSpawn` marker, positioned
   above its ground.
2. Attach `level.gd` to the `Level` root of `level_2.tscn` as well.
3. In `main.tscn`, replace the `Level` instance with `level_2.tscn`. Check
   that it sits at Position `(0, 0)` before running, because dropping a scene
   into the 2D viewport places it wherever the mouse was. Then run and
   confirm the Player spawns correctly with no edit to `main.gd`.
4. Now move the `Level` instance to Position `(0, -128)` on purpose and run
   again. Confirm the Player still arrives at the level's marker rather than
   128 pixels away from it, and explain which line of `level.gd` makes that
   true.
5. Restore the `Level` instance to `(0, 0)` and put `level_1.tscn` back, again
   at `(0, 0)`.
6. Explain why `Main` asks the level for a position instead of reading the
   marker itself.

## Verification checklist

- [ ] `level_1.tscn` contains a `Marker2D` named `PlayerSpawn` at Position
      `(256, 896)`.
- [ ] `res://levels/level.gd` is attached to the `Level` root of
      `level_1.tscn`.
- [ ] `level.gd` declares `player_spawn` with `@onready` and typed as
      `Marker2D`.
- [ ] `get_spawn_position()` returns `Vector2` and uses `global_position`.
- [ ] `res://scenes/main.gd` is attached to the `Main` root.
- [ ] `main.gd` places the Player in `_ready()` using the value returned by
      `level.get_spawn_position()`.
- [ ] `main.gd` contains no reference to `PlayerSpawn` or to any node inside
      the level.
- [ ] `main.gd` and `level.gd` each appear once and are attached to one node
      each.
- [ ] The Player starts at the marker, and moving the marker moves the start.
- [ ] Changing the Player's Position in `main.tscn` makes no difference to
      where it starts.
- [ ] Running, jumping, coyote time, jump buffering, and variable jump height
      are unchanged.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner gave `level_2.tscn` its own spawn point and used it without
      editing `main.gd`.
- [ ] The learner can explain why the level owns the spawn point.
- [ ] The learner can explain the difference between `position` and
      `global_position` here.

## References

- [Marker2D](https://docs.godotengine.org/en/4.7/classes/class_marker2d.html)
- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
- [Scene organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html)
- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
