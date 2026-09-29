# Module 2, Lesson 12: Create a Module 2 Git Checkpoint

**Status:** Implemented

## By the end

Create one tested Git checkpoint for the completed Player foundation and send
it to your private GitHub repository. More files changed than in Module 1, so
the review is the part that deserves your time.

- Testing the Player: it runs, falls, lands, and jumps only from the floor
- Recording Module 2's work in one commit and nothing else
- Copying that commit to GitHub
- Practising how to read a change list that is too big to skim

## Before you start

- Module 2, Lessons 1 through 11 are complete.
- The Module 1 checkpoint exists, and GitHub Desktop shows `2D Platformer` as
  the current repository.
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

### Part 2: Review the changes in GitHub Desktop

1. Open GitHub Desktop and select the **Changes** tab.
2. Confirm that the list is limited to these expected files:

   - `project.godot`, with the input actions and their events.
   - `actors/actor.tscn`, with the reusable Actor structure.
   - `actors/player.tscn` and `actors/player.gd`, with the Player scene and
     movement script.
   - `scenes/main.tscn`, with the Player instance and floor collision.

3. Select `actors/player.gd` and read its diff. Confirm that every line you
   see is one you wrote during Module 2.
4. Select each remaining file and confirm you can explain why it changed.
   Generated `.godot/` files, credentials, course notes, and any change you
   cannot explain do not belong in the checkpoint.

> ⚠️ **If something differs**
>
> - If an expected file is missing, or an unexplained file appears, inspect it
>   before continuing. Never add a file merely to empty the change list.
> - If `.godot/` files appear, add `.godot/` to `.gitignore` in the project
>   folder before committing.

### Part 3: Ask Codex to summarize the Player foundation (optional)

If you do not use Codex, continue at Part 4. Nothing later in the course
depends on this part.

1. In the Codex task for this project, send this prompt:

   `Summarize what actors/player.gd does, function by function, and describe`
   `how actors/player.tscn and actors/actor.tscn are structured. Do not`
   `change, create, or delete any file.`

2. Read the summary and compare it with the behavior you tested in Part 1.

> 💡 Several related files changed this module, so a second description can
> help you notice a piece you forgot. Codex has never seen the lessons, so it
> can tell you what the code does but not whether it is what Module 2 asked
> for. That comparison is yours.

### Part 4: Commit and push

1. Return to the **Changes** tab.
2. In the **Summary** field, enter:

   `Build Module 2 Player foundation`

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
2. Name one Player behavior that lives in `player.gd` and one scene detail
   that lives in `main.tscn`.
3. Explain why a larger change list makes the review step more valuable, not
   less.

## Verification checklist

- [ ] Keyboard movement, falling, floor collision, and grounded jumping work
      before the checkpoint.
- [ ] Configured controller behavior works when compatible hardware is
      available.
- [ ] The changed-file list was read before the commit was created.
- [ ] The checkpoint contains only understood Module 2 project changes.
- [ ] The latest commit summary is `Build Module 2 Player foundation`.
- [ ] The **Changes** tab is empty afterward.
- [ ] The commit is on GitHub as well as on this computer.

## References

- [Commit and review changes in GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop)
- [Push changes to GitHub from GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/pushing-changes-to-github-from-github-desktop)
