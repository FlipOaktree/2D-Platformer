# Module 3, Lesson 6: Create a Module 3 Git Checkpoint

**Status:** Validated

## By the end

Create one tested local Git checkpoint for the completed responsive controller.
Module 3 changed a single script heavily rather than adding many files, so the
review focuses on whether the settings and the interacting jump timers are the
ones you meant to keep.

- The Player accelerates, decelerates, reverses, falls, and lands as tuned.
- Grounded jumping, coyote time, jump buffering, and variable jump height all
  work together.
- The eight movement settings show their validated defaults in the Inspector.
- The reviewed Module 3 changes are recorded in one new local commit on `main`.

## Before you start

- Module 3, Lessons 1 through 5 are complete and validated.
- The Module 2 checkpoint exists and `git status` was clean before Module 3
  work began.
- `res://scenes/main.tscn` contains the original Floor and the raised
  `CoyoteTestPlatform`.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Confirm the completed responsive controller

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Hold a direction and confirm that the Player accelerates to full speed
   rather than starting instantly.
3. Release the input and confirm that the Player decelerates to a stop.
4. Reverse direction while moving and confirm that the change is smooth.
5. Confirm that the Player falls, lands on the Floor, and jumps while grounded.
6. Walk off the edge of the raised platform and press jump immediately.
   Confirm that the coyote-time jump still works.
7. Fall toward the Floor and press jump shortly before landing. Confirm that
   the buffered jump starts on landing.
8. Compare a tapped jump with a held jump. Confirm that the tapped jump is
   noticeably lower.
9. When available, repeat the movement and jump checks with the configured
   controller inputs.
10. Stop the scene with `F8`.

   This is the tested state the checkpoint will preserve. Module 4 begins
   building real levels, so this is the last point where the controller is the
   only thing that can break.

11. Open `res://actors/player.tscn`, select the Player root, and confirm these
    eight Inspector defaults:

    | Setting | Default |
    | --- | --- |
    | Speed | `450.0` |
    | Acceleration | `1800.0` |
    | Deceleration | `2700.0` |
    | Gravity | `2400.0` |
    | Jump Velocity | `-1200.0` |
    | Coyote Time | `0.1` |
    | Jump Buffer Time | `0.1` |
    | Jump Release Multiplier | `0.5` |

> 💡 Checking the Inspector before committing matters more in this module than
> in earlier ones. Every lesson in Module 3 ended with an exercise that changed
> a value and then restored it. A single value left at an experiment setting
> would be committed as though it were the tuned default.

> ⚠️ **If something differs**
>
> - If a movement or jump behavior does not work, return to the relevant
>   Module 3 lesson before creating a checkpoint. Do not commit a result you
>   have not tested.
> - If a setting does not match the table, restore it, save `player.tscn`, and
>   run the scene again before continuing.
> - A controller is optional for this checkpoint. It is enough to verify the
>   configured controller inputs when compatible hardware is available.

### Part 2: Use Codex to review the Module 3 diff

1. In the Codex task for this project, send this prompt:

   > Review the uncommitted changes from Module 3. Summarize the movement
   > settings and jump behavior they add, list every exported setting you find
   > with its default value, flag anything that does not belong in this
   > checkpoint, and propose one concise commit message beginning with `Build
   > Module 3`. Do not edit, stage, or commit anything.

2. Read Codex's summary, then open the controls menu at the top right of the
   task and select **Changes**. Codex opens the changed-file diff in a
   **Review** tab.
