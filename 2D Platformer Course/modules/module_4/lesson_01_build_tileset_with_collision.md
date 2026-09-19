# Module 4, Lesson 1: Build a TileSet with Collision

**Status:** Validated

## By the end

Build the set of tiles that every level in this module is made from. A TileSet
is the material; drawing a level with it is the next lesson. By the end of this
one the tiles exist, they are solid, and you have watched the Player stand on
tiles you painted yourself.

- `res://levels/tiles/terrain_tileset.tres` is a reusable TileSet holding 47
  tiles of 128 by 128 pixels.
- Every tile carries a collision shape, so a painted tile is solid ground.
- `main.tscn` contains a `Terrain` layer, ready to paint on and empty.
- The temporary `Floor` and `CoyoteTestPlatform` are still in place. The next
  lesson replaces them with a painted level.

## Before you start

- Module 3, Lesson 6 is complete and validated.
- `main.tscn` contains the Player, the temporary `Floor`, and the raised
  `CoyoteTestPlatform`.
- The course asset `assets/terrain.png` is available on your computer.
- Keyboard movement and jumping work, and configured controller input works
  when compatible hardware is available.

## Build steps

### Part 1: Add the tile artwork to the project

1. In the **FileSystem** dock, right-click `res://` and choose
   **Create New > Folder...**.
2. Name the folder `levels` and confirm.
3. Right-click `levels`, create a folder inside it named `tiles`.
4. Using Windows File Explorer, copy `terrain.png` from this lesson's `assets`
   folder into the project's `levels\tiles\` folder.
5. Return to Godot. The file appears in **FileSystem** under
   `res://levels/tiles/` and is imported automatically.
6. Double-click the image to preview it and confirm that it is 1536 by 512
   pixels.

> 💡 A tile atlas is a single image that holds many tiles arranged in a grid.
> This one is 12 tiles across and 4 down, with each tile 128 by 128 pixels.

> 💡 The artwork is not drawn as 48 separate squares. It is drawn as four
> solid shapes of ground: a narrow one-tile pillar, a three-wide block, a
> four-wide block, and a four-wide block with a single hole punched in it.
> Every square of those shapes becomes one tile, and because the shapes have
> edges, corners, and a hole, the squares between them cover every way ground
> can meet empty space. The hole is why one square of the grid is left empty.

> 💡 The tiles are 128 pixels square and the Player's collider is 128 by 128,
> so the Player is exactly one tile wide and one tile tall. That makes level
> distances easy to reason about: a gap two tiles wide is two Player widths.

> ⚠️ **If something differs**
>
> - If the image does not appear in **FileSystem**, confirm that you copied it
>   inside the project folder itself rather than beside it, then use the
>   **FileSystem** dock's re-scan option.
> - If the preview looks blurry, that is only the preview zoom. The imported
>   size reported by the **Import** dock is what matters.

### Part 2: Add a TileMapLayer and give it a TileSet

1. Open `res://scenes/main.tscn`.
2. Select the `Main` root and add a child node of type **TileMapLayer**.
3. Rename the new node `Terrain` with `F2`.
4. Confirm that `Terrain` has Position `(0, 0)`.
5. With `Terrain` selected, find **Tile Set** in the Inspector, open the menu
   beside it, and choose **New TileSet**.
6. Click the new TileSet to open its properties and set **Tile Size** to
   `(128, 128)`.
7. Open the menu beside **Tile Set** again and choose **Save As...**. Save the
   resource as `res://levels/tiles/terrain_tileset.tres`.
8. Save `main.tscn` with `Ctrl+S`.

> 💡 A `TileMapLayer` is a node: it lives in one scene and remembers which
> tile was painted in each cell of its grid. A `TileSet` is a resource: it
> describes the tiles themselves, including their size, their artwork, their
> collision, and how they connect. Saving the TileSet to its own file means
> the levels you build in the rest of this module can share the same tiles
> instead of each rebuilding them.

> 💡 Set **Tile Size** before adding the artwork. It decides how the image is
> cut up, so changing it afterwards means cutting the tiles again.

