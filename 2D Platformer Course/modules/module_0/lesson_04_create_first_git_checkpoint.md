# Module 0, Lesson 4: Connect the Existing Project to Codex and Create the First Git Checkpoint

**Status:** Validated

## By the end

Connect Codex to the Godot project folder created in Lesson 0.2, then make
that existing project's first clean local Git checkpoint on `main`. This starts
the review cycle used throughout the course; it does not create another Godot
project.

- Codex opens the folder containing `project.godot`.
- The folder is a local Git repository on `main`.
- Generated Godot files are excluded from Git.
- Codex first reviews the checkpoint without changing it.
- The learner reviews the changes, then creates the checkpoint.
- `git status` reports a clean working tree afterward.

## Before you start

- Module 0, Lessons 1 through 3 are complete.
- Codex opens with the Windows-native agent and **Ask for approval** selected.
- Git has the intended author identity and `main` default branch.
- The `2D Platformer` project opens without errors.
- The project folder is not already inside another Git repository.

## Build steps

> 💡 The **Godot project** already exists because you created it in Lesson
> 0.2. Adding a **local project** to Codex only associates Codex with that
> existing folder. It does not create, duplicate, or move the Godot project.

### Part 1: Prepare the project for Git

1. Open the `2D Platformer` project in Godot.
2. Open **Project → Version Control → Create/Override Version Control
   Metadata…**.
3. Confirm that **Git** is selected, then click **OK**.
4. In Godot's FileSystem dock, right-click `res://` and select **Open in File
   Explorer**.
5. Confirm that `.gitignore` and `.gitattributes` exist in the project folder.
6. Open `.gitignore` and confirm that it contains:

   ```gitignore
   .godot/
   /android/
   ```

   > 💡 An **ignored file** is intentionally left out of Git history. `.godot/`
   > is Godot's generated editor cache, so Git should not record it.

7. Close the text editor and Godot.

> ⚠️ **If something differs**
>
> - If `.godot/` is not ignored, stop before creating a checkpoint and correct
>   `.gitignore`.
> - Godot's generated metadata can vary between versions. Do not add old rules
>   from memory.

### Part 2: Connect the existing folder to Codex

1. Open Codex in the ChatGPT desktop app.
2. In the sidebar's project area, add an existing local project.
3. Select the `2D Platformer` folder that contains `project.godot`.
4. Confirm that Codex shows `2D Platformer` as the current project, then start
   a local task for it.

   > 💡 A Codex **project** gives Codex the intended folder as working context.
   > Check for `project.godot` whenever you need to confirm that it is the same
   > Godot project you created in Lesson 0.2.

> ⚠️ **If something differs**
>
> - If `project.godot` is missing, choose the Godot project folder, not its
>   parent folder or the generated `.godot` folder.

### Part 3: Initialize Git and inspect its starting state

1. Open Codex's integrated terminal for the local project.
2. Confirm that its path is the folder containing `project.godot`.
3. Initialize the repository on `main`:

   ```powershell
   git init -b main
   ```

4. Inspect the starting state:

   ```powershell
   git status
   ```

   > 💡 A **repository** is a project folder whose history Git manages. The
   > **working tree** is its current files. At this point, the project files
   > are **untracked**: Git can see them, but has not been asked to save them
   > in a checkpoint yet.

5. Confirm that Git reports `main`, lists the expected project files as
   untracked, and does not list `.godot/`.

> ⚠️ **If something differs**
>
> - If the terminal is in the wrong folder, do not initialize Git. Return to
>   Part 2 and connect the folder containing `project.godot`.

### Part 4: Review, commit, and verify

1. Send Codex this prompt:

   > Inspect the Git status of this project and explain which files belong in
   > the first checkpoint and which generated files should remain ignored. Do
   > not change any files, stage anything, or create a commit.

   > 💡 A **read-only request** asks Codex to inspect or explain without making
   > changes. Stating what Codex must not do keeps the first task small and
   > easy to review.

2. At the top right of the task, open the controls menu (the sliders icon) and
   select **Changes**. Codex opens the changed-file diff in a **Review** tab.
3. Compare Codex's explanation with `.gitignore` and the Review tab.
4. Confirm that the project files, `.gitignore`, and `.gitattributes` should be
   included, while the internal `.git/` directory, generated `.godot/` files,
   and confidential data should not.
5. If Codex's explanation is incomplete or incorrect, tell it what differs and
   ask it to inspect again without making changes.
6. In the Review tab, stage the intended files and review the staged diff.

   > 💡 The **staging area** is the reviewed set of changes prepared for the
   > next snapshot. A **commit** is the named snapshot Git records from that
   > set. Staging does not upload or commit anything yet.

7. Confirm that generated files and confidential data are not staged.
8. At the top right of the task, open the controls menu (the sliders icon) and
   select **Commit or push**.
9. Create a **local commit** with this message:

   ```text
   Checkpoint empty Godot project
   ```

   The menu combines two different Git actions. A **commit** saves the
   reviewed snapshot in this folder; a **push** would send it to a remote
   repository. This course has not connected a remote repository yet, so
   create the local commit and do not push.

10. Return to the integrated terminal and run:

   ```powershell
   git status
   git log --oneline -1
   ```

11. Confirm that the working tree is clean and the latest commit message is
   `Checkpoint empty Godot project`.

Use this cycle for future working results: inspect → stage intended changes →
review → commit → verify. Never commit passwords, tokens, private keys, or
export credentials.

> ⚠️ **If something differs**
>
> - If Codex changed or staged anything before you reviewed it, reopen the
>   Review tab through the controls menu's **Changes** option. Do not discard
>   or commit changes you cannot identify.
> - If the working tree is not clean afterward, inspect what was left out; do
>   not discard it automatically.

## Learner exercise

Without repeating the build steps:

1. Run `git status` and identify the branch.
2. Run `git log --oneline -1` and locate the checkpoint message.
3. Explain untracked, ignored, staged, and committed files.
4. Explain why `.godot/` is ignored.
5. Explain the difference between creating the Godot project in Lesson 0.2 and
   connecting its existing folder to Codex in this lesson.

## Verification checklist

- [ ] Codex is connected to the folder containing `project.godot`.
- [ ] No second Godot project or duplicate project folder was created.
- [ ] The repository root is the folder containing `project.godot`.
- [ ] The active branch is `main`.
- [ ] `.gitignore` excludes `.godot/`.
- [ ] Codex's first task only inspected and explained the proposed checkpoint.
- [ ] Generated cache and confidential data are not staged.
- [ ] The learner used **Commit or push** to create the local commit and did
      not push.
- [ ] The latest commit message is `Checkpoint empty Godot project`.
- [ ] `git status` reports a clean working tree.
- [ ] The learner can explain repository, staging area, commit, tracked,
      untracked, and ignored files.

## References

- [Codex local environments](https://learn.chatgpt.com/docs/environments/local-environment)
- [Codex best practices](https://learn.chatgpt.com/guides/best-practices)
- [Initialize a Git repository](https://git-scm.com/book/en/v2/Git-Basics/Getting-a-Git-Repository)
- [Record changes with Git](https://git-scm.com/book/en/v2/Git-Basics/Recording-Changes-to-the-Repository)
- [Godot version-control guidance](https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html)
