# Module 0, Lesson 1: Create an Empty Godot Project

**Status:** Written procedure validated and logged in Notion

## Learning outcome

Create and reopen an empty Godot project that will become the reusable 2D
platformer template.

> **Validated:** These steps were followed and checked in Godot 4.7.1. The
> written lesson is being completed and tested before video production begins.

## Finished result

At the end of this lesson:

- The `2D Platformer` project opens without errors.
- The project uses the **Forward+** renderer.
- The learner can locate the complete project folder in Windows.
- The learner understands what `project.godot` does.
- No gameplay scenes or scripts have been added yet.

## Why this comes first

Every later lesson adds to this project. Starting empty makes it easy to see
where each setting, scene, script, and asset comes from.

## Before you start

- No Godot or programming experience is required.
- Basic Windows and file-management skills are expected.
- Godot 4.7.1, or another verified Godot 4.7 release, is installed.
- A location for a new project folder is available.
- The selected folder is empty and does not contain another Godot project.

## Course decisions

| Setting | Course choice | Why |
| --- | --- | --- |
| Project name | `2D Platformer` | Short, clear, and used consistently throughout the course. |
| Engine version | Godot 4.7.x | The template and lessons are tested against this version. |
| Renderer | Forward+ | The target renderer for this desktop template and its polished 2D visuals. |
| Project folder | A new, empty folder | Keeps the project together and avoids overwriting another project. |

The renderer can be changed later, but changing it after visual effects are in
use may require extra adjustments.

## New concepts

- **Game engine:** A collection of tools and systems used to build and run a
  game. Godot is the game engine used in this course.
- **Project Manager:** The window used to create, import, rename, and open
  Godot projects.
- **Project folder:** The Windows folder containing the files for one game.
- **FileSystem dock:** Godot's view of the scenes, scripts, assets, and other
  game files inside the project.
- **`res://`:** Godot's short name for the root of the current project folder.
- **Renderer:** The system Godot uses to process your game's graphics and draw
  them on screen. Different renderers support different visual features and
  have different performance needs.

Only these concepts are introduced now. The rest of the editor will be learned
as the project needs it.

## Lesson steps

1. Open the **Godot Project Manager**.
2. Select **Create**.
3. Enter `2D Platformer` as the project name.
4. Use **Browse** to select a new, empty project folder.
5. Select the **Forward+** renderer.
6. Create and open the project.
7. Point out only what is needed today:
   - Scene dock.
   - FileSystem dock.
   - Inspector dock.
   - Quick overview of the top-bar menus.
8. In the FileSystem dock, right-click the `res://` root folder.
9. Select **Open in File Explorer**.
10. In Windows File Explorer, confirm that `project.godot` is present.
11. Return to Godot.

## Understand what you created

### What is `project.godot`?

A Godot project is a folder containing the files for one game. The most
important file at the beginning is `project.godot`. It stores the project name
and settings, and its location defines the root of the project.

Godot's FileSystem dock mainly displays game files such as scenes, scripts, and
assets. It may not display `project.godot`. Right-clicking `res://` and
selecting **Open in File Explorer** shows the complete Windows folder.

### Why are we using Forward+?

Forward+ is the course's target renderer for this 2D desktop game. It gives us
room to use polished visual effects later in the course.

To verify it, open:

`Project → Project Settings → Rendering → Renderer → Rendering Method`

Confirm that **Forward+** is selected.

## Modularity checkpoint

No gameplay module is added in this lesson. We are creating a clean foundation
so later modules can be added, removed, and customized without mixing them into
the initial setup.

There are no Inspector customization points yet.

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

## Common mistakes

| Problem | What to do |
| --- | --- |
| The selected folder already contains another project. | Choose or create a new empty folder. |
| `project.godot` is not visible in the Godot FileSystem dock. | Right-click `res://` and select **Open in File Explorer**. |
| The renderer choice is unclear. | Check **Project Settings → Rendering → Renderer → Rendering Method**. |
| The editor feels overwhelming. | Focus only on the four areas introduced in this lesson. |

## Instructor and production notes

- Do not record the video yet. Videos and learner downloads are produced after
  the complete written course passes end-to-end testing.
- This lesson doubles as the future recording outline.
- A Codex **Run Game** action is not needed yet because the project has no main
  scene.
- Codex is not used in this lesson because it would not make creating and
  recognizing the empty project clearer or faster. AI will be introduced
  inside later lessons when it provides meaningful learning or efficiency.
- Keep the working project aligned with the **Forward+** renderer.

## References

- [Godot Project Manager](https://docs.godotengine.org/en/4.7/tutorials/editor/project_manager.html)
- [Godot renderer overview](https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html)
- [Godot project file system](https://docs.godotengine.org/en/4.7/tutorials/scripting/filesystem.html)
