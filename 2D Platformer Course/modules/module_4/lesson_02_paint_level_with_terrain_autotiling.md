# Module 4, Lesson 2: Paint a Level with Terrain Autotiling

**Status:** Validated

## By the end

Teach the tiles how they fit together, then draw the level by painting a shape
instead of choosing tiles one at a time. The two grey test rectangles that have
stood in for a level since Module 2 finally come out.

- A `Ground` terrain records where each tile's ground continues past its edge.
- Painting with that terrain makes Godot choose the tile that fits its
  neighbours, including at every corner and edge.
- `main.tscn` holds a full-width tiled ground and a floating platform, and no
  longer contains `Floor` or `CoyoteTestPlatform`.
- Every movement feature from Module 3 still works on the new level.

## Before you start

- Module 4, Lesson 1 is complete and validated.
- `res://levels/tiles/terrain_tileset.tres` holds 47 solid tiles of 64 by 64
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
4. Set the new terrain set's **Mode** to **Match Corners and Sides**.
5. Expand its terrain list, add one terrain, name it `Ground`, and give it a
   green colour so it is easy to recognise while painting.

> 💡 A terrain is a named material, here `Ground`, together with a record of
> where each tile's material continues past its edges. Once tiles have been
> described this way, you paint with the material and Godot picks the tile that
> fits its neighbours.

> 💡 **Match Corners and Sides** compares all eight neighbours of a cell: the
> four sides and the four corners. That is what the artwork was drawn for. It
> is why the atlas needs 47 tiles rather than the 16 that comparing sides alone
> would need, and it is what lets the ground turn a corner cleanly instead of
> leaving a squared-off notch.

> ⚠️ **If something differs**
>
> - If the terrain list stays empty after adding the terrain set, confirm that
>   you added a terrain inside the set. The set and the terrain are two
>   separate steps.
> - If **Mode** is not available, confirm that you selected the terrain set
>   itself rather than the **Terrain Sets** array above it.

### Part 2: Describe the tiles you are about to use

1. Return to the **TileSet** tab and select `terrain.png` in **Tile Sources**.
2. Above the atlas, switch from **Select** to **Paint**. A **Paint
   Properties** panel appears on the left.
3. In **Paint Properties**, open the dropdown at the top and choose
   **Terrains**. A **Painting** section appears below it.
4. Set **Terrain Set** to `Terrain Set 0` first, then set **Terrain** to
   `Ground`. The set has to be chosen before the terrain, because the terrain
   list is filled from whichever set is selected.
5. Click a tile, or drag across several, to select them. This first pass only
   selects and paints nothing.
6. Go over a selected tile again to paint it. Clicking its centre marks it as
   ground and leaves a small green square there. Clicking a side or a corner
   marks that peering bit, for each side and corner where the ground continues
   past the tile's edge.
7. Read the answer off the artwork rather than memorising it:
   - A green top means nothing sits above that tile, so its top is open.
   - Plain ground running all the way to an edge means the ground carries on
     in that direction, so that side is marked.
   - Corners are marked the same way, by what the artwork shows in the corner
     itself. A corner may be marked even when a side beside it is not; that is
     how the tiles around an inside corner are drawn.

> 💡 **Paint** still starts with a pass that selects, as **Select** mode did
> in Lesson 1. What differs is the second pass: you pick one value and brush
> it onto the selection, and where you click inside a tile decides which part
> of it you are marking. Selecting is per tile, so a tile you have not gone
> over twice has not been painted, however obvious its artwork looks.

> 💡 Because selecting works by dragging, the centre mark does not have to be
> done tile by tile. Every tile in this set is ground, so drag across the whole
> atlas to select it, then drag across it again over the centres to mark them
> all at once. That leaves only the sides and corners, which genuinely do
> differ from tile to tile.

> 💡 Do not assume a tile's neighbours in the atlas are its neighbours in a
> level. The sheet is a set of shapes drawn for the artist's convenience, and
> two tiles sitting side by side in the atlas are often not meant to sit side
> by side in a level. Judge every tile on its own artwork.

> 💡 `assets/terrain_peering_reference.png` shows the finished answer for
> every tile: a large square in the centre where the tile is ground, a bar on
> each marked side, and a small square in each marked corner. Use it to check
> a tile you are unsure of, or to check your work at the end. Try reading the
> artwork first, though. That is the skill that carries over to a tileset
> nobody has published an answer for.

> 💡 You do not have to describe all 47 tiles before you can paint. Describe
> the ones a simple rectangular shape needs first: a flat top, a left and right
> end, a solid middle, and the pieces that sit under them. Part 3 paints the
> level, and anything still missing announces itself there.

> 💡 When Godot cannot find a tile matching a cell's neighbours, it leaves
> that cell empty rather than guessing. An empty cell in the middle of a shape
> you just painted is not a mistake in the painting. It is the TileSet telling
> you exactly which combination has not been described yet.

