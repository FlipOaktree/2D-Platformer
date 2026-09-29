# Module 3, Lesson 6: Create a Module 3 Git Checkpoint

**Status:** Implemented

## By the end

Create one tested Git checkpoint for the completed responsive controller and
send it to your private GitHub repository. Module 3 changed a single script
heavily rather than adding many files, so the review focuses on whether the
settings and the interacting jump timers are the ones you meant to keep.

- A tested controller: it accelerates, decelerates, and jumps three ways.
- The eight settings checked against their tuned defaults before anything is
  saved, since every Module 3 exercise changed one and put it back.
- One commit holding Module 3's work, and a copy of it on GitHub.

## Before you start

- Module 3, Lessons 1 through 5 are complete and validated.
- The Module 2 checkpoint exists, and GitHub Desktop shows `2D Platformer` as
  the current repository.
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

### Part 2: Review the changes in GitHub Desktop

1. Open GitHub Desktop and select the **Changes** tab.
2. Confirm that the list is limited to these expected files:

   - `actors/player.gd`, with the eight exported settings, the two runtime
     countdowns, and the acceleration, coyote-time, jump-buffer, and
     jump-shortening logic.
   - `scenes/main.tscn`, with the raised `CoyoteTestPlatform` and its
     collision shape.
   - `actors/player.tscn` may show a small change that you did not type, or no
     change at all. Saving a scene lets Godot write its own bookkeeping
     attributes. Confirm that it contains no changed movement value before
     accepting it.

3. Select `actors/player.gd` and read its diff. Confirm that every exported
   default in it matches the table from Part 1.
4. Select each remaining file and confirm you can explain why it changed.
   Generated `.godot/` files, credentials, course notes, and any change you
   cannot explain do not belong in the checkpoint.

> ⚠️ **If something differs**
>
> - If a default in the diff does not match the table, fix it in the script,
>   save, and run the scene again before committing.
> - If an expected file is missing, or an unexplained file appears, inspect it
>   before continuing. Never add a file merely to empty the change list.

### Part 3: Ask Codex to list the exported settings (optional)

If you do not use Codex, continue at Part 4. Nothing later in the course
depends on this part.

1. In the Codex task for this project, send this prompt:

   `List every exported setting in actors/player.gd with its default value,`
   `then describe how the coyote-time, jump-buffer, and jump-shortening logic`
   `work together. Do not change, create, or delete any file.`

2. Compare its list against the table in Part 1, row by row.

> 💡 Codex is asked to list the defaults, not to approve them, and the
> difference matters. It can read your code but has never seen a lesson, so it
> has no idea what the course said a value should be. Asked to confirm a match
> it cannot check, it would very likely confirm one anyway. The comparison is
> yours to make, and it is the whole reason for asking.

### Part 4: Commit and push

1. Return to the **Changes** tab.
2. In the **Summary** field, enter:

   `Build Module 3 responsive movement`

   Leave **Description** empty.
3. Select **Commit to main**.
4. Confirm that the **Changes** tab is now empty and that the commit appears
   under **History**.
5. At the top of the window, select **Push origin**.
6. Confirm that **Push origin** no longer offers anything to send.

> ⚠️ **If something differs**
>
> - If **Commit to main** is unavailable, confirm that **Summary** is filled
>   and that every expected file is checked.
> - If pushing fails, confirm that GitHub Desktop is still signed in to the
>   account from Lesson 0.1.

## Learner exercise

Without creating another commit:

1. Open the **History** tab and select the checkpoint to see its files.
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
- [ ] The changed-file list was read before the commit was created.
- [ ] The checkpoint contains only understood Module 3 project changes.
- [ ] Any change to `actors/player.tscn` was inspected and contains no altered
      movement value.
- [ ] The latest commit summary is `Build Module 3 responsive movement`.
- [ ] The **Changes** tab is empty afterward.
- [ ] The commit is on GitHub as well as on this computer.
- [ ] The learner can name which setting controls acceleration and which
      controls the jump grace period.

## References

- [Commit and review changes in GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop)
- [Push changes to GitHub from GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/pushing-changes-to-github-from-github-desktop)
- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
