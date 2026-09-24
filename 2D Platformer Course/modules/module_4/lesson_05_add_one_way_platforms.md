# Module 4, Lesson 5: Add One-Way Platforms

**Status:** Validated

## By the end

Add a platform the Player can jump up through from below and then stand on.
The level already has a solid platform that stops a jump dead; this adds one
that lets the jump pass and catches the Player on the way down.

- Three tiles gain a pass-through variant, made as alternative tiles in the
  tile set you already have.
- The variants are tinted, so a platform you can pass through does not look
  identical to ground you cannot.
- `level_1.tscn` gains a `Platforms` layer holding a one-way strip.
- Jumping from the ground beneath the strip carries the Player through it and
  lands them on top.
- The ground and the solid platform behave exactly as they did.
- The Player is drawn in front of the level rather than behind it.

## Before you start

- Module 4, Lesson 4 is complete and validated.
- `level_1.tscn` contains a `Level` root, a `Terrain` layer, and a
  `PlayerSpawn` marker.
- `res://levels/tiles/terrain_tileset.tres` holds 47 solid tiles.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Make three pass-through variants

1. Open `res://levels/level_1.tscn` and select the `Terrain` layer so the
   **TileSet** tab shows `terrain_tileset.tres`.
2. In the **TileSet** tab, switch to **Select**.
3. Right-click the base tile at atlas coordinates `(1, 3)` and choose
   **Create an Alternative Tile**.

> 💡 An alternative tile is a second version of the same artwork with its own
> properties. It uses the same square of `terrain.png`, but its collision and
> tint belong to it alone, which is how one tile set can hold both solid and
> pass-through versions of the same picture.

> 💡 Copy row 3, not row 0. Row 3 is a bar finished on all four sides, which a
> floating platform needs; the row 0 tiles look the same from the front but
> are the top of a taller block, with dirt running off their bottom edge.

4. Repeat for `(2, 3)` and `(3, 3)`.
5. Confirm that three new tiles appear under **Alternative Tiles**, to the
   right of the base tiles.
6. Select the first alternative on its own. Alternatives are set up one at a
   time; they cannot be selected together the way base tiles can.
7. Give it a collision polygon covering the whole tile, the same way as in
   Lesson 1.

> 💡 An alternative starts empty. It inherits none of the base tile's
> properties, which is why its collision polygon is drawn from scratch.

8. Turn on that polygon's **One Way** setting.
9. In the tile properties, find **Modulate** under **Rendering** and set a
   pale blue. Click the colour swatch, then type `BFE6FF` into the hex field
   of the colour picker.

> 💡 The tint keeps the pass-through strip from looking identical to solid
> ground. `BFE6FF` is a hex colour, two digits each for red, green and blue.
> **Modulate** multiplies the tile's colours, so a near-white blue only cools
> the artwork slightly.

10. Repeat steps 6 to 9 for the other two alternatives, so all three end up
    with the same collision, the same **One Way** setting, and the same tint.
11. Confirm the three base tiles at `(1, 3)`, `(2, 3)` and `(3, 3)` are
    unchanged: still solid, still untinted.
12. Save the tile set with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If **Create an Alternative Tile** is missing, confirm you right-clicked a
>   base tile in the atlas rather than an empty square or the panel
>   background.
> - If the new tiles have no collision when painted, the polygon was added to
>   the base tile instead. Select the alternatives on the right and check.
> - If only one of the three works, the other two were never given their own
>   settings. Each alternative has to be done separately, and it is easy to
>   set one up and assume the rest followed.
> - If the ground turns pale blue, **Modulate** was set on the base tiles.
>   Undo with `Ctrl+Z` and select the alternatives first.

### Part 2: Give the variants a terrain of their own

1. Select the TileSet resource and expand **Terrain Sets**.
2. Open the existing terrain set, expand its list of terrains, and add a
   second one.
3. Name it `Platform` and give it a blue colour, so it is easy to tell from
   `Ground` while painting.

> 💡 One terrain set can hold several terrains. `Ground` is the solid mass and
> `Platform` is the pass-through strip, and because they are different
> terrains, neither brush can place the other's tiles.

4. Return to the **TileSet** tab and switch to **Paint**, choosing
   **Terrains** in **Paint Properties** as in Lesson 2.
5. Set **Terrain Set** to `Terrain Set 0` and **Terrain** to `Platform`.
6. Mark the centre of all three alternatives, so each belongs to `Platform`.
7. Mark peering bits for a horizontal strip, reading the artwork as before:
   the variant of `(1, 3)` connects on its **right** only, the variant of
   `(2, 3)` connects **left and right**, and the variant of `(3, 3)` connects
   on its **left** only.

> 💡 Three tiles only describe a horizontal strip: an end, a middle and the
> other end. Paint an L-shape with the `Platform` brush and some cells come
> out empty, because no tile fits those neighbours.

8. Leave every other bit unmarked, including all four corners.
9. Save the tile set with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If the `Platform` terrain does not appear in the dropdown, confirm you
>   added it inside the existing terrain set rather than adding a second set.
> - If painting `Platform` leaves every cell empty, the centres in step 6
>   were never marked, so no tile belongs to the terrain yet.

### Part 3: Paint a one-way strip on its own layer

1. Select the `Level` root and add a child node of type **TileMapLayer**.
2. Rename it `Platforms` and confirm its Position is `(0, 0)`.
3. Drag `terrain_tileset.tres` from **FileSystem** onto the layer's **Tile
   Set** property in the Inspector.
