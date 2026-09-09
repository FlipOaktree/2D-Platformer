# Module 4, Lesson 2: Paint a Level with Terrain Autotiling

**Status:** Blueprint drafted

## By the end

Teach the 16 tiles how they fit together, then draw the level by painting a
shape instead of choosing tiles one at a time. The two grey test rectangles
that have stood in for a level since Module 2 finally come out.

- A `Ground` terrain records which sides of each tile continue into more
  ground.
- Painting with that terrain makes Godot choose the tile that fits its
  neighbours, including at every corner and edge.
- `main.tscn` holds a full-width tiled ground and a raised terrace, and no
  longer contains `Floor` or `CoyoteTestPlatform`.
- Every movement feature from Module 3 still works on the new level.

## Before you start

- Module 4, Lesson 1 is complete and validated.
- `res://levels/tiles/terrain_tileset.tres` holds 16 solid tiles of 64 by 64
  pixels, each with a collision polygon covering the whole tile.
- `main.tscn` contains the Player, an empty `Terrain` layer, the temporary
  `Floor`, and the raised `CoyoteTestPlatform`.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Create a Ground terrain

1. Open `res://scenes/main.tscn` and select the `Terrain` node.
2. Select the TileSet resource in the Inspector.
3. Expand **Terrain Sets** and add one element.
4. Set the new terrain set's **Mode** to **Match Sides**.
5. Expand its terrain list, add one terrain, name it `Ground`, and give it a
   green colour so it is easy to recognise while painting.

> 💡 A terrain is a named material, here `Ground`, together with a record of
> which sides of each tile continue into more of the same material. Once every
> tile has been described, you paint with the material and Godot picks the tile
> that fits its neighbours.

> 💡 **Match Sides** compares only the four sides of a cell. That is why 16
> tiles are enough: four sides, each either connected or not, is sixteen
> combinations. The other modes also compare corners, which is more accurate
> for curved or diagonal shapes but needs 47 tiles to cover every case. For
> rectangular platformer ground, sides alone are enough.

> ⚠️ **If something differs**
>
> - If the terrain list stays empty after adding the terrain set, confirm that
>   you added a terrain inside the set. The set and the terrain are two
>   separate steps.
> - If **Mode** is not available, confirm that you selected the terrain set
>   itself rather than the **Terrain Sets** array above it.

### Part 2: Teach each tile which sides connect

1. Return to the **TileSet** tab and switch to its terrain-painting mode.
2. Assign all 16 tiles to the `Ground` terrain.
3. For each tile, mark every side that has **no** coloured band as a connecting
   side. A banded side is an open edge and stays unmarked.
4. Check your work against this table:

   | Atlas coordinates | Sides that connect |
   | --- | --- |
   | `(0, 0)` | none |
   | `(1, 0)` | top |
   | `(2, 0)` | right |
   | `(3, 0)` | top, right |
   | `(0, 1)` | bottom |
   | `(1, 1)` | top, bottom |
   | `(2, 1)` | right, bottom |
   | `(3, 1)` | top, right, bottom |
   | `(0, 2)` | left |
   | `(1, 2)` | top, left |
   | `(2, 2)` | left, right |
   | `(3, 2)` | top, right, left |
   | `(0, 3)` | bottom, left |
   | `(1, 3)` | top, bottom, left |
   | `(2, 3)` | right, bottom, left |
   | `(3, 3)` | all four |

5. Save the TileSet with `Ctrl+S`.

> 💡 The artwork was drawn so that the answer is always visible. A side with
> a band is an outside edge and connects to nothing; a plain side continues
> into more ground. Use the table to check your work rather than to copy from,
> because reading the tile is the skill that transfers to real tile art.

> ⚠️ **If something differs**
>
> - If Godot keeps choosing a tile whose band faces solid ground, that tile's
>   sides are marked the wrong way round. Mark the closed sides, not the open
>   ones.
> - If some cells stay empty while painting in Part 4, a combination is
>   missing. Compare every tile against the table.
> - If a tile shows no terrain colour at all, it was never assigned to
>   `Ground`, only given peering bits.

### Part 3: Ask Codex to check all 16 tiles

1. Return to the Codex project associated with this Godot folder.
2. Ask:

   > Read `levels/tiles/terrain_tileset.tres` without changing it. Confirm that
   > it defines exactly 16 tiles, that every tile has exactly one collision
   > polygon on the physics layer, and that every tile is assigned to the one
   > terrain in the one terrain set. Then list, for each tile, which sides are
   > marked as connecting, and report any tile whose sides disagree with this
   > rule: a side connects when the tile's artwork has no coloured band there.

3. Read the response and open the **TileSet** tab to inspect every tile it
   mentions.
4. If Codex identifies a real mismatch, correct only that tile and compare the
   result with the table in Part 2.

This review is worth asking for because Lesson 1 and Part 2 of this lesson each
ask you to repeat the same small edit sixteen times, and one skipped tile
produces a defect that appears later, in one specific corner of one level.
Reading a saved resource file is exactly the kind of patient counting that is
easy to get wrong by eye. The decision still comes from the tiles you inspect
yourself.

If Codex is unavailable, check the 16 tiles against the Part 2 table directly
before continuing.

> ⚠️ **If something differs**
>
> - If Codex offers to rewrite the resource file, decline. Tile data is edited
>   through the **TileSet** tab, where you can see the result.
> - If its description disagrees with what the panel shows, trust the panel and
>   confirm the behaviour in Part 5.

### Part 4: Paint the level and remove the temporary bodies