> 💡 `Terrain` stays at Position `(0, 0)`, so cell `(0, 0)` starts at the
> world origin. That is the top-left corner of the blue viewport frame you set
> in Lesson 1.2, which makes it possible to count cells from a corner you can
> see.

> ⚠️ **If something differs**
>
> - If **Tile Size** still reads `(16, 16)`, confirm that you selected the
>   TileSet resource rather than the `Terrain` node. The node has no tile size
>   of its own.
> - If the TileSet is still stored inside `main.tscn`, confirm that
>   `terrain_tileset.tres` appears in **FileSystem**. Only a saved resource can
>   be reused by another scene.

### Part 3: Create the tiles from the atlas

1. Select `Terrain`. A **TileSet** tab and a **TileMap** tab appear in the
   bottom panel.
2. Open the **TileSet** tab.
3. Drag `terrain.png` from **FileSystem** onto the TileSet panel.
4. Godot asks whether to create tiles automatically. Answer **Yes**.
5. Confirm that the panel shows a 12-by-4 grid with a tile in every square.
6. Right-click the tile at atlas coordinates `(10, 1)` and delete it.
   Coordinates count from `(0, 0)` in the top-left corner, so that is the
   eleventh column from the left and the second row from the top: the
   transparent square left by the hole in the fourth shape.
7. Confirm that 47 tiles remain and that `(10, 1)` is now the only square
   without one.

> 💡 Automatic creation fills the grid it is given. It makes a tile in all 48
> squares, including the transparent one, so that square has to be removed by
> hand. Leaving it would put an invisible solid block in the palette, easy to
> paint by accident and hard to find afterwards.

> 💡 Remove it now rather than later. The next part selects every tile at once
> to give them collision, and a tile deleted beforehand simply is not in that
> selection. Delete it afterwards instead and you have already spent a step
> giving a collision shape to something that should not exist.

> 💡 Each tile is identified by its column and row inside the atlas, counting
> from `(0, 0)` in the top-left corner. Those atlas coordinates are how the
> next lesson refers to individual tiles.

> ⚠️ **If something differs**
>
> - If a single large tile appears instead of a grid, the tile size was still
>   `(16, 16)` when you added the image. Remove the source, correct **Tile
>   Size**, and drag the image in again.
> - If `(10, 1)` still holds a tile after step 6, it was not removed. Every
>   later check in this lesson counts 47 tiles, not 48.
> - If you answered **No** to the prompt, remove the source and drag the image
>   in a second time rather than adding 47 tiles by hand.

### Part 4: Make every tile solid

1. Select the TileSet resource in the Inspector.
2. Expand **Physics Layers** and add one element. Leave its collision layer and
   mask at their defaults.
3. Return to the **TileSet** tab at the bottom of the editor. In **Tile
   Sources** on the left, select `terrain.png`.
4. Above the atlas, switch from **Setup** to **Select**. Setup is for cutting
   the image into tiles, which Part 3 already did; **Select** is where a tile's
   own properties are edited.
5. Select every tile: hold `Shift`, press the mouse button on the top-left
   tile, drag across the whole grid, and release on the bottom-right tile. The
   hint under the atlas confirms this, reading **Hold Shift to select multiple
   regions**.
6. With every tile selected, find the **Tiles** panel to the left of the atlas
   and expand **Physics**, then open the physics layer you added in step 2.
7. A tile starts with no collision polygon at all, so draw one. Choose the
   **Add points** tool and click each of the four corners of the tile in turn,
   which outlines the whole tile. Use the **Edit points** tool afterwards if a
   corner needs nudging.
8. Confirm that every tile now shows a square outline covering its whole area.

> 💡 A physics layer is what turns painted artwork into something solid.
> Tiles drawn without one are only a picture, and the Player falls straight
> through them. The polygon is stored per tile, so a later lesson can give one
> tile a shape that is not a full square without changing the others.

> 💡 Give every tile the full square even where the painted ground stops a
> few pixels short of the tile edge, as it does on the outer sides of the
> pillar. Ground that is solid slightly beyond where it looks solid feels fair
> to play. Ground that stops short of where it looks solid does not.

