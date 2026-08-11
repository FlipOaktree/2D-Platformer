# Module 0, Lesson 3: Install and Configure Git

**Status:** Draft blueprint; not implemented or validated

## Learning outcome

Install Git for Windows and configure the identity and default branch that Git
will use for this course.

## Finished result

At the end of this lesson:

- `git --version` reports an installed Git for Windows version.
- Git has a deliberate author name and author email.
- New repositories use `main` as their default branch.
- The learner can close and reopen PowerShell and still use Git.
- The Godot project has not been turned into a Git repository yet.

## Why this comes next

The project exists, so it is time to prepare the tool that will record safe
checkpoints. Separating installation from the first checkpoint keeps the new
terminal commands and privacy decision small enough to understand.

This is a working setup, not a complete PowerShell or Git tour.

## Before you start

- Module 0, Lessons 1 and 2 are complete.
- A Windows PC with internet access is available.
- The learner can install applications on that computer.
- Basic Windows and file-management skills are expected.

## Course decisions

| Decision | Course choice | Why |
| --- | --- | --- |
| Git distribution | Current Git for Windows | It is the maintained Windows build and works with PowerShell and Codex. |
| Installation method | Official `winget` package command | Avoids a long installer tour and uses Windows' package manager. |
| Configuration level | Global user settings | The chosen identity and default branch apply consistently to the learner's repositories on this computer. |
| Default branch | `main` | Uses a clear modern default consistently throughout the course. |
| GitHub | Not used in this lesson | Online accounts and repositories come after the learner understands a local checkpoint. |

## New concepts

- **Version control:** A system that records deliberate versions of files so
  changes can be compared and earlier working states can be found.
- **Git:** The version-control tool used in this course.
- **Terminal:** A text-based place for giving the computer commands. This
  lesson uses PowerShell for a few visible Git commands.
- **Command:** A short instruction entered in a terminal.
- **Commit identity:** The author name and email stored in each Git snapshot.
- **Branch:** A line of project history. This course begins on `main`.

Repositories, staging, and commits are introduced in Lesson 4 when the learner
uses them for the first time.

## Lesson steps

### Part 1: Install and verify Git

1. Open **Windows PowerShell** from the Start menu.
2. Enter:

   ```powershell
   git --version
   ```

3. Press **Enter** and read the result.
4. If a Git version appears, continue to Part 2.
5. If Windows says that `git` is not recognized, enter:

   ```powershell
   winget install --id Git.Git -e --source winget
   ```

6. Read the installation and approval prompts before accepting them.
7. Close PowerShell after installation and reopen it. A terminal that was
   already open may not detect the newly installed command.
8. Run `git --version` again.
9. Confirm that a Git version appears. The exact patch number can be newer
   than the one shown during course production.

## What did the command do?

`git --version` asks Git to identify its installed version. It does not change
the computer or project.

The `winget install` command asks Windows' package manager to install the
maintained Git package with the exact package identifier `Git.Git`.

### Part 2: Configure the commit identity

Every future commit stores an author name and email. These values can become
visible if the project is shared online later, so choose them deliberately.

1. Check whether an identity is already configured:

   ```powershell
   git config --global --get user.name
   git config --global --get user.email
   ```

2. If both values are correct, keep them.
3. If either value is missing or incorrect, set the intended identity:

   ```powershell
   git config --global user.name "Your Name"
   git config --global user.email "you@example.com"
   ```

4. Do not copy the example name or email literally.
5. Set `main` as the default branch for new repositories:

   ```powershell
   git config --global init.defaultBranch main
   ```

6. Verify all three values:

   ```powershell
   git config --global --get user.name
   git config --global --get user.email
   git config --global --get init.defaultBranch
   ```

7. Confirm that the intended name, email, and `main` appear.

## Privacy note about commit email

Git stores the configured email inside every new commit. Use an address the
learner is comfortable associating with future shared project history.

A Git hosting provider can supply a private or no-reply commit address. The
learner may use one now if it is already available, or update the setting
before creating commits that will later be published.

## Practical Git and PowerShell practices

- Enter one command at a time and read its result before continuing.
- Copy commands exactly, but replace clearly marked example values.
- Do not paste a command from AI without understanding its intended effect.
- Record the Git version when troubleshooting.
- Check existing configuration before replacing it.
- Treat the commit email as information that may become public later.

## Role of AI

Codex is not needed for these short setup commands. The learner should first
recognize what each command checks or changes.

Codex will use the installed Git tools after the project is connected. It can
then help explain status and differences, but the learner remains responsible
for reviewing and approving Git actions.

## Learner exercise

Without reading the commands again:

1. Reopen PowerShell.
2. Display the installed Git version.
3. Display the configured author name and email.
4. Display the default branch name.
5. Explain why the email choice should be deliberate.

## Common mistakes

| Problem | What to do |
| --- | --- |
| `git` is not recognized after installation. | Close and reopen PowerShell, then run `git --version` again. |
| `winget` is not recognized. | Update or install Windows App Installer, then retry the official package command. |
| The example author name or email was copied literally. | Replace it with the learner's intended commit identity. |
| An existing correct identity was overwritten. | Run the check commands first and change only an incorrect value. |
| The learner expects GitHub to contain the project. | Explain that no repository or online account has been used yet. |
| PowerShell feels overwhelming. | Focus only on entering one shown command and reading the line it returns. |

## Acceptance checks

- [ ] `git --version` reports an installed Git for Windows version.
- [ ] Git remains available after PowerShell is closed and reopened.
- [ ] The configured author name is intentional.
- [ ] The configured author email is intentional.
- [ ] `init.defaultBranch` is `main`.
- [ ] The learner can explain version control, Git, terminal, command, commit
      identity, and branch in simple language.
- [ ] No Godot project files or Git repositories were changed.

## Validation notes to complete during implementation

- Confirm the current Git for Windows installation and approval prompts.
- Confirm whether reopening PowerShell is sufficient on a clean Windows
  learner account.
- Confirm the shortest recovery instruction when `winget` is unavailable.
- Confirm that the privacy explanation occurs before the identity is set.
- Record any Windows security or account prompt not covered by the blueprint.

## Instructor and production notes

- Keep the PowerShell explanation limited to opening it, entering one command,
  and reading the result.
- Do not introduce repositories, staging, commits, GitHub, remotes, or recovery
  commands here.
- Do not record video or create learner downloads until the complete written
  course passes end-to-end validation.

## References

- [Install Git for Windows](https://git-scm.com/install/windows)
- [First-time Git configuration](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

