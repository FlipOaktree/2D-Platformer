# Module 0, Lesson 2: Create an Empty Godot Project

**Status:** Written procedure validated and logged in Notion

## By the end

Create and reopen the empty Godot project that will become the reusable 2D
platformer template. Starting empty makes it clear where every later setting,
scene, script, and asset comes from.

- The `2D Platformer` project opens without errors.
- The project uses the **Forward+** renderer.
- The learner can locate the complete project folder in Windows.
- The learner understands what `project.godot` does.
- No gameplay scenes or scripts have been added yet.

## Before you start

- Basic Windows and file-management skills are expected.
- Module 0, Lesson 1 is complete.
- Godot 4.7.1 is installed.
- A location for a new project folder is available.
- The selected folder is empty and does not contain another Godot project.

## Build steps

1. Open the **Godot Project Manager**.
2. Select **Create**.
3. Enter `2D Platformer` as the project name.
4. Use **Browse** to select a new, empty project folder.

5. Select the **Forward+** renderer.

   > 💡 A **renderer** processes the game's graphics and draws them on screen.
   > Different renderers support different visual effects. We use **Forward+**
   > so we can add polished effects later. Changing the renderer after effects
   > are already in use can require adjustments.
6. Create and open the project.

7. Point out only what is needed today:
   - Scene dock.
   - FileSystem dock.
   - Inspector dock.
   - Quick overview of the top-bar menus.
8. In the FileSystem dock, right-click the `res://` root folder.
9. Select **Open in File Explorer**.
10. In Windows File Explorer, confirm that `project.godot` is present.
   > 💡 The **`project.godot`** file stores the project name and settings. Its
   > location defines the project root. Godot's FileSystem dock may not display
   > it, so use **Open in File Explorer** to view the complete project folder.

11. Return to Godot.

> ⚠️ **If something differs**
>
> - If the selected folder already contains another project, choose or create
>   a new empty folder.
> - If `project.godot` is not visible in the FileSystem dock, this is normal;
>   right-click `res://` and select **Open in File Explorer**.
> - If the renderer choice is unclear, open `Project → Project Settings →
>   Rendering → Renderer → Rendering Method` and confirm **Forward+**.
> - If the editor feels overwhelming, focus only on the four areas introduced
>   in step 7.

## Learner exercise

Without reading the steps again:

1. Close the project.
2. Reopen it from the Godot Project Manager.
3. Open the project folder from the `res://` root.
4. Locate `project.godot`.
5. Explain in one short sentence what that file does.

## Verification checklist

- [ ] The project opens without errors.
- [ ] The project name is `2D Platformer`.
- [ ] **Open in File Explorer** opens the correct project folder.
- [ ] `project.godot` is present in that folder.
- [ ] The rendering method is **Forward+**.
- [ ] Closing and reopening the project succeeds.
- [ ] The learner can explain the purpose of `project.godot`.

## References

- [Godot Project Manager](https://docs.godotengine.org/en/4.7/tutorials/editor/project_manager.html)
- [Godot renderer overview](https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html)
- [Godot project file system](https://docs.godotengine.org/en/4.7/tutorials/scripting/filesystem.html)
