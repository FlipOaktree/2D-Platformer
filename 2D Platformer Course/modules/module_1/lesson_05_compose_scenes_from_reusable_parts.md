# Module 1, Lesson 5: Compose Scenes from Reusable Parts

**Status:** Validated

## Lesson goals

Turn `ProjectIcon` into a reusable scene and keep one instance in `Main`. You
will see how source-scene changes reach every linked instance, how a property
customized on one instance becomes an override, and how an independent copy
no longer follows the original scene.

- Saving the icon as a scene of its own, so it can be used more than once
- Placing one instance of that scene in `Main`, still linked to its source
- Seeing that editing the source reaches every instance
- Seeing that an independent copy no longer follows the original scene

## Before you start

- Module 1, Lesson 4 is complete.
- `main.tscn` contains `Label` at Position `(0, 0)` and `ProjectIcon` at
  Position `(256, 240)`, Rotation `0°`, and Scale `(0.125, 0.125)`.
- `ProjectIcon` is a `Sprite2D` displaying `res://icon.svg`.

## Build steps

### Part 1: Save the icon as a reusable scene

1. Open `res://scenes/main.tscn`.
2. Select `ProjectIcon` in the Scene dock.
3. Under **Transform → Position**, set both `x` and `y` to `0`. Whatever Position a node has when saved as a scene becomes that scene's default for every future instance. Zeroing it first keeps the source at the origin; Main will store where this instance belongs.
4. Right-click `ProjectIcon` and select **Save Branch as Scene**.
5. Save the branch in `res://scenes/` as `project_icon.tscn`.

> 💡 A **branch** is a node together with any nodes arranged beneath it. Saving
> a branch as a scene turns that part of the current scene into a separately
> saved, reusable scene. This branch contains only its `Sprite2D` root for now.

6. Confirm that `ProjectIcon` remains beneath `Main` and now has an **Open in
   Editor** button beside it.
7. With the instance selected, set **Transform → Position** to `(256, 240)`.
8. Save `main.tscn` with `Ctrl+S`.

In this project, node names use **PascalCase**: each word begins with a
capital letter, with no spaces. File names use **snake_case**: lowercase
words joined with underscores. `ProjectIcon` and `project_icon.tscn` 
make both patterns visible.

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

> 💡 An **instance** stays linked to the source scene it came from. A saved source-scene change flows to all its instances. You can think of instances more or less as mirror reflections of a subject.

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
> that instance. An override changes only that property; it does not break the
> instance's source link.

4. Select the second instance and press `Delete`.
5. Confirm the deletion if Godot asks, then save `main.tscn`.
6. Select the remaining instance and confirm Position `(256, 240)`, Rotation
   `0°`, and Scale `(0.125, 0.125)`.

> ⚠️ **If something differs**
>
> - If changing Rotation affects both icons, confirm that you are back in
>   `main.tscn` and selected only the second instance.
> - If deleting one instance removes both, undo with `Ctrl+Z` and select only
>   the second instance before trying again.
> - If the final icon is missing, instantiate `project_icon.tscn` beneath
>   `Main`, set its Position to `(256, 240)`, and save `main.tscn`.

### Part 4: Compare an instance with an independent copy

1. In **FileSystem**, right-click `project_icon.tscn`, duplicate it, and name
   the copy `project_icon_copy.tscn`.
2. Select `Main`, then select **Instantiate Child Scene**.
3. Choose `res://scenes/project_icon_copy.tscn` and select **Open**.

> 💡 You can also instance a scene by dragging it from **FileSystem** and
> dropping it onto `Main` in the Scene dock. It becomes a child of `Main`, just
> like using the button.

4. Set the new instance's **Transform → Position** to `(448, 240)`.
5. Open `project_icon.tscn`, set its root **Transform → Rotation** to `20°`,
   and save.
6. Return to `main.tscn`. Confirm that the first icon rotates and the copy's
   icon stays upright.

> 💡 The copy is a separate scene file, so it has no link to
> `project_icon.tscn`. Changes to the original no longer reach it, because its
> instance follows `project_icon_copy.tscn` instead. An **independent copy** is
> a new scene that starts with the same contents.

7. Return to `project_icon.tscn`, restore Rotation to `0°`, and save.
8. In `main.tscn`, delete the copy's instance and save.
9. In **FileSystem**, delete `project_icon_copy.tscn`.
10. Confirm that `Main` contains one `ProjectIcon` instance at Position
    `(256, 240)`, Rotation `0°`, and Scale `(0.125, 0.125)`.

> ⚠️ **If something differs**
>
> - If both icons rotate, the second icon is another instance of
>   `project_icon.tscn` rather than of the copy. This happens if `ProjectIcon`
>   was duplicated in the Scene dock instead of `project_icon.tscn` being
>   duplicated in FileSystem: duplicating the node creates another instance of
>   the same source, not an independent copy. Delete it and repeat from
>   step 2.
> - If neither icon rotates, confirm that you edited and saved the root of
>   `project_icon.tscn`, not an instance inside `main.tscn`.
> - If Godot reports that `project_icon_copy.tscn` is still in use, confirm
>   that its instance was deleted from `main.tscn` first.

## Learner exercise

Without repeating the build steps:

1. Identify which scene stores the icon's texture and Scale.
2. Identify which scene stores the remaining instance's Position.
3. Explain how an scene instance and an independent copy of a scene differ.
4. Temporarily set the remaining instance's Rotation to `10°`, observe the
   result, then restore it to `0°`.

## Verification checklist

- [ ] `res://scenes/project_icon.tscn` exists.
- [ ] Its root is a `Sprite2D` named `ProjectIcon` displaying `icon.svg`.
- [ ] The source root has Position `(0, 0)`, Rotation `0°`, and Scale
    `(0.125, 0.125)`.
- [ ] `Main` contains one instance of `project_icon.tscn` at Position
    `(256, 240)`.
- [ ] `res://scenes/project_icon_copy.tscn` no longer exists.
- [ ] `Main` still contains a `Label` displaying `Project ready` at Position `(0, 0)`.
- [ ] Running the current scene displays the text and one upright icon without
    related errors or warnings.
- [ ] The learner can explain branch, reusable scene, and instance in simple language.
- [ ] The learner can distinguish a source-scene property, a per-instance
    override, and an independent copy.
- [ ] The learner can recognize PascalCase node names and snake_case file names.

## References

- [Godot scenes and nodes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [Creating scene instances](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/instancing.html)
- [Scene organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html)
