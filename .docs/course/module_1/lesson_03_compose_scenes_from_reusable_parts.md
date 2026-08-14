# Module 1, Lesson 3: Compose Scenes from Reusable Parts

**Status:** Written procedure validated and logged in Notion

## By the end

Turn the existing message into a reusable scene and place an instance of it in
the main scene. The project will still display `Project ready` in the same
position, but the message will now be a separate part that other scenes can
reuse.

- `res://scenes/status_message.tscn` contains a `Label` root named
  `StatusMessage`.
- `Main` contains an instance of `StatusMessage` at Position `x = 96` and
  `y = 72`.
- Running the project still displays `Project ready` away from the top-left
  corner.

## Before you start

- Module 1, Lesson 2 is complete.
- `res://scenes/main.tscn` contains a `Label` displaying `Project ready` at
  Position `x = 96` and `y = 72`.
- Running the project opens `main.tscn` without related errors or warnings.

## Build steps

### Part 1: Save the message as a reusable scene

1. Open `res://scenes/main.tscn`.
2. Select `Label` in the Scene dock. Rename it by pressing `F2`, clicking its
   name again, or right-clicking it and selecting **Rename**.
3. Enter `StatusMessage`, then press `Enter`.

> 💡 In this project, we will use **PascalCase** for node names, where each word
> begins with a capital letter and there are no spaces. We will use
> **snake_case** for file names, where words are lowercase and joined with
> underscores. The multiword names `StatusMessage` and `status_message.tscn`
> make both patterns visible.

4. In the Inspector, expand **Layout**, then **Transform**.
5. Set the Position to `x = 0` and `y = 0`.

   The message temporarily returns to the top-left. Its reusable scene will
   begin at its own origin, while `Main` will decide where its instance belongs.

6. In the Scene dock, right-click `StatusMessage` and select **Save Branch as
   Scene**.
7. Save the branch in `res://scenes/` as `status_message.tscn`.

> 💡 A **branch** is a node together with any nodes arranged beneath it. Saving
> a branch as a scene turns that part of the current scene into a separately
> saved, reusable scene. `StatusMessage` has no children yet, so this branch
> contains only its `Label` root.

8. Confirm that `StatusMessage` remains beneath `Main` and now has an
   **Open in Editor** button to its right.
9. Save `main.tscn` with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If **Save Branch as Scene** is unavailable, confirm that `StatusMessage`,
>   not `Main`, is selected.
> - If the save dialog is not inside `res://scenes/`, open the `scenes` folder
>   before saving.
> - If Godot warns that `status_message.tscn` already exists, cancel the save
>   and confirm whether the scene was created during an earlier attempt before
>   replacing anything.

### Part 2: Position and reuse the scene instance

1. Select `StatusMessage` beneath `Main`.
2. In the Inspector, expand **Layout**, then **Transform**, and set its Position
   to:

   - **x:** `96`
   - **y:** `72`

> 💡 An instance is not an independent copy. It stays linked to the source scene it came from. Changing the saved source scene updates all its instances, except for properties customized on a particular instance in the Inspector. An independent copy has no such link, so later changes to the original do not affect it. Here, both messages get their Text from status_message.tscn, while each instance stores its own Position in Main.

3. Save `main.tscn`.
4. Select `Main` in the Scene dock, then select **Instantiate Child Scene**.
5. Choose `res://scenes/status_message.tscn` and select **Open**.
6. Select the new instance. In the Inspector, expand **Layout**, then its
   **Transform** subsection. Under **Position**, set `x = 96` and `y = 144`.
7. Confirm in the 2D viewport that two instances display `Project ready` at
   different positions.
8. Select the **Open in Editor** button beside either instance to open
   `status_message.tscn`.
9. Select its `StatusMessage` root and change **Text** to:

   ```text
   Reusable scene ready
   ```

10. Save `status_message.tscn`, then return to the `main.tscn` tab.
11. Confirm in the 2D viewport that both instances now display
    `Reusable scene ready`.

    Both messages changed because they are instances linked to the same saved
    scene, not independent copies.

12. Return to `status_message.tscn`, restore its Text to `Project ready`, and
    save it.
13. Return to `main.tscn` and confirm that both instances again display
    `Project ready`.
14. Select the second instance and press `Delete`.
15. Confirm the deletion if Godot asks, then save `main.tscn`.
16. Select the remaining instance and confirm that
    **Layout → Transform → Position** is `x = 96` and `y = 72`.
17. Select **Run Current Scene** or press `F6`.
18. Confirm that only one `Project ready` message appears away from the
    top-left corner.
19. Stop the scene with `F8`.

    The temporary second instance demonstrated reuse without leaving duplicate
    content in the finished project.

> ⚠️ **If something differs**
>
> - If the new instance is not beneath `Main`, delete it, select `Main`, and
>   instantiate `status_message.tscn` again.
> - If both messages overlap, select the newly added instance in the Scene panel and confirm that
>   **Layout → Transform → Position** is `x = 96` and `y = 144`.
> - If changing Text updates only one message, confirm that you opened
>   `status_message.tscn`, changed its root Label, and saved that scene.
> - If deleting one instance removes both messages, undo with `Ctrl+Z` and
>   confirm that only the second instance is selected before trying again.
> - If the final project is empty, instantiate `status_message.tscn` beneath
>   `Main`, set its Position to `x = 96` and `y = 72`, and save `main.tscn`.

## Learner exercise

Without repeating the build steps:

1. Open `res://scenes/status_message.tscn` and identify its root node and Text
   property.
2. Return to `main.tscn` and identify which scene stores the message text and
   which scene stores this instance's position.
3. Explain why changing `status_message.tscn` updates its instances but would
   not update an independent copy.
4. Confirm that `Main` contains only one `StatusMessage` instance, then save
   both scenes.

## Verification checklist

- [ ] `res://scenes/status_message.tscn` exists.
- [ ] Its root is a `Label` named `StatusMessage`.
- [ ] The StatusMessage root displays Project ready and has Position x = 0 and y = 0.
- [ ] `Main` contains one instance of `status_message.tscn`.
- [ ] The instance in `Main` has Position `x = 96` and `y = 72`.
- [ ] Running the current scene displays one `Project ready` message in the
      same position as before.
- [ ] The scene runs without related errors or warnings.
- [ ] The learner can explain branch, reusable scene, and instance in simple
      language.
- [ ] The learner can distinguish the reusable scene's own content from an
      instance's placement in its parent scene.
- [ ] The learner can explain the difference between a linked instance and an
      independent copy.
- [ ] The learner can recognize PascalCase node names and snake_case scene
      file names.

## References

- [Godot scenes and nodes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [Creating scene instances](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/instancing.html)
