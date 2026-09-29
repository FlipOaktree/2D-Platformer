# Module 0, Lesson 3: Connect the Project to Codex

**Status:** Implemented

## Lesson goals

Associate Codex with the Godot project folder created in Lesson 0.2, then give
it a read-only first task. This does not create, duplicate, or move the Godot
project.

- Pointing Codex at the Godot project folder and nothing else
- Giving Codex a first task that only reads, so you can judge its answer by
  reading
- Understanding what Codex can see and what it cannot

## Before you start

- Module 0, Lessons 1 and 2 are complete.
- Codex opens with the Windows-native agent and **Ask for approval** selected.
- The `2D Platformer` project opens without errors.
- The complete project-folder path from Lesson 0.2 is at hand.

## Build steps

### Part 1: Add the existing folder as a local project

The Godot project already exists because you created it in Lesson 0.2. Adding a
local project to Codex only associates Codex with that existing folder.

1. Open Codex in the ChatGPT desktop app.
2. In the sidebar's project area, add an existing local project.
3. Select the `2D Platformer` folder that contains `project.godot`. If
   `project.godot` is not in the folder you chose, you have selected the parent
   folder or the generated `.godot` folder rather than the project folder.
4. Confirm that Codex shows `2D Platformer` as the current project.
5. Start a local task for it.

> ⚠️ **If something differs**
>
> - If Codex shows a different project, switch to `2D Platformer` before
>   starting a task. A task belongs to whichever project is current.
> - If the folder cannot be selected, confirm the path you recorded in
>   Lesson 0.2.

### Part 2: Give Codex a read-only first task

1. Send Codex this prompt:

   `List the files in this project and describe what each one is for. Do not`
   `change, create, or delete any file.`

2. Read the answer.
3. Open the project folder in File Explorer and compare it with the list.
4. Confirm that Codex found `project.godot` and did not change anything.

> 💡 Stating what Codex must not do keeps a first task small and easy to check.
> A task that only reads can be judged by reading; a task that edits has to be
> judged by inspecting and testing every change it made.

> 💡 Codex reads the connected folder and nothing else. It cannot see this
> course, other folders on your computer, or the game running. So it can only
> answer questions about the files in front of it, and it is your job to check
> its answer against everything it could not see.

> ⚠️ **If something differs**
>
> - If Codex reports files you do not recognize, confirm that the connected
>   folder is the Godot project and not its parent.
> - If Codex edits a file, it did not follow the prompt. Undo the change in
>   Godot before continuing, and repeat the request.

## Learner exercise

Without repeating the build steps:

1. Ask Codex what the **Forward+** renderer setting in this project does.
2. Read the answer and name one thing Codex could not have checked.
3. Explain the difference between creating the Godot project in Lesson 0.2 and
   connecting its existing folder to Codex in this lesson.

## Verification checklist

- [ ] Codex shows `2D Platformer` as the current project.
- [ ] The connected folder contains `project.godot`.
- [ ] No second Godot project or duplicate project folder was created.
- [ ] Codex's first task only listed and described files.
- [ ] No project file was changed by that task.
- [ ] The learner can name something Codex cannot see.

## References

- [Codex local environments](https://learn.chatgpt.com/docs/environments/local-environment)
- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
