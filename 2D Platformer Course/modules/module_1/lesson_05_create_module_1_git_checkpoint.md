# Module 1, Lesson 5: Create a Module 1 Git Checkpoint

**Status:** Validated

## By the end

Create a tested Git checkpoint for the completed Module 1 scene foundations.
Codex will prepare a read-only review first; you will inspect the proposed
changes, then use Codex's Git controls to create the local commit.

- The project still runs `main.tscn` and displays `Project ready` with one
  upright project icon.
- The Module 1 scene changes are recorded in one new local commit on `main`.
- The working tree is clean after the checkpoint.

## Before you start

- Module 1, Lessons 1 through 4 are complete.
- The Module 0 Git checkpoint exists, and Codex is connected to the folder
  containing `project.godot`.
- `main.tscn` contains the `Label` and one `ProjectIcon` instance, and the
  project runs without related errors or warnings.

## Build steps

### Part 1: Test the finished Module 1 result

1. Open the `2D Platformer` project in Godot.
2. Run the project with `F5`.
3. Confirm that the game window displays `Project ready` and one upright
   project icon.
4. Stop the project with `F8`.

   A checkpoint is most useful after a result has been tested. If a later
   change goes wrong, this commit gives you a known working Module 1 state to
   return to.

> ⚠️ **If something differs**
>
> - If the project does not show the expected text and icon, stop here and
>   correct the relevant Module 1 lesson before creating a checkpoint.
> - If Godot reports an unrelated warning, do not assume it belongs in this
>   checkpoint. Identify it before continuing.

### Part 2: Ask Codex to prepare a read-only checkpoint review

1. In the Codex task for this project, send this prompt:

   > Review the uncommitted changes from Module 1. Summarize what they add,
   > flag anything that does not belong in this checkpoint, and propose one
   > concise commit message beginning with `Build Module 1`. Do not edit,
   > stage, or commit anything.

   > 💡 You already used a **read-only request** in Lesson 0.4. Here it lets
   > Codex prepare the checkpoint while you keep control of what is saved.
   > A useful commit message describes the completed result, not every click
   > that produced it.

2. Read Codex's summary before acting on it.
3. At the top right of the task, open the controls menu (the sliders icon) and
   select **Changes**. Codex opens the changed-file diff in a **Review** tab.
4. Compare the Review tab with Codex's summary.
5. Confirm that the Module 1 project changes are limited to the expected
   files:

   - `project.godot`, which records `main.tscn` as the project's main scene.
   - `scenes/main.tscn`, which stores `Main`, its Label, and the icon instance.
   - `scenes/project_icon.tscn`, which stores the reusable icon scene.

   Course notes, generated `.godot/` files, credentials, or any change you
   cannot explain do not belong in this checkpoint.

> ⚠️ **If something differs**
>
> - If Codex proposes staging, editing, or committing during this part, do
>   not approve it. Repeat the request and keep it read-only.
> - If an expected file is missing or an unexpected file appears, inspect it
>   before continuing. Do not use a checkpoint to hide an unexplained change.

### Part 3: Commit through the Git controls, then verify

1. When the summary, diff, and proposed message are correct, stage only the
   expected Module 1 project files in the Review tab.
2. At the top right of the task, open the controls menu (the sliders icon) and
   select **Commit or push**.
3. Enter Codex's proposed message, confirm that it begins with `Build Module
   1`, then create a **local commit**. Do not push.

   > 💡 Codex is useful here because its read-only review can reveal an
   > unexpected file or mismatch. Staging and committing are routine visible
   > actions, so use the Git controls directly after you understand the diff.

4. Open the Review tab again and confirm that no uncommitted Module 1 project
   changes remain.
5. In Codex's integrated terminal, run:

   ```powershell
   git status
   git log --oneline -1
   git show --stat --oneline -1
   ```

6. Confirm that Git reports a clean working tree and that the latest commit
   starts with `Build Module 1`. Confirm that its file list matches the files
   you approved.

If the AI review is unavailable but the Codex Git controls still work, inspect
the Review tab yourself, use a concise commit message beginning with `Build
Module 1`, and run the same three verification commands. If the Codex app is
unavailable, inspect and commit with another familiar Git interface instead.

## Learner exercise

Without creating another commit:

1. Run `git show --stat --oneline -1` in the integrated terminal.
2. Identify the checkpoint message and the files it contains.
3. Explain why testing, a read-only review, diff inspection, and a local
   commit happen in that order.
4. Explain why a generated file or an unexplained change should not be added
   merely to make `git status` clean.

## Verification checklist

- [ ] Running the project before the checkpoint displays `Project ready` and
      one upright project icon without related errors or warnings.
- [ ] Codex's first request only reviewed and summarized the proposed
      checkpoint.
- [ ] The Review tab was checked before the local commit was created.
- [ ] The checkpoint contains only understood Module 1 project changes.
- [ ] The learner used **Commit or push** to create the local commit and did
      not push.
- [ ] The latest commit message begins with `Build Module 1`.
- [ ] `git status` reports a clean working tree afterward.
- [ ] The learner can explain why each reviewed module ends with one tested
      checkpoint.

## References

- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
- [Record changes with Git](https://git-scm.com/book/en/v2/Git-Basics/Recording-Changes-to-the-Repository)
