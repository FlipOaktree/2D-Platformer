# Module 2, Lesson 12: Create a Module 2 Git Checkpoint

**Status:** Validated

## By the end

Create one tested local Git checkpoint for the completed Player foundation.
The diff is larger than Module 1's, so use a short read-only Codex review to
help spot an unexpected file or mismatch before you commit through the Git UI.

- The Player responds to the configured keyboard controls and, when available,
  the configured controller controls.
- The Player moves horizontally, falls onto the floor, and jumps only while
  grounded.
- The reviewed Module 2 changes are recorded in one new local commit on
  `main`.

## Before you start

- Module 2, Lessons 1 through 11 are complete.
- The Module 1 checkpoint exists and `git status` was clean before Module 2
  work began.
- `main.tscn` contains the Player and floor, and the project runs without
  related errors or warnings.

## Build steps

### Part 1: Confirm the completed Player foundation

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Confirm that `A` and Left Arrow move the Player left, while `D` and Right
   Arrow move it right.
3. Confirm that the Player falls onto the floor and does not sink through it.
4. Press Space while grounded and confirm that the Player jumps.
5. Confirm that pressing Space while airborne does not start another jump.
6. When available, repeat the movement and jump checks with the configured
   controller inputs.
7. Stop the scene with `F8`.

   This is the tested state the checkpoint will preserve. A later movement
   experiment can safely start from this known working result.

> ⚠️ **If something differs**
>
> - If a control does not work, return to the relevant Module 2 lesson before
>   creating a checkpoint. Do not commit a result you have not tested.
> - A controller is optional for this checkpoint. It is enough to verify the
>   configured controller inputs when compatible hardware is available.

### Part 2: Use Codex to review the larger diff

1. In the Codex task for this project, send this prompt:

   > Review the uncommitted changes from Module 2. Summarize the Player
   > foundation they add, flag anything that does not belong in this checkpoint,
   > and propose one concise commit message beginning with `Build Module 2`.
   > Do not edit, stage, or commit anything.

2. Read Codex's summary, then open the controls menu at the top right of the
   task and select **Changes**. Codex opens the changed-file diff in a
   **Review** tab.
3. Compare the Review tab with Codex's summary.
4. Confirm that the Module 2 project changes are limited to these expected
   files:

   - `project.godot`, with the input actions and their events.
   - `actors/actor.tscn`, with the reusable Actor structure.
   - `actors/player.tscn` and `actors/player.gd`, with the Player scene and
     movement script.
   - `scenes/main.tscn`, with the Player instance and floor collision.

   Generated `.godot/` files, credentials, course notes, and any change you
   cannot explain do not belong in the checkpoint.

   > 💡 This is a good use for a prompt: several related files changed during
   > Module 2, so a read-only summary can help you notice a missing or
   > unexpected piece. It does not replace inspecting the diff yourself.

> ⚠️ **If something differs**
>
> - If Codex proposes staging, editing, or committing, repeat the request and
>   keep it read-only.
> - If an expected file is missing, or an unexplained file appears, inspect it
>   before continuing. Never add a file merely to make the change list empty.

### Part 3: Commit through the Git controls, then verify

1. In the Review tab, stage only the Module 2 project files you understand.
2. Open the controls menu at the top right of the task and select **Commit or
   push**.
3. Enter Codex's proposed message, confirm that it begins with `Build Module
   2`, then create a **local commit**. Do not push.
4. Open the Review tab again and confirm that no uncommitted Module 2 project
   changes remain.
5. In Codex's integrated terminal, run:

   ```powershell
   git status
   git log --oneline -1
   git show --stat --oneline -1
   ```

6. Confirm that the working tree is clean, the latest commit starts with
   `Build Module 2`, and its file list matches the files you reviewed.

If the AI review is unavailable but the Codex Git controls still work, inspect
the Review tab yourself, use a concise commit message beginning with `Build
Module 2`, and run the same verification commands. If the Codex app is
unavailable, inspect and commit with another familiar Git interface instead.

## Learner exercise

Without creating another commit:

1. Use `git show --stat --oneline -1` to identify the checkpoint message and
   its files.
2. Name one Player behavior that lives in `player.gd` and one scene detail
   that lives in `main.tscn`.
3. Explain why a read-only Codex review was useful for this checkpoint, but
   the staging and commit were completed directly in the UI.

## Verification checklist

- [ ] Keyboard movement, falling, floor collision, and grounded jumping work
      before the checkpoint.
- [ ] Configured controller behavior works when compatible hardware is
      available.
- [ ] Codex's request only reviewed and summarized the proposed checkpoint.
- [ ] The Review tab was checked before staging and committing.
- [ ] The checkpoint contains only understood Module 2 project changes.
- [ ] The learner used **Commit or push** to create a local commit and did not
      push.
- [ ] The latest commit message begins with `Build Module 2`.
- [ ] `git status` reports a clean working tree afterward.

## References

- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
- [Record changes with Git](https://git-scm.com/book/en/v2/Git-Basics/Recording-Changes-to-the-Repository)