3. Compare the Review tab with Codex's summary.
4. Confirm that the Module 3 project changes are limited to these expected
   files:

   - `actors/player.gd`, with the eight exported settings, the two runtime
     countdowns, and the acceleration, coyote-time, jump-buffer, and
     jump-shortening logic.
   - `scenes/main.tscn`, with the raised `CoyoteTestPlatform` and its
     collision shape.
   - `actors/player.tscn` may show a small change that you did not type, or no
     change at all. Saving a scene lets Godot write its own bookkeeping
     attributes. Confirm that it contains no changed movement value before
     accepting it.

   Generated `.godot/` files, credentials, course notes, and any change you
   cannot explain do not belong in the checkpoint.

   > 💡 This module changed one script a great deal instead of adding several
   > files. A read-only summary is useful here for a different reason than in
   > Module 2: it can describe what the finished movement code does, which is
   > easier to compare against your intent than a long line-by-line diff.

   > 💡 Codex is asked to list the defaults, not to approve them, and the
   > difference matters. It was connected to the folder holding
   > `project.godot` in Lesson 0.4, so it can read your code but has never
   > seen a lesson and has no idea what the course said a value should be.
   > Asked to confirm a match it cannot check, it would very likely confirm
   > one anyway. Compare its list against the table you checked in Part 1.
   > That comparison is yours to make, and it is the whole reason for asking.

> ⚠️ **If something differs**
>
> - If Codex proposes staging, editing, or committing, repeat the request and
>   keep it read-only.
> - If its summary describes a setting or behavior you did not intend, trust
>   the diff and the tested result over the summary, then fix the code before
>   committing.
> - If an expected file is missing, or an unexplained file appears, inspect it
>   before continuing. Never add a file merely to make the change list empty.

### Part 3: Commit through the Git controls, then verify

1. In the Review tab, stage only the Module 3 project files you understand.
2. Open the controls menu at the top right of the task and select **Commit or
   push**.
3. Enter Codex's proposed message, confirm that it begins with `Build Module
   3`, then create a **local commit**. Do not push.
4. Open the Review tab again and confirm that no uncommitted Module 3 project
   changes remain.
5. In Codex's integrated terminal, run:

   ```powershell
   git status
   git log --oneline -1
   git show --stat --oneline -1
   ```

6. Confirm that the working tree is clean, the latest commit starts with
   `Build Module 3`, and its file list matches the files you reviewed.

If the AI review is unavailable but the Codex Git controls still work, inspect
the Review tab yourself, use a concise commit message beginning with `Build
Module 3`, and run the same verification commands. If the Codex app is
unavailable altogether, do the same work in any terminal opened in the project
folder, using the commands from Lesson 0.4:

```powershell
git status
git add <each file you reviewed>
git status
git commit -m "Build Module 3 ..."
```

Check `git status` before committing, as the second line above does, then run
the same verification commands from step 5.

## Learner exercise

Without creating another commit:

1. Use `git show --stat --oneline -1` to identify the checkpoint message and
   its files.
2. Name which setting you would change to make the Player reach full speed
   sooner, and which one to make a late jump after a ledge more forgiving.
3. Explain why the eight movement settings live in `player.gd` rather than in
   `main.tscn`, and what would have to change for one Player instance in a
   scene to move faster than another.

## Verification checklist

- [ ] Acceleration, deceleration, reversal, gravity, landing, and maximum speed
      work before the checkpoint.
- [ ] Grounded jumping, coyote time, jump buffering, and variable jump height
      work before the checkpoint.
- [ ] The eight Inspector settings show their validated defaults, with no value
      left at an exercise setting.
- [ ] Configured controller behavior works when compatible hardware is
      available.
- [ ] Codex's request only reviewed and described the proposed checkpoint, and
      asked it nothing it could not know.
- [ ] Codex's list of exported defaults was compared against the Part 1 table
      by the learner, not taken on trust.
- [ ] The Review tab was checked before staging and committing.
- [ ] The checkpoint contains only understood Module 3 project changes.
- [ ] Any change to `actors/player.tscn` was inspected and contains no altered
      movement value.
- [ ] The learner used **Commit or push** to create a local commit and did not
      push.
- [ ] The latest commit message begins with `Build Module 3`.
- [ ] `git status` reports a clean working tree afterward.
- [ ] The learner can name which setting controls acceleration and which
      controls the jump grace period.

## References

- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
- [Record changes with Git](https://git-scm.com/book/en/v2/Git-Basics/Recording-Changes-to-the-Repository)
