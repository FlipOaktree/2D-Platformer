# Module 4, Lesson 3: Build a Reusable Level Scene

**Status:** Validated

## By the end

Move the painted level out of `main.tscn` and into a scene of its own, so a
level becomes a thing you can make more of. Nothing about the game changes;
what changes is where the level lives and who owns it.

- `res://levels/level_1.tscn` holds the level: a `Level` root with the
  `Terrain` layer inside it.
- `main.tscn` holds the Player and one instance of `level_1.tscn`, and nothing
  else.
- A second level can be made by duplicating the file, without editing
  `main.tscn` at all.
- The game plays exactly as it did at the end of Lesson 2.

## Before you start

- Module 4, Lesson 2 is complete and validated.
- `main.tscn` contains the Player and a `Terrain` layer holding the painted
  ground and platform.
- `Floor` and `CoyoteTestPlatform` are gone.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Group the level under one node

1. Open `res://scenes/main.tscn`.
2. Select the `Main` root and add a child node of type **Node2D**.
3. Rename it `Level` with `F2`.
4. Confirm that `Level` has Position `(0, 0)`.
5. In the Scene dock, drag `Terrain` onto `Level` so that it becomes a child
   of `Level` rather than of `Main`.
6. Confirm that `Terrain` still has Position `(0, 0)` and that the level looks
   exactly as it did before the move.
7. Save `main.tscn` with `Ctrl+S`.

> 💡 A plain `Node2D` is enough. The level needs no behaviour of its own yet,
> only somewhere for its parts to gather. `Node2D` gives it a position, which
> means the whole level can later be moved as one piece instead of node by
> node.

> 💡 The Player is deliberately left out. A level is the content of one
> place: its ground, its platforms, and later its hazards and its spawn
> point. The Player is not content. It carries on from one level to the next,
> so it belongs to `Main`. Putting a copy of the Player inside every level
> would mean eight Players in eight levels, each needing the same fix
> whenever the Player changes.

> 💡 Moving a node in the Scene dock keeps it where it is on screen. Godot
> adjusts the node's local position so its place in the world does not change,
> which is why nothing moves when `Terrain` becomes a child of a node sitting
> at the origin.

> ⚠️ **If something differs**
>
> - If the level jumps when you drag `Terrain`, confirm that `Level` is at
>   Position `(0, 0)` before dragging.
> - If `Terrain` lands beside `Level` instead of inside it, drop it directly
>   onto the `Level` row rather than between rows.

### Part 2: Save the branch as its own scene

1. Right-click `Level` in the Scene dock and choose **Save Branch as Scene**.
2. Save it as `res://levels/level_1.tscn`.
3. Confirm that `Level` now shows the icon Godot uses for an instanced scene,
   and that `Terrain` is no longer listed beneath it in `main.tscn`.
4. Confirm that `level_1.tscn` appears in **FileSystem** under `res://levels/`.
5. Open `level_1.tscn` and confirm that its root is a `Node2D` named `Level`
   with `Terrain` as its only child.
6. Save both scenes with `Ctrl+S`.

> 💡 **Save Branch as Scene** does two things in one step: it writes the
> branch out to a new scene file, and it replaces the branch in this scene
> with an instance of that file. This is the composition from Lesson 1.5
> approached from the other end. There you built a small scene and placed it
> inside a bigger one; here you carve a scene out of one you already have.

> 💡 `Terrain` disappearing from `main.tscn` is the point, not a problem.
> `main.tscn` no longer owns those nodes; `level_1.tscn` does. To change the
> level you open the level. That separation is what lets a second level exist
> without `main.tscn` knowing anything about it.

> 💡 One file per level is what makes a game with more than one level
> possible. Each level is edited on its own, so work on one cannot disturb
> another. Each is loaded only when it is played, so a game with forty levels
> does not carry forty levels in memory. And because a level is a file, the
> game can be told to load a different one while it runs, which is how moving
> between levels will work in Module 13.

> 💡 `Main` holds one level at a time, not all of them. It is not a shelf
> with every level on it; it is the frame around whichever level is
> currently being played, plus the Player who plays it. Swapping the instance
> by hand, as the exercise does, is the manual version of what Module 13 later
> does in code.

