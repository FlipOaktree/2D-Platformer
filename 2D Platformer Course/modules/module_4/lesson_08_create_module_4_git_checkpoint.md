# Module 4, Lesson 8: Create a Module 4 Git Checkpoint

**Status:** Blueprint drafted

## By the end

Create one tested local Git checkpoint for the completed level system. Module 4
added more new files than any module before it, and every lesson ended with an
exercise that changed something and then put it back. The review is mostly
about whether everything really was put back.

- The level still plays as Lesson 7 left it, and every saved value is the one
  you meant to keep rather than one an exercise left behind.
- The tile set, the two levels, the moving platform, and the two new scripts
  are all present and understood.
- The reviewed Module 4 changes are recorded in one new local commit on `main`.

## Before you start

- Module 4, Lessons 1 through 7 are complete and validated.
- The Module 3 checkpoint exists and `git status` was clean before Module 4
  work began.
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

### Part 2: Use Codex to review the Module 4 diff

1. In the Codex task for this project, send this prompt:

   > Review the uncommitted changes from Module 4. Summarize the level system
   > they add, and describe what each new script does, function by function.
   > Flag anything that does not belong in this checkpoint, and propose one
   > concise commit message beginning with `Build Module 4`. Do not edit,
   > stage, or commit anything.

2. Read Codex's summary, then open the controls menu at the top right of the
   task and select **Changes**. Codex opens the changed-file diff in a
   **Review** tab.
3. Compare the Review tab with Codex's summary.
4. Confirm that the Module 4 project changes are limited to these expected
   files:

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

   Generated `.godot/` files, credentials, course notes, and any change you
   cannot explain do not belong in the checkpoint.

   > 💡 Codex is describing, not checking. It was connected to the folder
   > holding `project.godot` in Lesson 0.4, so it can read your code but has
   > never seen a lesson. Asking it whether the code matches the course would
   > invite an answer it has no way to arrive at. Comparing its description
   > with what you built is your job, and it is the reason the description is
   > worth asking for.

   > 💡 This is the largest change list in the course so far, and the useful
   > question is not "did anything change" but "did anything change that no
   > lesson asked for". `actors/player.gd` is the one to look at hardest: it
   > should show a single added function and nothing else. If a movement value
   > differs, an exercise from Module 3 was never put back.

> ⚠️ **If something differs**
>
> - If Codex proposes staging, editing, or committing, repeat the request and
>   keep it read-only.
> - If its summary describes a file or behaviour you did not build, trust the
>   diff and the tested result over the summary, then fix the project before
>   committing.
> - If an expected file is missing, or an unexplained file appears, inspect it
>   before continuing. Never add a file merely to make the change list empty.
> - If `project.godot` appears, open it. No Module 4 lesson changes it, so
>   something else did.

### Part 3: Commit through the Git controls, then verify

1. In the Review tab, stage only the Module 4 project files you understand.
2. Open the controls menu at the top right of the task and select **Commit or
   push**.
3. Enter Codex's proposed message, confirm that it begins with `Build Module
   4`, then create a **local commit**. Do not push.
4. Open the Review tab again and confirm that no uncommitted Module 4 project
   changes remain.
5. In Codex's integrated terminal, run:

   ```powershell
   git status
   git log --oneline -1
   git show --stat --oneline -1
   ```

6. Confirm that the working tree is clean, the latest commit starts with
   `Build Module 4`, and its file list matches the files you reviewed.

If the AI review is unavailable but the Codex Git controls still work, inspect
the Review tab yourself, use a concise commit message beginning with `Build
Module 4`, and run the same verification commands. If the Codex app is
unavailable altogether, do the same work in any terminal opened in the project
folder, using the commands from Lesson 0.4:

```powershell
git status
git add <each file you reviewed>
git status
git commit -m "Build Module 4 ..."
```

Check `git status` before committing, as the second line above does, then run
the same verification commands from step 5.

## Learner exercise

Without creating another commit:

1. Use `git show --stat --oneline -1` to identify the checkpoint message and
   its files.
2. Name the one file you would open to change where the Player starts, the one
   you would open to change how fast the platform moves, and the one you would
   open to change what happens when the Player falls.
3. Explain why `main.gd` never mentions `PlayerSpawn` or `FallLimit`, and what
   that buys you when a second level is added.
4. Name what a new level file has to contain before it can be swapped into
   `main.tscn`, and explain how you would find out if you forgot part of it.
5. Codex described your scripts without ever seeing a lesson. Name one thing
   it could not have checked, and say how you checked it instead.

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
- [ ] Codex's request only reviewed and described the proposed checkpoint, and
      asked it nothing it could not know.
- [ ] The Review tab was checked before staging and committing.
- [ ] The checkpoint contains only understood Module 4 project changes.
- [ ] `actors/player.gd` shows one added function and no changed movement
      value.
- [ ] `project.godot` is not part of the checkpoint.
- [ ] The `.uid` files beside the new scripts are included.
- [ ] The learner used **Commit or push** to create a local commit and did not
      push.
- [ ] The latest commit message begins with `Build Module 4`.
- [ ] `git status` reports a clean working tree afterward.
- [ ] The learner can name what a level file owes the script it shares.

## References

- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
- [Record changes with Git](https://git-scm.com/book/en/v2/Git-Basics/Recording-Changes-to-the-Repository)