> 💡 Editing every tile in one selection is not only faster, it is safer. The
> most common mistake in this lesson is a single tile that was missed, which
> produces one invisible gap somewhere in a finished level.

9. Open the **TileMap** tab, choose any tile, and paint a short row of cells in
   the empty space above the `Floor` and to the left of the Player.
10. In the editor's **Debug** menu, enable **Visible Collision Shapes**.
11. Run the current scene with `F6`.
12. Move the Player onto the painted row and confirm that it stands on the
    tiles instead of passing through them.
13. Stop the scene with `F8`.
14. Undo the painted cells with `Ctrl+Z` until the `Terrain` layer is empty
    again, and save `main.tscn` with `Ctrl+S`.

The painted row was a test, not the level. Removing it now keeps the next
lesson starting from a clean layer, in the same way the temporary `print()`
messages in Module 2 were removed once they had shown what they needed to show.

> ⚠️ **If something differs**
>
> - If the Player falls through every painted cell, confirm that the TileSet
>   has a physics layer and that the tiles have a polygon on it. Both are
>   required.
> - If the Player falls through only in places, one tile was missed. Select
>   them all again and check that each shows an outline.
> - If the outline is smaller than the tile, a corner was clicked short of the
>   edge. Switch to **Edit points** and drag it out to the corner.
> - If only one tile stays selected, `Shift` was not held for the whole drag.
>   Holding `Shift` and clicking adds one tile at a time, which is useful for
>   picking out scattered tiles; holding `Shift` and dragging takes everything
>   the drag passes over, which is what this step needs.
> - If the tiles appear but the Player passes through and no outlines are
>   drawn, confirm that **Visible Collision Shapes** is enabled and that you
>   restarted the scene afterward.

## Learner exercise

1. In the **TileSet** tab, select one tile and reshape its collision polygon so
   that it covers only the top half of the tile.
2. Predict what the Player will do when it lands on that tile.
3. Paint a short row of that one tile, run the scene, and check your
   prediction.
4. Undo with `Ctrl+Z` until the polygon covers the whole tile again and no test
   cells remain.
5. Explain why the TileSet was saved as its own file instead of being kept
   inside `main.tscn`.
6. Explain what would happen to the Player if the TileSet had no physics layer
   at all.

## Verification checklist

- [ ] `res://levels/tiles/terrain.png` exists and imports without errors.
- [ ] `res://levels/tiles/terrain_tileset.tres` exists as its own resource file
      rather than inside `main.tscn`.
- [ ] The TileSet's **Tile Size** is `(128, 128)`.
- [ ] The TileSet has exactly one atlas source, and it uses `terrain.png`.
- [ ] The atlas defines exactly 47 tiles in a 12-by-4 grid.
- [ ] No tile exists at atlas coordinates `(10, 1)`.
- [ ] The TileSet has exactly one physics layer.
- [ ] Each of the 47 tiles has exactly one collision polygon, and each polygon
      covers the whole tile.
- [ ] `main.tscn` contains exactly one `TileMapLayer`, named `Terrain`, at
      Position `(0, 0)`.
- [ ] `Terrain` uses the saved `terrain_tileset.tres`.
- [ ] The `Terrain` layer has no painted cells left at the end of the lesson.
- [ ] `main.tscn` still contains the `Floor` and `CoyoteTestPlatform` nodes,
      unchanged.
- [ ] `res://actors/player.gd` is unchanged by this lesson.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors, or
      unexplained warnings.
- [ ] The learner saw the Player stand on painted tiles before removing them.
- [ ] The learner can explain the difference between a `TileMapLayer` node and
      a `TileSet` resource.
- [ ] The learner can explain what a physics layer adds to a tile.

## References

- [Using TileSets](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html)
- [Using TileMaps](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilemaps.html)
- [TileMapLayer](https://docs.godotengine.org/en/4.7/classes/class_tilemaplayer.html)
- [TileSet](https://docs.godotengine.org/en/4.7/classes/class_tileset.html)
