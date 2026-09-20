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
4. Repeat for `(2, 3)` and `(3, 3)`.
5. Confirm that three new tiles appear under **Alternative Tiles**, to the
   right of the base tiles.
6. Select the first alternative on its own. Alternatives are set up one at a
   time; they cannot be selected together the way base tiles can.
7. Give it a collision polygon covering the whole tile, the same way as in
   Lesson 1.
8. Turn on that polygon's **One Way** setting.
9. In the tile properties, find **Modulate** under **Rendering** and set a
   pale blue. Click the colour swatch, then type `BFE6FF` into the hex field
   of the colour picker.
10. Repeat steps 6 to 9 for the other two alternatives, so all three end up
    with the same collision, the same **One Way** setting, and the same tint.
11. Confirm the three base tiles at `(1, 3)`, `(2, 3)` and `(3, 3)` are
    unchanged: still solid, still untinted.
12. Save the tile set with `Ctrl+S`.

> 💡 An alternative tile is a second version of the same artwork with its own
> properties. The picture comes from the same square of `terrain.png`, but the
> collision, the tint and everything else belong to the variant alone. That is
> what makes one-way platforms possible without a second tile set: one-way is
> a property of a tile's collision polygon, so a tile is either one-way
> everywhere it is painted or nowhere.

> 💡 Row 3 is the right row to copy, and the reason is the underside. The
> tiles at `(1, 3)`, `(2, 3)` and `(3, 3)` draw a bar that is finished on all
> four sides, which is what a platform hanging in the air needs. The tiles
> directly above them in row 0 look identical from the front but are the top
> of a taller block, so their bottom edge is drawn as dirt continuing
> downward. Copy those and the strip gets a ragged underside that does not
> match the solid platform beside it. The solid platform already uses row 3;
> the `Ground` terrain chose it for exactly this reason in Lesson 2.

> 💡 An alternative starts empty. Godot's documentation is explicit that none
> of the base tile's properties are inherited, which is why step 7 draws the
> collision polygon again rather than editing one already there. It is also
> why the base tiles keep their own solid collision untouched.

> 💡 The tint is not decoration. Without it the pass-through platform is
> drawn with exactly the same pixels as solid ground, and nothing on screen
> tells a player which is which. Real tile art would use a different picture;
> a colour shift is the honest placeholder until there is one.

> 💡 `BFE6FF` is a hex colour, the same notation web pages use: two digits
> each for red, green and blue. Typing it into the hex field avoids having to
> think about which scale the sliders are using. **Modulate** multiplies the
> tile's existing colours rather than replacing them, so a near-white blue
> leaves the artwork readable and only cools it slightly. A darker colour
> would dim the tile instead of tinting it.

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
4. Return to the **TileSet** tab and switch to **Paint**, choosing
   **Terrains** in **Paint Properties** as in Lesson 2.
5. Set **Terrain Set** to `Terrain Set 0` and **Terrain** to `Platform`.
6. Mark the centre of all three alternatives, so each belongs to `Platform`.
7. Mark peering bits for a horizontal strip, reading the artwork as before:
   the variant of `(1, 3)` connects on its **right** only, the variant of
   `(2, 3)` connects **left and right**, and the variant of `(3, 3)` connects
   on its **left** only.
8. Leave every other bit unmarked, including all four corners.
9. Save the tile set with `Ctrl+S`.

> 💡 Two terrains can live in one terrain set. `Ground` describes the solid
> mass and `Platform` describes the strips you can pass through, and a
> peering bit names which of the two continues in that direction. Because
> they are different terrains, the `Ground` brush cannot place a
> pass-through tile and the `Platform` brush cannot place solid ground.

> 💡 Three tiles only describe a horizontal strip: an end, a middle, and the
> other end. Paint an L-shape or a block with the `Platform` brush and cells
> will come out empty, because no tile describes those neighbours. That is
> the same signal as in Lesson 2, and here it is a fair one: a strip is all
> this platform is meant to be.

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

> 💡 `Platforms` uses the same tile set as `Terrain`. The layers are separate
> so the two kinds of surface stay easy to tell apart and easy to edit, not
> because they need different tiles.

> 💡 Painting the strip is one drag, not five clicks, because `Platform` is a
> terrain like `Ground`. Godot picks the end pieces and the middles for you,
> the same way it does for the ground, and it will keep doing so if you
> lengthen or shorten the strip later.

> 💡 The two terrains do not mix, even on one layer. A `Ground` brush cannot
> reach the pass-through variants and a `Platform` brush cannot reach the
> solid tiles, because a peering bit names which terrain continues, not just
> that something does.

> 💡 The strip sits at the same height as the solid platform on the right,
> and that is deliberate. Two surfaces at the same height that behave
> differently make the difference easy to feel: run at one and you stop, jump
> under the other and you pass.

> ⚠️ **If something differs**
>
> - If the strip comes out solid from below, the `Ground` terrain was
>   selected rather than `Platform`. The strip should be tinted.
> - If the ends look like middles, the peering bits in Part 2 are marked on
>   the wrong sides.
> - If the layer paints nothing, confirm the **Tile Set** property is filled
>   in. Use the menu beside it and choose **Load** if dragging did not take.

### Part 4: Test both kinds of surface

1. Run `main.tscn` with `F6`.
2. Walk to a spot under the one-way strip and jump straight up. Confirm the
   Player rises through it and lands on top coming down. Watch what happens
   to the Player while it is passing through: it disappears behind the
   platform instead of in front of it.
3. Stop the scene with `F8` and look at the order of `Main`'s children in the
   Scene dock: `Player` first, then `Level`.
4. Drag `Level` above `Player`, so `Main` lists `Level` first and `Player`
   second, and save `main.tscn` with `Ctrl+S`.
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

> 💡 The collision outlines from the **Debug** menu are not needed here. The
> tint already shows which surface is which, and the test is what the Player
> does rather than what the shapes look like. Turn **Visible Collision
> Shapes** back on if a platform behaves oddly and you want to see whether a
> polygon is missing or the wrong size.

> 💡 Nodes are drawn in the order they are listed, so a later sibling is
> drawn on top of an earlier one. `Player` was listed before `Level`, which
> is why the level was painted over the Player. The bug has been there since
> Lesson 3, and this is simply the first time anything made it visible: until
> now the Player never shared space with the level, and standing on ground
> draws nothing over you. A surface you pass through is the first thing that
> overlaps.

> 💡 Order is worth suspecting whenever something appears behind something
> it should be in front of. It is one of the quickest things to test,
> because dragging a node in the Scene dock shows the answer immediately.

> 💡 Steps 2 and 7 are the same jump in two places. Under the one-way strip
> it rises the full 310 pixels; under the solid platform it stops after
> about 64, because the Player's head is already close to the underside. One
> number is the jump the Player asked for, the other is the ceiling answering.

> ⚠️ **If something differs**
>
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
