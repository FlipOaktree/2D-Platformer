# Module 0, Lesson 3: Install and Configure Git

**Status:** Validated

## By the end

Git for Windows will be installed, with an intentional author name, email, and
default `main` branch. This prepares the local safety checkpoints used in the
next lesson; GitHub and online publishing come later.

- `git --version` reports an installed Git for Windows version.
- Git has a deliberate author name and author email.
- New repositories use `main` as their default branch.
- Git remains available after PowerShell is closed and reopened.
- The Godot project has not been turned into a Git repository yet.

## Before you start

- Module 0, Lessons 1 and 2 are complete.
- A Windows PC with internet access is available.
- The learner can install applications on that computer.

## Build steps

### Part 1: Install and verify Git

> 💡 **Git** is a version-control tool that saves deliberate versions of your
> files, so you can compare changes or return to an earlier working version.

1. Open **Windows PowerShell** from the Start menu.

   > 💡 A **terminal** is an application used to give the computer text-based
   > **commands**. PowerShell is the terminal used in this course.
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

> 💡 `winget` is Windows' package manager. This command installs the
> maintained Git for Windows package without a long installer tour.

6. Read the installation and approval prompts before accepting them.
7. Close PowerShell after installation and reopen it. A terminal that was
   already open may not detect the newly installed command.
8. Run `git --version` again.
9. Confirm that a Git version appears. The exact patch number can be newer
   than the one shown during course production.

`git --version` only reports Git's installed version; it does not change the
computer or project.

> ⚠️ **If something differs**
>
> - If `git` is not recognized after installation, close and reopen PowerShell,
>   then run `git --version` again.
> - If `winget` is not recognized, update or install Windows App Installer,
>   then retry the command.

### Part 2: Configure the commit identity

> 💡 A **commit identity** is the author name and email stored in each Git
> snapshot. A **branch** is a line of project history. This course uses
> `main` as the clear default branch for new repositories.

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

4. Replace the example name and email; do not copy them literally.
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

Git stores the configured email in every new commit. Choose an address you are
comfortable associating with shared project history. A hosting provider such as
GitHub may offer a no-reply address that links commits to the intended account
without exposing a personal email. For example,
`123456+username@users.noreply.github.com` is a normal GitHub no-reply address.

These commands configure Git on the computer, but they do not initialize the
Godot project as a repository. In Lesson 0.4, you will connect the existing
Godot folder to Codex, manually initialize its repository, and use Codex to
review the first checkpoint before you approve it.

> ⚠️ **If something differs**
>
> - When setting your Git identity, replace any placeholder example name and
>   email with the intended values.

## Learner exercise

Without reading the commands again:

1. Reopen PowerShell.
2. Display the installed Git version.
3. Display the configured author name and email.
4. Display the default branch name.
5. Explain why the email choice should be deliberate.

## Verification checklist

- [ ] `git --version` reports an installed Git for Windows version.
- [ ] Git remains available after PowerShell is closed and reopened.
- [ ] The configured author name is intentional.
- [ ] The configured author email is intentional.
- [ ] `init.defaultBranch` is `main`.
- [ ] The learner can explain Git, terminal, command, commit identity, and
      branch in simple language.
- [ ] No Godot project files or Git repositories were changed.

## References

- [Install Git for Windows](https://git-scm.com/install/windows)
- [First-time Git configuration](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)
