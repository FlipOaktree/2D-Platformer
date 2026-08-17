# Module 1, Lesson 2: Transform Nodes in 2D

**Status:** Validated

## By the end

Add the Godot project icon to the main scene and transform it with the three
toolbar tools in order: Move, Rotate, and Scale. You will connect each visual
tool to its matching Inspector property and observe how a parent's transform
affects its children.

- `Label` remains at Position `(0, 0)` and displays `Project ready`.
- `ProjectIcon` displays `icon.svg` at Position `(256, 240)`, Rotation `0°`,
  and Scale `(0.125, 0.125)`.
- `Main` remains at Position `(0, 0)`.

## Before you start

- Module 1, Lesson 1 is complete.
- `res://scenes/main.tscn` contains a `Label` displaying `Project ready` at
  Position `(0, 0)`.
- You can pan, zoom, and center a selected node in the 2D viewport.

## Build steps

### Part 1: Add the project icon

1. Open `res://scenes/main.tscn`.
2. Select `Main` in the Scene dock, then select **Add Child Node**.
3. Search for `Sprite2D`, select it, and select **Create**.
4. Rename the new node `ProjectIcon`.
5. In the FileSystem dock, find `res://icon.svg`, then drag it onto the empty
   **Texture** field in the Inspector.
6. Double-click `ProjectIcon`'s icon in the Scene dock to center it in the 2D
   viewport. Zoom out until you can comfortably see around the image.

> 💡 A `Sprite2D` displays a 2D image called a **texture**. Godot centers the
> texture on the Sprite2D's position by default, which makes its movement,
> rotation, and scaling easy to see.

> ⚠️ **If something differs**
>
> - If the icon does not appear, confirm that `icon.svg` is assigned to the
>   Sprite2D's **Texture** property.
> - If the icon fills the viewport, zoom out. Its size will be adjusted later
>   in this lesson.
> - If **Transform** is not visible in the Inspector, confirm that
>   `ProjectIcon`, not `Label`, is selected.

### Part 2: Move the project icon

1. With `ProjectIcon` selected, select **Move Mode** in the toolbar above the
   2D viewport or press `W`.
2. Drag the icon to the right and down.
3. In the Inspector, expand **Transform** and watch the Position values change.

> 💡 A position in 2D uses two coordinates written as `(x, y)`. The starting
> point `(0, 0)` is called the **origin**. You may be used to graphs where `y`
> increases upward. In Godot's 2D screen coordinates, the origin is at the
> top-left: increasing `x` moves right, and increasing `y` moves down. This is
> common in computer graphics because pixel rows are counted from the top of
> an image or screen.

4. Under **Transform → Position**, set `x` to `256` and `y` to `240`.

   Dragging is useful for arranging a scene visually. Exact Inspector values
   make a position repeatable.

> 💡 A child node's Position is measured from its parent, so `ProjectIcon` is
> positioned relative to `Main`.

5. Confirm that Position is `(256, 240)`.

> ⚠️ **If something differs**
>
> - If dragging changes the wrong node, undo with `Ctrl+Z`, select
>   `ProjectIcon`, and try again.
> - If the icon moves outside your view, enter Position `(256, 240)`, then
>   double-click its icon in the Scene dock.

### Part 3: Rotate the project icon

1. Select **Rotate Mode** in the toolbar or press `E`.
2. Drag around the icon and watch **Transform → Rotation** change.

> 💡 **Rotation** turns a node around its center. Godot displays the Inspector
> value in degrees: positive values turn clockwise in the 2D viewport, while
> negative values turn counterclockwise.

3. Press `Ctrl+Z` to undo the rotation.
4. Confirm that Rotation is `0°`. If it is not, enter `0` in the Inspector.

> ⚠️ **If something differs**
>
> - If dragging moves the icon instead, undo, then select Rotate Mode or press
>   `E` before dragging.
> - If the icon rotates around an unexpected point, confirm that
>   `ProjectIcon` is selected and that its Texture is centered by default.

### Part 4: Scale the project icon

1. Select **Scale Mode** in the toolbar or press `S`.
2. Drag one of the handles around the icon and watch **Transform → Scale**
   change.
3. Press `Ctrl+Z` to undo the scale change.
4. Under **Transform → Scale**, set both `x` and `y` to `0.125`.

