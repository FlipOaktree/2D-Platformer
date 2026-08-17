# Module 1, Lesson 3: Compose Scenes from Reusable Parts

**Status:** Validated

## By the end

Turn `ProjectIcon` into a reusable scene and keep one instance in `Main`. You
will see how source-scene changes reach every linked instance and how a
property customized on one instance becomes an override.

- `res://scenes/project_icon.tscn` contains a `Sprite2D` root named
  `ProjectIcon`.
- `Main` retains its direct `Label` child at Position `(0, 0)`.
- `Main` contains one `ProjectIcon` instance at Position `(256, 240)`.
- Running the project displays `Project ready` and the project icon.

## Before you start

- Module 1, Lesson 2 is complete.
- `main.tscn` contains `Label` at Position `(0, 0)` and `ProjectIcon` at
  Position `(256, 240)`, Rotation `0°`, and Scale `(0.125, 0.125)`.
- `ProjectIcon` is a `Sprite2D` displaying `res://icon.svg`.

## Build steps

### Part 1: Save the icon as a reusable scene

1. Open `res://scenes/main.tscn`.
2. Select `ProjectIcon` in the Scene dock.
3. Under **Transform → Position**, set both `x` and `y` to `0`.

   The icon temporarily moves to the origin. Its reusable source scene will
   begin at its own origin, while `Main` will store where the instance belongs.

4. Confirm that Rotation is `0°` and Scale is `(0.125, 0.125)`.
5. Right-click `ProjectIcon` and select **Save Branch as Scene**.
6. Save the branch in `res://scenes/` as `project_icon.tscn`.

> 💡 A **branch** is a node together with any nodes arranged beneath it. Saving
> a branch as a scene turns that part of the current scene into a separately
> saved, reusable scene. This branch contains only its `Sprite2D` root for now.

7. Confirm that `ProjectIcon` remains beneath `Main` and now has an **Open in
   Editor** button beside it.
8. With the instance selected, set **Transform → Position** to `(256, 240)`.
9. Save `main.tscn` with `Ctrl+S`.

> 💡 In this project, node names use **PascalCase**: each word begins with a
> capital letter, with no spaces. File names use **snake_case**: lowercase
> words joined with underscores. The multiword names `ProjectIcon` and
> `project_icon.tscn` make both patterns visible.

> ⚠️ **If something differs**
>
> - If **Save Branch as Scene** is unavailable, confirm that `ProjectIcon`, not
>   `Main`, is selected.
> - If the save dialog is outside `res://scenes/`, open the `scenes` folder
>   before saving.
> - If Godot warns that `project_icon.tscn` already exists, cancel and inspect
>   the existing file before replacing anything.

### Part 2: Observe a source-scene change

1. Select `Main`, then select **Instantiate Child Scene**.
2. Choose `res://scenes/project_icon.tscn` and select **Open**.
3. Select the new instance and set **Transform → Position** to `(448, 240)`.
4. Confirm that two project icons appear at different positions.
5. Select the **Open in Editor** button beside either instance.
6. In `project_icon.tscn`, select its `ProjectIcon` root and set
   **Transform → Rotation** to `20°`.
7. Save `project_icon.tscn`, then return to `main.tscn`.
8. Confirm that both icons are rotated by `20°`.

> 💡 An **instance** is not an independent copy. It stays linked to the source
> scene it came from. A saved source-scene change flows to all its instances.
> An independent copy has no source link, so later source changes do not reach
> it.

9. Return to `project_icon.tscn`, restore Rotation to `0°`, and save.
10. Return to `main.tscn` and confirm that both icons are upright again.

> ⚠️ **If something differs**
>
> - If the second icon is not beneath `Main`, delete it, select `Main`, and
>   instantiate `project_icon.tscn` again.
> - If the icons overlap, restore the second instance's Position to
>   `(448, 240)`.
> - If only one icon rotates, confirm that you edited and saved the root of
>   `project_icon.tscn`, not an instance inside `main.tscn`.

### Part 3: Customize one instance

1. In `main.tscn`, select the second `ProjectIcon` instance.
2. Set **Transform → Rotation** to `-20°`.
3. Confirm that only the second icon rotates; the first remains at `0°`.

> 💡 A property changed on a particular instance becomes an **override** for
> that instance. Both icons still get their texture and Scale from
> `project_icon.tscn`, but the second instance now stores its own Rotation in
> `main.tscn`. An override changes only that property; it does not break the
> instance's source link.

4. Select the second instance and press `Delete`.
5. Confirm the deletion if Godot asks, then save `main.tscn`.
6. Select the remaining instance and confirm Position `(256, 240)`, Rotation
   `0°`, and Scale `(0.125, 0.125)`.
7. Run the current scene with `F6`.
8. Confirm that `Project ready` and one upright project icon appear.
9. Stop the scene with `F8`.

   The temporary second instance demonstrated reuse and overrides without
   leaving duplicate content in the finished project.

> ⚠️ **If something differs**
>
> - If changing Rotation affects both icons, confirm that you are back in
>   `main.tscn` and selected only the second instance.
> - If deleting one instance removes both, undo with `Ctrl+Z` and select only
>   the second instance before trying again.
> - If the final icon is missing, instantiate `project_icon.tscn` beneath
>   `Main`, set its Position to `(256, 240)`, and save `main.tscn`.

## Learner exercise

Without repeating the build steps:

1. Identify which scene stores the icon's texture and Scale.
2. Identify which scene stores the remaining instance's Position.
3. Explain how a source-scene property, an instance override, and an
   independent copy differ.
4. Temporarily set the remaining instance's Rotation to `10°`, observe the
   result, then restore it to `0°`.
5. Confirm that `Main` contains only one `ProjectIcon` instance and save.

## Verification checklist

- [ ] `res://scenes/project_icon.tscn` exists.
- [ ] Its root is a `Sprite2D` named `ProjectIcon` displaying `icon.svg`.
- [ ] The source root has Position `(0, 0)`, Rotation `0°`, and Scale
      `(0.125, 0.125)`.
- [ ] `Main` contains one instance of `project_icon.tscn` at Position
      `(256, 240)`.
- [ ] `Main` still contains a `Label` displaying `Project ready` at Position
      `(0, 0)`.
- [ ] Running the current scene displays the text and one upright icon without
      related errors or warnings.
- [ ] The learner can explain branch, reusable scene, and instance in simple
      language.
- [ ] The learner can distinguish a source-scene property, a per-instance
      override, and an independent copy.
- [ ] The learner can recognize PascalCase node names and snake_case file
      names.

## References

- [Godot scenes and nodes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [Creating scene instances](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/instancing.html)
- [Scene organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html)