> 💡 The node is called `Level` while the file is called `level_1.tscn`, and
> the difference matters. The file name says which level this is; the node
> name says what it is. Every level scene uses the same root name, so
> `Main` always contains a node called `Level` no matter which file is loaded
> into it. Later lessons rely on that: code that looks for the current level
> should not have to know its number.

> ⚠️ **If something differs**
>
> - If `Terrain` is still listed and editable under `Level`, the branch was
>   not converted. Undo with `Ctrl+Z` and repeat the step, right-clicking
>   `Level` rather than `Terrain`.
> - If the saved scene's root is `Terrain` rather than `Level`, the wrong node
>   was right-clicked. Undo and start from `Level`.
> - If `levels/level_1.tscn` is missing, check where the save dialog was
>   pointing. It opens in the last folder used, which may not be `levels`.

### Part 3: Test the result

1. Confirm that **Visible Collision Shapes** is still enabled in the **Debug**
   menu.
2. Open `res://scenes/main.tscn` and run it with `F6`.
3. Confirm that the Player falls and lands on the ground exactly as before.
4. Run left and right, and confirm that acceleration, deceleration, reversal,
   and maximum speed are unchanged.
5. Jump onto the platform, and run underneath it.
6. Walk off the platform edge and jump immediately, then repeat while waiting
   longer, and confirm coyote time behaves as it did in Lesson 2.
7. Press jump just before landing and confirm the buffered jump still fires.
8. If a compatible controller is connected, repeat the movement and jump
   checks with its configured inputs.
9. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the level has vanished, confirm that `Main` still holds the `Level`
>   instance and that it sits at Position `(0, 0)`.
> - If the level is drawn but nothing is solid, open `level_1.tscn` and confirm
>   `Terrain` still uses `terrain_tileset.tres`.
> - If anything about the movement feels different, the cause is the move
>   rather than the script; `player.gd` was not edited in this lesson.

## Learner exercise

1. In **FileSystem**, right-click `level_1.tscn`, duplicate it, and name the
   copy `level_2.tscn`.
2. Open `level_2.tscn` and paint a different arrangement of ground and
   platforms with the `Ground` terrain.
3. In `main.tscn`, delete the `Level` instance and drag `level_2.tscn` into
   `Main` in its place.
4. Confirm that the new instance is also called `Level`, because both files
   share a root name.
5. Run `main.tscn` and confirm that the other level loads, with no other
   change anywhere in the project.
6. Restore the original by deleting the second instance and dragging
   `level_1.tscn` back in.
7. Explain why the Player is not part of the level scene, and what would have
   to change in step 3 if it were.
8. Describe what you had to do by hand in step 3, and what a game would have
   to do instead to change level while it is running.

## Verification checklist

- [ ] `res://levels/level_1.tscn` exists, with a `Node2D` root named `Level`
      at Position `(0, 0)`.
- [ ] `Terrain` is a child of `Level`, sits at Position `(0, 0)`, and still
      uses `res://levels/tiles/terrain_tileset.tres`.
- [ ] `Terrain` still holds the 70 cells painted in Lesson 2, unchanged.
- [ ] `main.tscn` contains exactly two children: the Player and one instance
      of `level_1.tscn`.
- [ ] `main.tscn` contains no `TileMapLayer` of its own.
- [ ] The Player is in `main.tscn`, not inside the level scene.
- [ ] The Player comes to rest with the bottom of its collider at `y = 960`.
- [ ] The platform can be jumped onto and run underneath, as in Lesson 2.
- [ ] Acceleration, deceleration, reversal, gravity, landing, maximum speed,
      coyote time, jump buffering, and variable jump height are unchanged.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner made a second level by duplicating the file and swapped it in
      without editing anything else.
- [ ] Both level scenes use `Level` as their root node name.
- [ ] The learner can explain what belongs in a level scene and what belongs in
      `Main`.
- [ ] The learner can explain why `Main` holds one level at a time rather than
      all of them.

## References

- [Creating scene instances](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/instancing.html)
- [Scene organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html)
- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