1. Open the **TileMap** tab and select its **Terrains** tab.
2. Choose the `Ground` terrain and the **Connect** painting mode.
3. Choose the **Rectangle** tool.
4. Drag a rectangle from cell `(0, 14)` to cell `(29, 16)`. This is the ground:
   the full width of the viewport, three rows deep, with its surface at
   `y = 896`.
5. Drag a second rectangle from cell `(11, 11)` to cell `(18, 13)`. This is the
   raised terrace, with its surface at `y = 704`.
6. Confirm that the ground and the terrace joined into one shape, with green
   along every open top edge and no seam where they meet.
7. Select `Floor` in the Scene dock and delete it.
8. Select `CoyoteTestPlatform` and delete it.
9. Save `main.tscn` with `Ctrl+S`.

> 💡 Cell `(0, 0)` is the top-left corner of the viewport frame, so cell
> `(0, 14)` is fourteen rows below the top of the frame and cell `(29, 16)` is
> the last column on the right. If you lose track while dragging, count rows
> down from that corner; the **Rectangle** tool previews the area before you
> release the button.

> 💡 The terrace surface is 192 pixels above the ground surface, replacing
> the 200-pixel step the temporary platform provided. A jump with the button
> held rises about 261 pixels, so the Player still clears the terrace with
> about 69 pixels to spare, and the terrace still gives you a ledge to walk
> off when testing coyote time.

> ⚠️ **If something differs**
>
> - If the terrace floats above the ground instead of joining it, confirm that
>   its rectangle reaches down to row 13 and that the ground starts at row 14.
> - If a band of colour appears where the terrace meets the ground, those cells
>   were painted as two separate shapes. Repaint the join with the **Connect**
>   mode selected.
> - If deleting `Floor` also removes painted cells, undo with `Ctrl+Z` and
>   confirm that you selected `Floor` in the Scene dock rather than the
>   `Terrain` layer.
> - If the ground stops short of the right edge, the last column is 29, not 30.

### Part 5: Test the level

1. Confirm that **Visible Collision Shapes** is still enabled in the **Debug**
   menu.
2. Run the current scene with `F6`.
3. Confirm that the Player falls and lands on the tiled ground, and that the
   collision outlines follow the painted shape.
4. Run left and right and confirm that acceleration, deceleration, reversal,
   and maximum speed are unchanged.
5. Run into the side of the terrace, hold the jump button, and keep moving
   toward it. Confirm that the Player rises past the terrace surface and lands
   on top.
6. From the ground, tap the jump button briefly. Confirm that the shortened
   jump does not reach the terrace.
7. Walk off the edge of the terrace and press jump immediately afterward.
   Confirm that the Player still jumps during the grace period.
8. Walk off the edge again, wait noticeably longer, and confirm that the Player
   does not jump.
9. While falling toward the ground, press jump just before landing and confirm
   that the buffered jump fires on contact.
10. Walk to the far left and far right edges and confirm that the ground
    continues to both sides of the viewport.
11. If a compatible controller is connected, repeat the movement and jump
    checks with its configured inputs.
12. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Player sinks into the ground or stands slightly above it, confirm
>   that each collision polygon covers the full tile rather than part of it.
> - If the Player cannot reach the terrace with the jump held, confirm that the
>   terrace surface is at `y = 704` and that `jump_velocity` still uses its
>   validated default of `-1100.0`.
> - If the Player catches on an invisible edge while running, one cell in the
>   ground is empty. Look for a gap in the collision outlines.
> - If a movement feature behaves differently, the cause is the level rather
>   than the script; `player.gd` was not edited in this lesson.

## Learner exercise

1. Using the **Rectangle** tool and the `Ground` terrain, add a second, smaller
   terrace to the right of the first one.
2. Before painting it, predict which tiles Godot will choose at its two top
   corners.
3. Paint it and compare the result with your prediction.
4. Erase one cell from the middle of the ground with the **Eraser**, and watch
   the four tiles around the hole change.
5. Undo both changes with `Ctrl+Z` until the level matches Part 4 again.
6. Explain what **Match Sides** compares, and why that produces exactly 16
   tiles.
7. Explain why painting with a terrain is faster than choosing each corner tile
   yourself, and when it would not be.

## Verification checklist

- [ ] The TileSet has exactly one terrain set, its **Mode** is **Match Sides**,
      and it contains exactly one terrain named `Ground`.
- [ ] All 16 tiles are assigned to the `Ground` terrain.
- [ ] Every tile's connecting sides match the table in Part 2.
- [ ] The painted ground fills cells `(0, 14)` through `(29, 16)`.
- [ ] The painted terrace fills cells `(11, 11)` through `(18, 13)` and joins
      the ground without a seam.
- [ ] No cell in the painted level was left empty by a missing tile
      combination.
- [ ] `main.tscn` contains no `Floor` node and no `CoyoteTestPlatform` node.
- [ ] `main.tscn` still contains exactly one `TileMapLayer`, named `Terrain`,
      at Position `(0, 0)`.
- [ ] The Player comes to rest with the bottom of its collider at `y = 896`.
- [ ] The terrace surface is at `y = 704`, 192 pixels above the ground surface.
- [ ] A jump with the button held carries the Player onto the terrace, and a
      tapped jump does not.
- [ ] Coyote time, jump buffering, and variable jump height still behave as
      they did at the end of Module 3.
- [ ] Acceleration, deceleration, reversal, gravity, landing, and maximum speed
      remain unchanged.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner checked all 16 tiles against the Part 2 table, with or
      without Codex.
- [ ] The learner can explain how **Match Sides** chooses a tile from its
      neighbours.

## References

- [Using TileSets](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html)
- [Using TileMaps](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilemaps.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
- [TileSet](https://docs.godotengine.org/en/4.7/classes/class_tileset.html)
