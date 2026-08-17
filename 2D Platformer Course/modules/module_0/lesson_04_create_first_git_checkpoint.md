# Module 0, Lesson 4: Create the First Git Checkpoint

**Status:** Validated

## By the end

The Godot project will have its first clean local Git checkpoint on `main`.
This gives you a known working state before future work, including Codex file
changes, begins.

- The `2D Platformer` project folder is a local Git repository on `main`.
- Godot's generated cache is excluded from Git.
- Project source files are included in the first commit.
- The latest commit is named `Create empty Godot project`.
- `git status` reports a clean working tree.
- Nothing has been uploaded to GitHub or another online service.

## Before you start

- Module 0, Lessons 1 through 3 are complete.
- `git --version` works in a newly opened PowerShell window.
- Git has the intended author identity and `main` default branch.
- The `2D Platformer` project opens without errors.
- The project folder is not already inside another Git repository.

## Build steps

### Part 1: Generate and inspect Godot's Git metadata

1. Open the `2D Platformer` project in Godot.
2. Open **Project → Version Control → Create/Override Version Control
   Metadata…**.
3. Confirm that **Git** is selected, then click **OK**. Godot warns that
   existing version-control metadata files will be overwritten; continue only
   when no custom metadata needs to be preserved.

   > 💡 Godot creates two Git setup files: `.gitignore`, which lists files Git
   > should leave out when committing, and `.gitattributes`, which keeps text
   > files consistent across computers. We create them here, then check what
   > they contain.

4. Confirm that Godot creates `.gitignore` and `.gitattributes` in the project
   root.
5. Right-click `res://` in the FileSystem dock and select **Open in File
   Explorer**.
6. Open `.gitignore` and `.gitattributes` in a text editor.
7. For Godot 4.7, confirm that `.gitignore` contains:

   ```gitignore
   .godot/
   /android/
   ```

   Confirm that important source files are not ignored, including:
   - `project.godot`
   - Godot scenes such as `.tscn`
   - GDScript files such as `.gd`
   - Godot resources such as `.tres`

8. Confirm that `.gitattributes` contains:

   ```gitattributes
   * text=auto eol=lf
   ```

   > 💡 An **ignored file** is intentionally left out of Git history, usually
   > because it is generated or private. `.godot/` is Godot's generated editor
   > cache; `/android/` is generated Android build content. `.gitattributes`
   > keeps text files in a consistent LF format across operating systems.

9. Save only if a verified rule is missing or incorrect, then close the text
    editor.

   > ⚠️ **If something differs**
   >
   > - Godot metadata can vary between versions. Inspect the generated files;
   >   do not add older rules from memory.

### Part 2: Initialize and inspect the repository

1. Close Godot so its files are stable during the first checkpoint.
2. In the open File Explorer window, select the address bar.
3. Type `powershell` and press **Enter**. PowerShell opens in the project
   folder.
4. Confirm that the prompt path is the folder containing `project.godot`.
5. Initialize the repository on `main`:

   ```powershell
   git init -b main
   ```

6. Inspect the repository:

   ```powershell
   git status
   ```

   > 💡 A **repository** is a project folder whose history Git manages. Its
   > **working tree** is the current visible project files. Files Git already
   > knows about are **tracked**; files it has not been asked to include are
   > **untracked**.

7. Confirm that Git reports `main` and lists the expected project files as
   untracked.
8. Confirm that `.godot/` is absent from the files offered for tracking.

   > ⚠️ **If something differs**
   >
   > - If PowerShell opens in the wrong folder, reopen it from the folder that
   >   contains `project.godot`.
   > - If `git init` was run in a parent folder, do not commit. Confirm the
   >   intended root and get help removing only the mistaken Git metadata.
   > - If Git asks for an author identity later, return to Lesson 0.3, configure
   >   the intended identity, and retry.

The hidden `.git` folder stores Git's local history and settings. Do not edit,
move, or delete its contents manually.

### Part 3: Stage, review, and commit

1. Stage the small empty project:

   ```powershell
   git add .
   ```

   > 💡 The **staging area** is the reviewed set of changes prepared for the
   > next snapshot. A **commit** is the named snapshot that Git records from
   > that staged set. Staging does not save, upload, or commit anything yet.

2. Review which files are staged and the size of their changes:

   ```powershell
   git status
   git diff --cached --stat
   ```

3. Confirm that only expected project source and metadata are staged.
4. Confirm that generated `.godot/` files and private credentials are absent.
5. Create the first commit:

   ```powershell
   git commit -m "Create empty Godot project"
   ```

6. Verify the checkpoint:

   ```powershell
   git status
   git log --oneline -1
   ```

Use this cycle for future small working results: inspect → stage intended
changes → review → commit → verify. Run `git status` before and after every
commit, and never commit passwords, tokens, private keys, or export
credentials.

After you understand and complete this first checkpoint manually, Codex can
help explain status or a diff and suggest a commit message. You still inspect
the staged changes and approve any commit.

7. Confirm that the working tree is clean and the latest message is
   `Create empty Godot project`.

   > ⚠️ **If something differs**
   >
   > - If `.godot/` appears in the staged list, stop before committing and
   >   correct `.gitignore`.
   > - If important project files are missing, check for an overly broad ignore
   >   rule before committing.
   > - If the working tree is not clean afterward, run `git status` and inspect
   >   what was not included; do not discard it automatically.
   > - This commit exists only on this computer. It is not yet an online backup.

## Learner exercise

Without reading the commands again:

1. Run `git status` and identify the branch.
2. Run `git log --oneline -1` and locate the commit message.
3. Explain untracked, ignored, staged, and committed files.
4. Explain why `.godot/` is ignored.
5. Explain why this checkpoint is useful but is not yet an online backup.

## Verification checklist

- [ ] The repository root is the folder containing `project.godot`.
- [ ] The active branch is `main`.
- [ ] `.gitignore` excludes Godot's generated cache and Android build files.
- [ ] `.gitattributes` keeps text line endings consistent with
      `* text=auto eol=lf`.
- [ ] Expected project source files are staged.
- [ ] Generated cache and confidential data are not staged.
- [ ] The latest commit message is `Create empty Godot project`.
- [ ] `git status` reports a clean working tree.
- [ ] The learner can explain repository, staging area, commit, tracked,
      untracked, and ignored files.
- [ ] The learner understands that the checkpoint exists only locally.

## References

- [Initialize a Git repository](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
- [Record changes with Git](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)
- [Godot version-control guidance](https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html)
