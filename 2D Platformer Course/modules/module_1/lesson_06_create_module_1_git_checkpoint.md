# Module 1, Lesson 6: Create a Module 1 Git Checkpoint

**Status:** Implemented

## By the end

Create a tested Git checkpoint for the completed Module 1 scene foundations and
send it to your private GitHub repository.

- The Module 1 scene changes are recorded in one new commit on `main`.
- That commit is on GitHub as well as on this computer.
- The **Changes** tab is empty afterward.

## Before you start

- Module 1, Lessons 1 through 5 are complete.
- The Module 0 checkpoint exists, and GitHub Desktop shows `2D Platformer` as
  the current repository.
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

### Part 2: Review the changes in GitHub Desktop

1. Open GitHub Desktop and select the **Changes** tab.
2. Confirm that the list contains only these three files:

   - `project.godot`, which records `main.tscn` as the project's main scene
     and the viewport size and stretch settings from Lesson 1.2.
   - `scenes/main.tscn`, which stores `Main`, its Label, and the icon
     instance.
   - `scenes/project_icon.tscn`, which stores the reusable icon scene.

3. Select `project.godot` and read its diff.

> 💡 A **UID** is a stable identifier Godot assigns to each file. It looks
> like `uid://` followed by a short code, and it is unique to your project.
> Godot records the main scene by its UID instead of its file path, so the
> reference keeps working if the file is later renamed or moved. That is why
> the diff shows a `uid://` value rather than `main.tscn`.

4. Select each remaining file and confirm you can explain why it changed.
   Course notes, generated `.godot/` files, credentials, or any change you
   cannot explain do not belong in this checkpoint.

> ⚠️ **If something differs**
>
> - If an expected file is missing or an unexpected file appears, inspect it
>   before continuing. Do not use a checkpoint to hide an unexplained change.
> - If `.godot/` files appear, add `.godot/` to `.gitignore` in the project
>   folder before committing.

### Part 3: Ask Codex to describe the new scenes (optional)

If you do not use Codex, continue at Part 4. Nothing later in the course
depends on this part.

1. In the Codex task for this project, send this prompt:

   `Describe what scenes/main.tscn and scenes/project_icon.tscn contain, node`
   `by node. Do not change, create, or delete any file.`

2. Read the description and compare it with the scenes you built.

> 💡 Codex describes; you decide. It can read these files, but it has never
> seen the lessons and does not know what Module 1 asked for, so a mismatch
> between its description and what you intended is yours to spot.

### Part 4: Commit and push

1. Return to the **Changes** tab.
2. In the **Summary** field, enter:

   `Build Module 1 scene foundations`

   Leave **Description** empty. A summary naming the finished result is enough
   for this checkpoint.
3. Select **Commit to main**.
4. Confirm that the **Changes** tab is now empty and that the commit appears
   under **History**.
5. At the top of the window, select **Push origin**.

> 💡 The commit you just made exists only on this computer. **Push origin**
> sends it to your private GitHub repository, so a lost or broken machine
> cannot take the checkpoint with it. Every later checkpoint ends the same
> way.

6. Confirm that **Push origin** no longer offers anything to send.

> ⚠️ **If something differs**
>
> - If **Commit to main** is unavailable, confirm that **Summary** is filled
>   and that all three files are checked.
> - If pushing fails, confirm that GitHub Desktop is still signed in to the
>   account from Lesson 0.1.

## Learner exercise

Without creating another commit:

1. Open the **History** tab and select the checkpoint.
2. Identify its summary and the files it contains.
3. Explain why testing comes before reviewing, and reviewing before
   committing.
4. Explain why a generated file or an unexplained change should not be added
   merely to empty the **Changes** tab.

## Verification checklist

- [ ] Running the project before the checkpoint displays `Project ready` and
    one upright project icon without related errors or warnings.
- [ ] The changed-file list was read before the commit was created.
- [ ] The checkpoint contains only the three understood Module 1 files.
- [ ] The latest commit summary is `Build Module 1 scene foundations`.
- [ ] The **Changes** tab is empty afterward.
- [ ] The commit is on GitHub as well as on this computer.
- [ ] The learner can explain why each module ends with one tested checkpoint.
- [ ] The learner can explain the difference between a commit and a push.

## References

- [Commit and review changes in GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop)
- [Push changes to GitHub from GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/pushing-changes-to-github-from-github-desktop)