> 💡 **Scale** changes how large a node appears compared with its imported
> size. A Scale of `(1, 1)` means 100%. Values below `1` make it smaller, while
> values above `1` make it larger. Equal `x` and `y` values preserve the
> image's proportions; different values stretch it.
>
> Enlarging raster images such as PNG or JPEG files above 100% can make them
> look blurry or pixelated because they contain a fixed number of pixels. SVG
> images such as `icon.svg` are designed to scale more cleanly, and Godot
> imports them as automatically scalable textures.

5. Confirm that the icon becomes smaller without looking stretched.

   The toolbar tools and Inspector properties control the same transform:
   Move Mode (`W`) changes Position, Rotate Mode (`E`) changes Rotation, and
   Scale Mode (`S`) changes Scale.

> ⚠️ **If something differs**
>
> - If the icon looks stretched, restore both Scale values to `0.125`.
> - If the icon disappears, restore Position `(256, 240)`, Rotation `0°`, and
>   Scale `(0.125, 0.125)`, then center it from the Scene dock.

### Part 5: Observe parent and child transforms

1. Select `Main` in the Scene dock.
2. Select **Move Mode** or press `W`, then drag `Main` to the right and down.

> 💡 `Main` and `ProjectIcon` are `Node2D`-based nodes, so **Transform** appears
> directly in the Inspector. `Label` is a `Control` node, so its **Transform**
> subsection appears under **Layout**.

3. Confirm that both `Label` and `ProjectIcon` move with `Main`.
4. Select `Label` and confirm its **Layout → Transform → Position** remains
   `(0, 0)`.
5. Select `ProjectIcon` and confirm its Position remains `(256, 240)`, its
   Rotation remains `0°`, and its Scale remains `(0.125, 0.125)`.

> 💡 A child's transform is relative to its parent. Moving `Main` changes where
> the whole branch appears without changing either child's own local transform.

6. Select `Main` and restore its Position to `(0, 0)`.
7. Save the scene with `Ctrl+S`.
8. Run the current scene with `F6`.
9. Confirm that `Project ready` and the project icon are visible.
10. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If moving `Main` changes a child's Inspector values, undo and confirm that
>   only `Main` is selected before trying again.
> - If the final scene looks unexpected, restore `Main` and `Label` to
>   Position `(0, 0)`, and restore `ProjectIcon` to Position `(256, 240)`,
>   Rotation `0°`, and Scale `(0.125, 0.125)`.

## Learner exercise

Without repeating the build steps:

1. Predict what will happen if `ProjectIcon` Rotation changes to `-15°`.
2. Make the change in the Inspector and check the prediction in the viewport.
3. Explain why changing both Scale values together preserves the icon's shape.
4. Restore Rotation to `0°`.
5. Explain why moving `Main` moves both children without changing their own
   transform values, then save the scene.

## Verification checklist

- [ ] `Label` and `ProjectIcon` are children of `Main`.
- [ ] `Main` and `Label` have Position `(0, 0)`.
- [ ] `Label` displays `Project ready`.
- [ ] `ProjectIcon` is a `Sprite2D` displaying `icon.svg`.
- [ ] `ProjectIcon` has Position `(256, 240)`, Rotation `0°`, and Scale
      `(0.125, 0.125)`.
- [ ] Running the current scene shows the text and icon without related errors
      or warnings.
- [ ] The learner can identify the origin and positive `x` and `y` directions.
- [ ] The learner can use Move, Rotate, and Scale in toolbar order and match
      them to their Inspector properties.
- [ ] The learner can explain why equal Scale values preserve proportions and
      why enlarging a raster image can reduce its apparent quality.
- [ ] The learner can explain that a child's transform is relative to its
      parent.
- [ ] The learner can find **Transform** directly on `Node2D`-based nodes and
      under **Layout** on a `Control` node.

## References

- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
- [Sprite2D](https://docs.godotengine.org/en/4.7/classes/class_sprite2d.html)
- [Control](https://docs.godotengine.org/en/4.7/classes/class_control.html)
- [ResourceImporterSVG](https://docs.godotengine.org/en/4.7/classes/class_resourceimportersvg.html)
- [Introduction to 2D](https://docs.godotengine.org/en/4.7/tutorials/2d/introduction_to_2d.html)
- [Default editor shortcuts](https://docs.godotengine.org/en/4.7/tutorials/editor/default_key_mapping.html)
