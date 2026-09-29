# Module 0, Lesson 3: Create the First Git Checkpoint

**Status:** Implemented

## Lesson goals

Give GitHub Desktop a deliberate commit identity, turn the Godot project
folder into a Git repository, save its first checkpoint, and back that
checkpoint up to a private GitHub repository.

- Giving your commits a name and email you chose rather than a default
- Turning the project folder into a Git repository, so its history is kept
- Keeping Godot's generated files out of that history
- Saving a first checkpoint containing only files you looked at and understood
- Backing that checkpoint up to a private GitHub repository, so the work
  survives this computer

## Before you start

- Module 0, Lessons 1 and 2 are complete.
- GitHub Desktop is installed and signed in to a GitHub account.
- The `2D Platformer` project opens without errors.
- The project folder is not already inside another Git repository.

## Build steps

### Part 1: Set the commit identity

> 💡 A **commit identity** is the author name and email stored in every
> snapshot Git saves. Git will not record a snapshot without one. It is what
> lets the history of a shared project say who made each change.

1. In GitHub Desktop, open **File → Options**, then select **Git**.
2. In the **Name** field, enter the name you want attached to your commits.
3. In the **Email** field, choose or enter the address you want attached.
   Replace any placeholder example values rather than keeping them.
4. Select **Save**.
5. Reopen **File → Options → Git** and confirm that both values are as
   intended.

Git stores this email in every new commit. Choose an address you are
comfortable associating with shared project history. The GitHub account you
created in Lesson 0.1 offers a no-reply address that links commits to that
account without exposing a personal email. For example,
`123456+username@users.noreply.github.com` is a normal GitHub no-reply address.

### Part 2: Prepare the project for Git

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

### Part 3: Create the repository in GitHub Desktop

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
> - If GitHub Desktop does not offer to create a repository, confirm that you
>   selected the folder containing `project.godot` and not its parent.
> - If the current branch is not `main`, open the branch menu at the top of the
>   window and rename the branch to `main`.

### Part 4: Review the changes, then commit

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
   under **History** with the author name you set in Part 1.

> ⚠️ **If something differs**
>
> - If `.godot/` files appear in the list, stop and correct `.gitignore` as in
>   Part 2 before committing.
> - If **Commit to main** is unavailable, confirm that **Summary** is filled
>   and that at least one file is checked.

### Part 5: Back the checkpoint up to a private GitHub repository

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

Use this cycle for every later checkpoint: test the result, read the changed
file list, commit with a clear summary, then push.

## Learner exercise

Without repeating the build steps:

1. Open the **History** tab and locate the checkpoint.
2. Explain untracked, ignored, and committed files.
3. Explain why `.godot/` is ignored.
4. Explain the difference between a commit and a push.
5. Explain why the commit email should be a deliberate choice.

## Verification checklist

- [ ] GitHub Desktop shows an intentional author name and email.
- [ ] The repository root is the folder containing `project.godot`.
- [ ] The active branch is `main`.
- [ ] `.gitignore` excludes `.godot/`.
- [ ] The learner read the changed-file list and one diff before committing.
- [ ] Generated cache and confidential data are not committed.
- [ ] The latest commit summary is `Checkpoint empty Godot project`.
- [ ] The **Changes** tab is empty after the commit.
- [ ] A GitHub repository holds the checkpoint and is private.
- [ ] The learner can explain commit identity, repository, diff, commit,
      remote, untracked, and ignored files.
- [ ] The learner can explain the difference between a commit and a push.

## References

- [Configure Git for GitHub Desktop](https://docs.github.com/en/desktop/configuring-and-customizing-github-desktop/configuring-git-for-github-desktop)
- [Add a local repository to GitHub Desktop](https://docs.github.com/en/desktop/adding-and-cloning-repositories/adding-a-repository-from-your-local-computer-to-github-desktop)
- [Commit and review changes in GitHub Desktop](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop)
- [Create your first repository with GitHub Desktop](https://docs.github.com/en/desktop/overview/creating-your-first-repository-using-github-desktop)
- [Godot version-control guidance](https://docs.godotengine.org/en/4.7/tutorials/best_practices/version_control_systems.html)