4. Keep `Platforms` selected and open the **TileMap** tab at the bottom of
   the editor, beside the **TileSet** tab.
5. Select its **Terrains** tab, choose the `Platform` terrain, and the
   **Connect** painting mode.
6. Choose the **Rectangle** tool and drag from cell `(2, 11)` to cell
   `(6, 11)`.
7. Confirm the strip spans five cells with its surface at `y = 704`, tinted,
   above the ground and to the left of the solid platform, and that the two
   ends look different from the three middle cells.
8. Save `level_1.tscn` with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If the strip comes out solid from below, the `Ground` terrain was
>   selected rather than `Platform`. The strip should be tinted.
> - If the ends look like middles, the peering bits in Part 2 are marked on
>   the wrong sides.
> - If the layer paints nothing, confirm the **Tile Set** property is filled
>   in. Use the menu beside it and choose **Load** if dragging did not take.

### Part 4: Test both kinds of surface

1. Predict what the Player will do when it jumps up into the strip from
   below, then run `main.tscn` with `F6`.
2. Walk to a spot under the one-way strip and jump straight up. Confirm the
   Player rises through it and lands on top coming down. Watch what happens
   to the Player while it is passing through: it disappears behind the
   platform instead of in front of it.
3. Stop the scene with `F8` and look at the order of `Main`'s children in the
   Scene dock: `Player` first, then `Level`.
4. Drag `Level` above `Player`, so `Main` lists `Level` first and `Player`
   second, and save `main.tscn` with `Ctrl+S`.

> 💡 Siblings are drawn in the order they are listed, so a later one is drawn
> on top. `Player` was listed before `Level`, so the level was painted over
> it; nothing showed it until now, because this is the first surface the
> Player passes through. When something appears behind what it should be in
> front of, child order is the first thing to check.

5. Run again and jump up through the strip. Confirm the Player now passes in
   front of the platform.
6. Walk off the end of the strip and confirm the Player falls back to the
   ground.
7. Walk to a spot under the solid platform on the right and jump straight up.
   Confirm the Player's head stops against its underside.
8. Confirm the ground is still solid everywhere, and that running, coyote
   time, jump buffering, and variable jump height are unchanged.
9. If a compatible controller is connected, repeat the checks with it.
10. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If a platform behaves oddly, turn **Visible Collision Shapes** back on in
>   the **Debug** menu to see whether a polygon is missing or the wrong size.
> - If the Player bounces off the underside of the strip, **One Way** is off
>   on at least one of the three variants.
> - If the Player falls straight through instead of landing, those variants
>   have no collision polygon.
> - If the Player lands but then sinks while standing, the polygon does not
>   cover the whole tile.
> - If the Player is still behind the platform after step 4, confirm the
>   drag reordered the children rather than dropping `Player` inside
>   `Level`. Both should still sit directly under `Main`.
> - If the Player vanishes completely, it was dropped into `Level` and
>   moved with it. Undo with `Ctrl+Z` and drag again, aiming between rows
>   rather than onto a row.

## Learner exercise

1. Paint a second one-way strip two rows above the first, at row 9.
2. Work out before running whether the Player can reach it from the strip
   below, given a jump that rises about 310 pixels, then check.
3. Stand under the lower strip and hold jump to pass through both.
4. Erase the second strip.
5. Turn **One Way** off on the three variants, run again, and describe what
   changes about reaching the first strip.
6. Turn **One Way** back on.
7. Explain why the pass-through tiles had to be alternatives rather than three
   more tiles painted from the atlas.

## Verification checklist

- [ ] `terrain_tileset.tres` still defines 47 base tiles.
- [ ] The tiles at `(1, 3)`, `(2, 3)` and `(3, 3)` each have one alternative.
- [ ] The one-way strip is finished on its underside and matches the solid
      platform, with no dirt texture running off its bottom edge.
- [ ] Each alternative has one collision polygon covering the whole tile, with
      **One Way** on and a pale blue **Modulate**.
- [ ] The alternatives belong to a second terrain named `Platform`, not to
      `Ground`, with peering bits describing a horizontal strip.
- [ ] The three base tiles are unchanged: solid collision, no tint.
- [ ] `level_1.tscn` contains a `Platforms` `TileMapLayer` at Position
      `(0, 0)` using `terrain_tileset.tres`.
- [ ] `Platforms` holds five painted cells from `(2, 11)` to `(6, 11)`, all of
      them alternatives, with the surface at `y = 704`.
- [ ] The `Terrain` layer's painted cells are unchanged.
- [ ] Jumping from the ground under the strip carries the Player through and
      lands them on top at `y = 704`.
- [ ] Walking off the end of the strip returns the Player to the ground at
      `y = 960`.
- [ ] Jumping under the solid platform still stops the Player against its
      underside.
- [ ] `main.tscn` lists `Level` first and `Player` second, and the Player is
      drawn in front of the one-way platform while passing through it.
- [ ] The ground is still solid, and running, coyote time, jump buffering, and
      variable jump height are unchanged.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner can explain why a pass-through tile has to be a separate
      tile from the solid one that shares its picture.

## References

- [Using TileSets](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html)
- [Creating alternative tiles](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html#creating-alternative-tiles)
- [TileData](https://docs.godotengine.org/en/4.7/classes/class_tiledata.html)
- [Using CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
