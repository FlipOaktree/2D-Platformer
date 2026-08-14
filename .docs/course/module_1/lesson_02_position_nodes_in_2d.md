# Module 1, Lesson 2: Position Nodes in 2D

**Status:** Written procedure validated and logged in Notion

## By the end

Move the existing `Label` to a deliberate position in the main scene and run
the project to see the result. This introduces the coordinates Godot uses to
place objects in 2D.

- The `Label` has a Position of `x = 96` and `y = 72`.
- `Project ready` appears away from the top-left corner of the game window.
- Navigating the 2D viewport does not accidentally move the `Label`.

## Before you start

- Module 1, Lesson 1 is complete.
- `res://scenes/main.tscn` contains a `Label` displaying `Project ready`.
- Running the project opens `main.tscn` without related errors or warnings.

## Build steps

### Part 1: Navigate the 2D viewport

1. Open `res://scenes/main.tscn`.
2. Select `Label` in the Scene dock.
3. Double-click `Label`'s icon to center it in the 2D viewport.

4. Use the zoom controls above the top-left of the 2D viewport to zoom in and
   out.
5. Hold the middle mouse button and drag to pan across the viewport. If a
   middle mouse button is unavailable, hold `Space` while dragging with the
   left mouse button.
6. Double-click `Label`'s icon again to return to it.

   Panning and zooming change only your view inside the editor. They do not
   move nodes or change what appears when the game runs.

   > ⚠️ **If something differs**
   >
   > - If zooming makes the `Label` hard to find, double-click its icon in the
   >   Scene dock to center it again.
   > - If dragging moves the `Label` instead of the viewport, undo with
   >   `Ctrl+Z`, then pan by holding the middle mouse button or `Space`.

### Part 2: Move the Label

1. Select `Label` in the Scene dock.
2. Select **Move Mode** in the toolbar above the 2D viewport or press `W`.
3. Drag the `Label` to the right and down.
4. In the Inspector, expand **Layout**, then **Transform**, and watch the
   Position values change.

   > 💡 A position in 2D uses two coordinates written as `(x, y)`. The
   > starting point `(0, 0)` is called the **origin**. You may be used to graphs
   > where `y` increases upward. In Godot's 2D screen coordinates, that origin
   > is at the top-left: increasing `x` moves right, and increasing `y` moves
   > down. This top-to-bottom direction is common in computer graphics because
   > pixel rows are counted from the top of an image or screen.

5. Press `Ctrl+Z` once to undo the drag.

   Dragging is useful for arranging a scene visually. Entering coordinates in
   the Inspector is useful when a lesson or design needs an exact,
   repeatable position.

6. Under **Layout → Transform → Position**, set:

   - **x:** `96`
   - **y:** `72`

   > 💡 A child node's Position is measured from its parent, so the `Label` is
   > positioned relative to `Main`.

7. Confirm that the `Label` moves right and down in the 2D viewport.

   > ⚠️ **If something differs**
   >
   > - If the Position fields are not visible, confirm that `Label` is selected
   >   and expand **Layout**, then **Transform**, in the Inspector.
   > - If the text disappears from the 2D viewport, enter `96` for `x` and `72`
   >   for `y`, then double-click `Label`'s icon in the Scene dock.
   > - If the Position does not remain at `x = 96` and `y = 72`, enter those
   >   values again before continuing.

### Part 3: Observe parent and child movement

1. Select `Main` in the Scene dock.
2. Select **Move Mode** in the toolbar above the 2D viewport or press `W`, then
   drag `Main` to the right and down.

> 💡 `Main` is a `Node2D`, so its **Transform** section appears directly in the
> Inspector. `Label` is a `Control` node, so its **Transform** subsection is
> organized under **Layout**. Both nodes have a Position, but Godot organizes
> their Inspector properties differently.

3. Confirm that the `Label` moves right and down with `Main` in the 2D
   viewport.
4. Select `Label` and confirm that **Layout → Transform → Position** is still
   `x = 96` and `y = 72`.

> 💡 A child's Position is measured relative to its parent. Moving `Main`
> therefore moves the whole branch without changing the `Label`'s own
> Position. The Label appears at its parent's Position plus its own Position.

5. Select `Main` and restore its Position to `x = 0` and `y = 0`.
6. Confirm that the `Label` returns to its earlier location in the 2D viewport.
7. Save the scene with `Ctrl+S`.
8. Run the current scene with `F6`.
9. Confirm that `Project ready` appears away from the top-left corner of the
   game window.
10. Stop the scene with `F8`.

> ⚠️ **If something differs**
>
> - If **Transform** is not visible directly in the Inspector, confirm that
>   `Main`, not `Label`, is selected.
> - If moving `Main` changes the Position shown for `Label`, undo with
>   `Ctrl+Z`, then confirm that only `Main` is selected before trying again.
> - If the final message appears in an unexpected location, restore `Main` to
>   `(0, 0)` and `Label` to `(96, 72)`, then save and run the scene again.

## Learner exercise

Without repeating the build steps:

1. Predict which direction the `Label` will move if only `x` changes from `96`
   to `160`.
2. Make that change and run the current scene to check the prediction.
3. Explain why panning the viewport does not change the running scene.
4. Explain why moving `Main` moved the `Label` without changing the Label's
   own Position.
5. Restore the Label Position to `x = 96` and `y = 72`, then save the scene.

## Verification checklist

- [ ] `Label` remains a child of `Main`.
- [ ] `Main` has Position `x = 0` and `y = 0`.
- [ ] The Label still displays `Project ready`.
- [ ] The Label Position is `x = 96` and `y = 72`.
- [ ] Running the current scene shows the text away from the top-left corner.
- [ ] The scene runs without related errors or warnings.
- [ ] The learner can identify the origin and the positive `x` and `y`
      directions.
- [ ] The learner can explain that a child node's Position is relative to its
      parent.
- [ ] The learner can move a parent and observe its child move without changing
      the child's own Position.
- [ ] The learner can find **Transform** directly on a `Node2D` and under
      **Layout** on a `Control` node.
- [ ] The learner can distinguish navigating the 2D viewport from moving a
      node.
- [ ] The learner can move a node visually and set its exact Position in the
      Inspector.

## References

- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
- [Control](https://docs.godotengine.org/en/4.7/classes/class_control.html)
- [Vector math](https://docs.godotengine.org/en/4.7/tutorials/math/vector_math.html)
- [Default editor shortcuts](https://docs.godotengine.org/en/4.7/tutorials/editor/default_key_mapping.html)