> 💡 That signal only catches marks that are missing, never marks that are
> wrong. A tile described incorrectly still matches something, so the level
> paints completely and looks finished while grass runs along its underside.
> A level with no empty cells is not yet a correct level; the check that
> matters is the one you do with your eyes in Part 3.

> ⚠️ **If something differs**
>
> - If Godot keeps choosing a tile whose green top faces solid ground, that
>   tile's marks are inverted. Mark where the ground continues, not where it
>   ends.
> - If a tile shows no terrain colour at all, its centre was never marked. A
>   tile with peering marks but no centre is not part of the terrain.
> - If the shape paints but its corners look wrong, the side marks are right
>   and the corner marks are not. Compare those tiles against the notches in
>   the artwork.

### Part 3: Paint the level and remove the temporary bodies

1. Open the **TileMap** tab and select its **Terrains** tab.
2. Choose the `Ground` terrain and the **Connect** painting mode.
3. Choose the **Rectangle** tool.
4. Drag a rectangle from cell `(0, 15)` to cell `(29, 16)`. This is the
   ground: the full width of the viewport, two rows deep, with its surface at
   `y = 960`.
5. Drag a second rectangle from cell `(10, 11)` to cell `(19, 11)`. This is
   the platform, one row tall, with its surface at `y = 704`. It floats clear
   of the ground rather than resting on it.
6. Look for any cell that stayed empty. Each one names a combination that Part
   2 has not described yet. Describe those tiles, then paint the gap again.
7. Now look at the result properly. Every top surface should be green, every
   buried cell should be plain ground, and no green should appear inside the
   shape or along its underside.
8. Select `Floor` in the Scene dock and delete it.
9. Select `CoyoteTestPlatform` and delete it.
10. Save `main.tscn` with `Ctrl+S`.

> 💡 Cell `(0, 0)` is the top-left corner of the viewport frame, so cell
> `(0, 15)` is fifteen rows below the top of the frame and cell `(29, 16)` is
> the last column on the right. If you lose track while dragging, count rows
> down from that corner; the **Rectangle** tool previews the area before you
> release the button.

> 💡 The painted level sits exactly where the temporary bodies did. The Floor
> surface was already at `y = 960` and the platform already occupied
> `y = 704` to `768`, so the tiles land on the same surfaces and nothing about
> the jump changes. That is why those two bodies were placed on 64-pixel
> boundaries back in Modules 2 and 3.

> 💡 The platform surface is 256 pixels above the ground and the jump rises
> about 310 pixels, so it can be reached with 54 pixels to spare. Its
> underside sits at `y = 768` and the Player's head reaches `y = 832` when
> grounded, leaving 64 pixels of clearance, so the Player can also run
> underneath it.

> 💡 Reaching it needs the jump started early. The Player is only high enough
> to land on the platform for about 26 frames, a little under half a second,
> which is roughly 195 pixels of running. Start the jump underneath the
> platform and you hit its underside instead.

> ⚠️ **If something differs**
>
> - If cells stay empty after describing the missing tiles, confirm you marked
>   their centres as well as their peering bits.
> - If the platform is drawn as though it rests on the ground, it was painted
>   in the wrong row. It should float, with two empty rows beneath it.
> - If deleting `Floor` also removes painted cells, undo with `Ctrl+Z` and
>   confirm that you selected `Floor` in the Scene dock rather than the
>   `Terrain` layer.
> - If the ground stops short of the right edge, the last column is 29, not
>   30. The viewport is 1920 pixels wide, which is 30 tiles of 64.

### Part 4: Ask Codex to check the tile data

1. Return to the Codex project associated with this Godot folder.
2. Ask:

   > Read `levels/tiles/terrain_tileset.tres` and change nothing. Answer three
   > questions, giving atlas coordinates:
   >
   > 1. How many tiles does the file define?
   > 2. Which tiles have no collision shape?
   > 3. Which tiles are not part of the `Ground` terrain?

3. Read the response and open the **TileSet** tab to inspect every tile it
   mentions.
4. If Codex reports a real problem, correct only that tile.

The answers you want are 47, none, and none. Each question catches a mistake
that is invisible in the atlas, because a tile with something missing looks
exactly like a tile without.

The count matters most. A stray click in **Paint** mode can recreate the empty
tile at `(10, 1)` that Lesson 1 deleted, and the new one carries no artwork,
no collision, and no terrain. It is easy to make and almost impossible to
notice. If the count comes back as 48, delete `(10, 1)` again.

If Codex is unavailable, count the tiles yourself and check that every one
shows both a collision outline and a green terrain centre.

> ⚠️ **If something differs**
>
> - If Codex offers to rewrite the resource file, decline. Tile data is edited
>   through the **TileSet** tab, where you can see the result.
> - If its description disagrees with what the panel shows, trust the panel and
>   confirm the behaviour in Part 5.

### Part 5: Test the level

1. Confirm that **Visible Collision Shapes** is still enabled in the **Debug**
   menu.
2. Run the current scene with `F6`.
3. Confirm that the Player falls and lands on the tiled ground, and that the
   collision outlines follow the painted shape.
