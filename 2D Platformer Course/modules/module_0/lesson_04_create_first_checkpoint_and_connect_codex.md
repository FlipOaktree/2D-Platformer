# Module 0, Lesson 4: Create the First Git Checkpoint and Connect Codex

**Status:** Implemented

## By the end

Turn the Godot project folder created in Lesson 0.2 into a Git repository, save
its first checkpoint through GitHub Desktop, back that checkpoint up to a
private GitHub repository, then connect the same folder to Codex. This does not
create another Godot project.

- The project folder is a Git repository on `main`.
- Generated Godot files are excluded from Git.
- The first commit contains only reviewed project files.
- A private GitHub repository holds a copy of that commit.
- Codex opens the folder containing `project.godot`.

## Before you start

- Module 0, Lessons 1 through 3 are complete.
- GitHub Desktop is installed and signed in to a GitHub account.
- Codex opens with the Windows-native agent and **Ask for approval** selected.
- Git has the intended author identity and `main` default branch.
- The `2D Platformer` project opens without errors.
- The project folder is not already inside another Git repository.

## Build steps

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

   An ignored file is intentionally left out of Git history. Not everything in
   the project folder is part of the project. Some of it is yours: scenes,
   scripts, images, and Git follows those. The rest is what the editor creates
   for its own use, and it comes back by itself if deleted, so tracking it
   would only bury the changes that matter.
7. Close the text editor and Godot.

> ⚠️ **If something differs**
>
> - If `.godot/` is not ignored, stop before creating a checkpoint and correct
>   `.gitignore`.
> - Godot's generated metadata can vary between versions. Do not add old rules
>   from memory.

### Part 2: Create the repository in GitHub Desktop

> 💡 A **repository** is a project folder whose history Git manages. Right now
> the project files are **untracked**: they sit in the folder, but Git has not
> been asked to save any of them yet.

1. Open GitHub Desktop.
2. Open **File → Add local repository**.
3. Select **Choose…**, then select the `2D Platformer` folder that contains
   `project.godot`.
4. GitHub Desktop reports that this folder is not yet a Git repository and
   offers to create one. Accept that offer.
5. Confirm that GitHub Desktop shows `2D Platformer` as the current repository
   and `main` as the current branch.

> ⚠️ **If something differs**
>
> - If GitHub Desktop does not offer to create a repository, close the dialog
>   and open **Repository → Create a New Repository on your Hard Drive…**. Set
>   **Local path** to the folder that contains the `2D Platformer` folder and
>   **Name** to `2D Platformer`, leave the README, Git ignore, and License
>   options untouched, then select **Create repository**.
> - If the current branch is not `main`, open the branch menu at the top of the
>   window and rename the branch to `main`.

### Part 3: Review the changes, then commit

1. In the left sidebar, select the **Changes** tab.
2. Read the file list. Confirm that it contains the Godot project files,
   `.gitignore`, and `.gitattributes`, and that no `.godot/` file appears.
3. Select a file to see its **diff** on the right.

> 💡 A **diff** is a line-by-line comparison showing exactly what changed
> between two versions of a file. Added and removed lines are marked, so you
> can review a change without reading the whole file.

4. Confirm that nothing in the list is a password, token, private key, or
   export credential. Never commit a list you have not read: a commit records
   what was in the list, not what you meant to put there.
5. In the **Summary** field beneath the file list, enter:

   `Checkpoint empty Godot project`

   Leave **Description** empty. A summary naming the finished result is enough
   for this checkpoint.
6. Select **Commit to main**.
7. Confirm that the **Changes** tab is now empty and that the commit appears
   under **History**.

> ⚠️ **If something differs**
>
> - If `.godot/` files appear in the list, stop and correct `.gitignore` as in
>   Part 1 before committing.
> - If **Commit to main** is unavailable, confirm that **Summary** is filled
>   and that at least one file is checked.

### Part 4: Back the checkpoint up to a private GitHub repository

> 💡 A **remote** is a copy of the repository kept elsewhere, here on GitHub.
> Committing saves a version on this computer; **publishing** and **pushing**
> send it to the remote, so the work survives losing the machine. This
> repository stays private for the whole build; Module 17 makes it public when
> the finished game is packaged.

1. Open **Repository → Publish repository**.
2. Read the **Name** field and leave it as offered. A GitHub repository name
   cannot contain a space, so it may differ slightly from the folder name.
3. Confirm that **Keep this code private** is checked. Do not uncheck it.
4. Select **Publish Repository**.
5. Open your repositories on GitHub in a browser and confirm that the
   repository is listed as private and contains the checkpoint.

> ⚠️ **If something differs**
>
> - If the repository was published publicly, open its settings on GitHub and
>   change its visibility to private.
> - If publishing fails, confirm in GitHub Desktop's options that the GitHub
>   account from Lesson 0.1 is still signed in.

### Part 5: Connect the project folder to Codex

The Godot project already exists because you created it in Lesson 0.2. Adding a
local project to Codex only associates Codex with that existing folder. It does
not create, duplicate, or move the Godot project, and it does not touch Git.

1. Open Codex in the ChatGPT desktop app.
2. In the sidebar's project area, add an existing local project.
3. Select the `2D Platformer` folder that contains `project.godot`. If
   `project.godot` is missing, you have chosen the parent folder or the
   generated `.godot` folder rather than the project folder.
4. Confirm that Codex shows `2D Platformer` as the current project, then start
   a local task for it.
5. Send Codex this prompt:

   `List the files in this project and describe what each one is for. Do not`
   `change, create, or delete any file.`

6. Read the answer and compare it with the file list you reviewed in Part 3.

> 💡 Stating what Codex must not do keeps a first task small and easy to check.
> Codex reads and explains files in this course; GitHub Desktop is what saves
> versions of them.

Use this cycle for every later checkpoint: test the result, read the changed
file list, commit with a clear summary, then push.

## Learner exercise

Without repeating the build steps:

1. Open the **History** tab and locate the checkpoint.
2. Explain untracked, ignored, and committed files.
3. Explain why `.godot/` is ignored.
4. Explain the difference between a commit and a push.
5. Explain the difference between creating the Godot project in Lesson 0.2 and
   connecting its existing folder to Codex in this lesson.

## Verification checklist

- [ ] The repository root is the folder containing `project.godot`.
- [ ] The active branch is `main`.
- [ ] `.gitignore` excludes `.godot/`.
- [ ] The learner read the changed-file list and one diff before committing.
- [ ] Generated cache and confidential data are not committed.
- [ ] The latest commit summary is `Checkpoint empty Godot project`.
- [ ] The **Changes** tab is empty after the commit.
- [ ] A GitHub repository holds the checkpoint and is private.
- [ ] Codex is connected to the folder containing `project.godot`.
- [ ] No second Godot project or duplicate project folder was created.
- [ ] Codex's first task only listed and described files.
- [ ] The learner can explain repository, diff, commit, remote, untracked, and
      ignored files.
- [ ] The learner can explain the difference between a commit and a push.

## References

- [Add a local repository to GitHub Desktop](https://docs.github.com/en/desktop/adding-and-cloning-repositories/adding-a-repository-from-your-local-computer-to-github-desktop)
- [Commit and review changes in GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop)
- [Create your first repository with GitHub Desktop](https://docs.github.com/en/desktop/overview/creating-your-first-repository-using-github-desktop)
- [Codex local environments](https://learn.chatgpt.com/docs/environments/local-environment)
- [Godot version-control guidance](https://docs.godotengine.org/en/4.7/tutorials/best_practices/version_control_systems.html)
