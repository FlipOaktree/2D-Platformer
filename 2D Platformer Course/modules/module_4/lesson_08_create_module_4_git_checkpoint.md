# Module 4, Lesson 8: Create a Module 4 Git Checkpoint

**Status:** Implemented

## Lesson goals

Create one tested Git checkpoint for the completed level system and send it to
your private GitHub repository. Module 4 added more new files than any module
before it, and every lesson ended with an exercise that changed something and
then put it back. The review is mostly about whether everything really was put
back.

- Confirming the level still plays as Lesson 7 left it, and that every saved
  value is the one you meant to keep rather than one an exercise left behind
- Checking that the tile set, the two levels, the moving platform, and the two
  new scripts are all present and understood
- Recording Module 4's work in one commit and copying it to GitHub

## Before you start

- Module 4, Lessons 1 through 7 are complete.
- The Module 3 checkpoint exists, and GitHub Desktop shows `2D Platformer` as
  the current repository.
- `main.tscn` holds `Level` first and `Player` second, with `level_1.tscn` at
  Position `(0, 0)`.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Confirm nothing drifted

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Play through once and confirm nothing behaves differently from the end of
   Lesson 7.
3. Stop the scene with `F8`.
4. Check the four values a Module 4 exercise asked you to put back:

   | Thing | Expected |
   | --- | --- |
   | `PlayerSpawn` Position | `(256, 896)` |
   | `FallLimit` Position | `(960, 1216)` |
   | `Terrain` painted cells | 64, with the pit three tiles wide |
   | `Level` instance in `main.tscn` | Position `(0, 0)` |

5. If anything does not match, put it back, save, and run once more.

> 💡 Lesson 7 already tested this level, so this is a last look rather than a
> second test. The table is the real work. Each of those four was moved,
> widened or swapped by an exercise and then restored, and a value left at its
> experiment setting is far harder to notice than a feature that stopped
> working. Module 5 begins adding a camera and character visuals, so this is
> the last point where the level itself is the only thing that can be wrong.

> ⚠️ **If something differs**
>
> - If any behaviour does not work, return to the relevant Module 4 lesson
>   before creating a checkpoint. Do not commit a result you have not tested.
> - A controller is optional for this checkpoint. It is enough to verify the
>   configured controller inputs when compatible hardware is available.

### Part 2: Review the changes in GitHub Desktop

1. Open GitHub Desktop and select the **Changes** tab.
2. Confirm that the list is limited to these expected files:

   - `levels/tiles/terrain.png` and `levels/tiles/terrain.png.import`, the tile
     artwork and the settings Godot wrote when it imported it.
   - `levels/tiles/terrain_tileset.tres`, with 47 tiles, their collision, the
     `Ground` and `Platform` terrains, and the three one-way alternatives.
   - `levels/level_1.tscn` and `levels/level_2.tscn`, the two level scenes.
   - `levels/level.gd`, which answers where the Player starts and how far down
     it may go.
   - `levels/moving_platform.tscn` and `levels/moving_platform.gd`, the
     reusable moving surface.
   - `scenes/main.gd`, the orchestrator that places the Player and watches for
     the fall.
   - `scenes/main.tscn`, which lost the temporary `Floor` and
     `CoyoteTestPlatform`, gained the `Level` instance and the script, and now
     lists `Level` before `Player`.
   - `actors/player.gd`, with one addition: `respawn_at()`.
   - A small `.uid` file beside each new script. Godot writes these itself to
     keep track of a script when it is renamed or moved. They belong in the
     checkpoint.

3. Select `actors/player.gd` and read its diff. It should show a single added
   function and nothing else. If a movement value differs, an exercise from
   Module 3 was never put back.

> 💡 This is the largest change list in the course so far, and the useful
> question is not "did anything change" but "did anything change that no
> lesson asked for".

4. Select each remaining file and confirm you can explain why it changed.
   Generated `.godot/` files, credentials, course notes, and any change you
   cannot explain do not belong in the checkpoint.

> ⚠️ **If something differs**
>
> - If an expected file is missing, or an unexplained file appears, inspect it
>   before continuing. Never add a file merely to empty the change list.
> - If `project.godot` appears, open it. No Module 4 lesson changes it, so
>   something else did.

### `Optional` Part 3: Ask Codex to describe the new scripts

If you do not use Codex, continue at Part 4. Nothing later in the course
depends on this part.

1. In the Codex task for this project, send this prompt:

   `Describe what levels/level.gd, levels/moving_platform.gd and`
   `scenes/main.gd do, function by function. Do not change, create, or delete`
   `any file.`

2. Read each description and compare it with what you built.

> 💡 Codex is describing, not checking. It can read your code but has never
> seen a lesson, so asking it whether the code matches the course would invite
> an answer it has no way to arrive at. Comparing its description with what
> you built is your job, and it is the reason the description is worth asking
> for.

### Part 4: Commit and push

1. Return to the **Changes** tab.
2. In the **Summary** field, enter:

   `Build Module 4 modular level system`

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
2. Name the one file you would open to change where the Player starts, the one
   you would open to change how fast the platform moves, and the one you would
   open to change what happens when the Player falls.
3. Explain why `main.gd` never mentions `PlayerSpawn` or `FallLimit`, and what
   that buys you when a second level is added.
4. Name what a new level file has to contain before it can be swapped into
   `main.tscn`, and explain how you would find out if you forgot part of it.

## Verification checklist

- [ ] The level plays as it did at the end of Lesson 7, with nothing behaving
      differently.
- [ ] The four values in Part 1 match, with none left at an exercise setting.
- [ ] `level_2.tscn` still has `level.gd`, a `PlayerSpawn`, and a `FallLimit`,
      as Lesson 7, Part 6 left it.
- [ ] `main.tscn` ends the module holding `level_1.tscn` at Position `(0, 0)`,
      listed before the Player.
- [ ] Configured controller behavior works when compatible hardware is
      available.
- [ ] The changed-file list was read before the commit was created.
- [ ] The checkpoint contains only understood Module 4 project changes.
- [ ] `actors/player.gd` shows one added function and no changed movement
      value.
- [ ] `project.godot` is not part of the checkpoint.
- [ ] The `.uid` files beside the new scripts are included.
- [ ] The latest commit summary is `Build Module 4 modular level system`.
- [ ] The **Changes** tab is empty afterward.
- [ ] The commit is on GitHub as well as on this computer.
- [ ] The learner can name what a level file owes the script it shares.

## References

- [Commit and review changes in GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop)
- [Push changes to GitHub from GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/pushing-changes-to-github-from-github-desktop)
- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
