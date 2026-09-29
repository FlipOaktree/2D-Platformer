# Module 0, Lesson 2: Create an Empty Godot Project

**Status:** Implemented

## Lesson goals

Create the empty Godot project that will become the reusable 2D platformer
template. Starting empty makes it clear where every later setting, scene,
script, and asset comes from. An optional last Part connects the project to
Codex.

- Creating the empty `2D Platformer` project that every later lesson builds on
- Choosing the **Forward+** renderer once, so no later lesson revisits it
- Finding the project folder in Windows
- Understanding what `project.godot` is and why its location matters
- Optionally connecting the project to Codex, with a first task that only reads

## Before you start

- Basic Windows and file-management skills are expected.
- Module 0, Lesson 1 is complete.
- Godot 4.7.2 is installed.
- A location for a new project folder is available.
- The selected folder is empty and does not contain another Godot project.

## Build steps

### Part 1: Create the project

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
7. Explore only what is needed today:
   - Scene dock.
   - FileSystem dock.
   - Inspector dock.
   - Quick overview of the top-bar menus.
8. In the FileSystem dock, right-click the `res://` root folder.
9. Select **Open in File Explorer**.
10. In Windows File Explorer, confirm that `project.godot` is present.

> 💡 The **`project.godot`** file stores the project name and settings. Its
> location defines the project root. Godot's FileSystem dock may not display
> it, so use **Open in File Explorer** to view the complete project folder on
> your computer.

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

### Part 2: Connect the project to Codex (optional)

Do this Part only if you installed Codex in Lesson 0.1. If you did not,
continue to Lesson 0.3: nothing later depends on it except the optional Codex
Parts.

Adding a local project to Codex only associates Codex with the folder you just
created. It does not create, duplicate, or move the Godot project.

1. Open Codex in the ChatGPT desktop app.
2. In the sidebar's project area, add an existing local project.
3. Select the `2D Platformer` folder that contains `project.godot`.
4. Confirm that Codex shows `2D Platformer` as the current project.
5. Start a local task for it.

> 💡 In this course, Codex works from the files in the connected folder. It has
> never read the lessons, and it cannot judge how the game looks or feels when
> you play it. So its answers describe the files in front of it, and it is your
> job to check them against everything it could not see.

6. Send Codex this prompt:

   `List the files in this project and describe what each one is for. Do not`
   `change, create, or delete any file.`

> 💡 Stating what Codex must not do keeps a first task small and easy to check.
> A task that only reads can be judged by reading; a task that edits has to be
> judged by inspecting and testing every change it made.

7. Read the answer.
8. Open the project folder in File Explorer and compare it with the list.
9. Confirm that Codex found `project.godot` and did not change anything.

> ⚠️ **If something differs**
>
> - If `project.godot` is missing from the folder you selected, you chose the
>   parent folder or the generated `.godot` folder. Select the folder that
>   holds `project.godot` instead.
> - If Codex shows a different project, switch to `2D Platformer` before
>   starting a task. A task belongs to whichever project is current.
> - If the folder cannot be selected, use **Open in File Explorer** from Part 1
>   to find where the project folder is.
> - If Codex reports files you do not recognize, confirm that the connected
>   folder is the Godot project and not its parent.
> - If Codex edits a file, it did not follow the prompt. Undo the change in
>   Godot before continuing, and repeat the request.

## Learner exercise

Without reading the steps again:

1. Open the project folder from the `res://` root.
2. Locate `project.godot`.
3. Explain in one short sentence what the `project.godot` file does.
4. If you connected Codex, ask it what the **Forward+** renderer setting in
   this project does, then name one thing it could not have checked.

## Verification checklist

- [ ] The project opens without errors.
- [ ] The project name is `2D Platformer`.
- [ ] **Open in File Explorer** opens the correct project folder.
- [ ] `project.godot` is present in that folder.
- [ ] The rendering method is **Forward+**.
- [ ] The learner can explain the purpose of `project.godot`.
- [ ] If Codex was connected, it shows `2D Platformer` as the current project
      and the connected folder contains `project.godot`.
- [ ] If Codex was connected, its first task only listed and described files,
      and no project file was changed.
- [ ] If Codex was connected, the learner can name something it cannot see.

## References

- [Godot Project Manager](https://docs.godotengine.org/en/4.7/tutorials/editor/project_manager.html)
- [Godot renderer overview](https://docs.godotengine.org/en/4.7/tutorials/rendering/renderers.html)
- [Godot project file system](https://docs.godotengine.org/en/4.7/tutorials/scripting/filesystem.html)
- [Codex local environments](https://learn.chatgpt.com/docs/environments/local-environment)
- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