4. Run left and right and confirm that acceleration, deceleration, reversal,
   and maximum speed are unchanged.
5. Run toward the platform, starting the jump before you are underneath it,
   and keep moving forward. Confirm that the Player rises past the platform
   surface and lands on top.
6. From the ground, tap the jump button briefly. Confirm that the shortened
   jump does not reach the platform.
7. Walk off the edge of the platform and press jump immediately afterward.
   Confirm that the Player still jumps during the grace period.
8. Walk off the edge again, wait a moment, and confirm that the Player does
   not jump. Press before it lands: the drop is only one tile and takes about
   a third of a second, so waiting too long lets the Player touch the ground,
   and the jump you get then is an ordinary grounded jump that looks exactly
   like coyote time working.
9. While falling toward the ground, press jump just before landing and confirm
   that the buffered jump fires on contact.
10. Walk to the far left and far right edges and confirm that the ground
    continues to both sides of the viewport.
11. If a compatible controller is connected, repeat the movement and jump
    checks with its configured inputs.
12. Stop the scene with `F8`.
13. In the editor's **Debug** menu, turn **Visible Collision Shapes** back
    off.

> 💡 The outlines have done their job. They were switched on in Module 2 to
> show a single collider and were worth keeping while collision was the thing
> being built; now that a whole level is painted they draw a box around every
> tile, which hides the artwork you are about to judge levels by. Turning them
> off is one menu click, and so is turning them on again the next time
> something solid misbehaves.

> ⚠️ **If something differs**
>
> - If the Player sinks into the ground or stands slightly above it, confirm
>   that each collision polygon covers the full tile rather than part of it.
> - If the Player cannot reach the platform with the jump held, confirm that
>   the platform surface is at `y = 704` and that `jump_velocity` still uses
>   its validated default of `-1200.0`.
> - If the Player catches on an invisible edge while running, one cell in the
>   ground is empty. Look for a gap in the collision outlines.
> - If a movement feature behaves differently, the cause is the level rather
>   than the script; `player.gd` was not edited in this lesson.

## Learner exercise

1. Using the **Rectangle** tool and the `Ground` terrain, add a second, smaller
   platform to the right of the first one.
2. Before painting it, predict which tiles Godot will choose at its two top
   corners.
3. Paint it and compare the result with your prediction.
4. Erase one cell from the middle of the ground with the **Eraser**, and watch
   the tiles around the hole change to show its edges.
5. Undo both changes with `Ctrl+Z` until the level matches Part 3 again.
6. Explain what **Match Corners and Sides** compares, and why comparing corners
   as well as sides needs more tiles than comparing sides alone.
7. Explain why an empty cell after painting is more useful than Godot guessing
   a tile that nearly fits.

## Verification checklist

- [ ] The TileSet has exactly one terrain set, its **Mode** is **Match Corners
      and Sides**, and it contains exactly one terrain named `Ground`.
- [ ] The TileSet still defines exactly 47 tiles, and `(10, 1)` was not
      recreated while painting.
- [ ] Every tile is assigned to the `Ground` terrain and still has its
      collision shape from Lesson 1.
- [ ] Every tile's peering bits match its artwork, and match
      `assets/terrain_peering_reference.png`.
- [ ] The painted ground fills cells `(0, 15)` through `(29, 16)`.
- [ ] The painted platform fills cells `(10, 11)` through `(19, 11)` and
      floats clear of the ground.
- [ ] No cell inside the painted level was left empty by a missing tile
      combination.
- [ ] Every top surface of the finished level is green, every buried cell is
      plain ground, and no green appears inside the shape or along its
      underside.
- [ ] `main.tscn` contains no `Floor` node and no `CoyoteTestPlatform` node.
- [ ] `main.tscn` still contains exactly one `TileMapLayer`, named `Terrain`,
      at Position `(0, 0)`.
- [ ] The Player comes to rest with the bottom of its collider at `y = 960`.
- [ ] The platform surface is at `y = 704`, 256 pixels above the ground, with
      64 pixels of clearance beneath it.
- [ ] A jump with the button held carries the Player onto the platform, and a
      tapped jump does not.
- [ ] Coyote time, jump buffering, and variable jump height still behave as
      they did at the end of Module 3.
- [ ] Acceleration, deceleration, reversal, gravity, landing, and maximum speed
      remain unchanged.
- [ ] **Visible Collision Shapes** is off in the **Debug** menu at the end of
      the lesson.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Keyboard behavior works, and configured controller behavior works when
      compatible hardware is available.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner used an empty cell to find an undescribed tile at least once.
- [ ] The learner can explain how **Match Corners and Sides** chooses a tile
      from its neighbours.
- [ ] The learner can explain why a level with no empty cells can still be
      wrong.

## References

- [Using TileSets](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html)
- [Creating terrain sets (autotiling)](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html#creating-terrain-sets-autotiling)
- [Using TileMaps](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilemaps.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
- [TileSet](https://docs.godotengine.org/en/4.7/classes/class_tileset.html)
