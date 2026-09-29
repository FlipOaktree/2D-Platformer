# Module 0, Lesson 1: Install Godot, Codex, and GitHub Desktop on Windows

**Status:** Implemented

## Lesson goals

Install, open, and verify the applications used throughout the course. Godot
is where the game is built and run; GitHub Desktop will save tested versions of
the project and back them up online; Codex, which is optional, will later help
inspect, edit, and check project files.

- Installing Godot and keeping it somewhere it will not be lost
- Optionally installing Codex and setting it to ask before it acts
- Installing GitHub Desktop and signing in to a free GitHub account
- Understanding what each of the three tools is for

## Before you start

- Basic Windows and file-management skills are expected.
- A Windows PC with internet access is available.
- The learner can download and run applications on that computer.
- Optional: an OpenAI account with Codex access, if you want to use Codex. Any
  required AI plan is a separate cost from the course's free core production
  tools.
- An email address is available for creating a free GitHub account.

## Build steps

### Part 1: Install and verify Godot

> 💡 A **game engine** like **Godot** is a software power tool that gives you pre-built building blocks—like physics, graphics, and audio—so you don't have to code a video game entirely from scratch.

1. Open the official [Godot download page for Windows](https://godotengine.org/download/windows/).
2. Download the standard **Godot Engine 4.7.2** 64-bit Windows version.
   Do not choose the **.NET** version; that edition is intended for C# support.
3. Open the downloaded ZIP file and extract its contents. Godot is a
   **portable application**, so it runs from the extracted files rather than a
   traditional installer.
4. Move the extracted Godot folder to a stable location owned by the learner,
   outside the Downloads folder. For example:

   `C:\Users\<your-name>\Applications\Godot-4.7.2\`

5. Open the extracted Godot executable.
6. If Windows displays a security prompt, confirm that the publisher and
   download source are expected before continuing.
7. Confirm that the Godot Project Manager opens and shows version **4.7.2**. Pin Godot to the taskbar or create a shortcut if that makes it easier to reopen.

> ⚠️ **If something differs**
>
> - If the .NET edition was downloaded, return to the official page and choose
>   the standard build; this course uses GDScript.
> - If Windows warns about the application, stop and confirm the official
>   source and expected publisher.
> - If Godot is still in Downloads, move it before relying on a shortcut.

### Part 2: Install and verify Codex (optional)

Codex is an optional AI assistant. Skip this Part if you do not want to use it:
every lesson can be completed without it.

> 💡 An **agent** like Codex is an AI that can do more than answer questions:
> it can work toward a goal by planning steps, using available tools, editing
> files, and running commands.

1. Open the official [ChatGPT desktop app for Windows page](https://learn.chatgpt.com/docs/windows/windows-app).
2. Follow its Microsoft Store download link and install the application.
3. If you do not have an OpenAI account, create one using the official [ChatGPT sign-up page](https://chatgpt.com/auth/login) and complete any required verification.
4. Open the ChatGPT desktop app and sign in to the OpenAI account that has
   Codex access.
5. Open Codex in the app.
6. Confirm that Codex is using the **Windows-native agent**. In Codex, open the
   agent or environment selector near the message box and select the option
   labeled **Windows-native**. Do not select a WSL or Linux environment.
7. Beneath the message box, select **Ask for approval** so sandbox protections are active to limit where Codex can work and to let you review broader actions first. Once a project is connected, Codex can inspect its files, but you still need to review and test its suggestions.
8. Do not add a local project to Codex yet. Lesson 0.2 first creates the Godot
   project folder; its optional last Part then connects that folder to Codex.

> ⚠️ **If something differs**
>
> - If Codex is unavailable after signing in, confirm that the account has
>   access and check the current official requirements.
> - If the app is set to full access, switch it back to **Ask for approval**.
>   Do not install extra tools yet; later lessons introduce each one when it
>   has a clear use.

### Part 3: Create a GitHub account and install GitHub Desktop

> 💡**Git** is a version control tool. It saves versions of your files, so you can compare changes or return to an earlier one. **GitHub** is a website that stores your project online along with all of its saved versions. 
> 
> **GitHub Desktop** is a free application that includes its own copy of Git, so there is nothing separate to install. It uses Git to save those versions on your computer and sends them to GitHub, so you get version control and an online backup of your project without typing any commands. Later lessons use it at the end of each module to record a tested version of the game.

1. Open the official [GitHub sign-up page](https://github.com/signup) and create a free account, completing any required verification.
2. Download the Windows version from the official [GitHub Desktop page](https://github.com/apps/desktop).
3. Run the downloaded installer.
4. Open GitHub Desktop and choose the option to sign in to GitHub.com.
5. Complete the sign-in in the browser window that opens, then return to
   GitHub Desktop.
6. Confirm that GitHub Desktop shows the account as signed in.
7. Do not create or clone a repository yet. Lesson 0.2 first creates the Godot
   project folder; Lesson 0.3 then turns that folder into a repository.

> ⚠️ **If something differs**
>
> - If GitHub Desktop does not show the account, open the application's
>   options and sign in from its accounts section.
> - If the browser sign-in does not return to the app, leave GitHub Desktop
>   open and start the sign-in again.

## Learner exercise

Without reading the steps again:

1. Explain in one sentence what Godot does.
2. If you installed Codex, explain in one sentence how it will support the
   project.
3. Explain in one sentence what GitHub Desktop will be used for.

## Verification checklist

- [ ] The standard Godot 4.7.2 Windows build is extracted.
- [ ] Godot is stored outside the Downloads folder.
- [ ] The Godot Project Manager opens and shows version 4.7.2.
- [ ] If you installed Codex, the ChatGPT desktop app came from the official
      source and you can sign in and open Codex.
- [ ] If you installed Codex, the Windows-native agent and **Ask for approval**
      are selected, and no local project has been added to it yet.
- [ ] GitHub Desktop is installed from the official source.
- [ ] GitHub Desktop is signed in to a GitHub account.
- [ ] No repository has been created or cloned yet.
- [ ] The learner can explain the different roles of Godot, Codex, and GitHub Desktop.

## References

- [Godot download for Windows](https://godotengine.org/download/windows/)
- [Godot installation and stable-location guidance](https://docs.godotengine.org/en/4.7/about/faq.html#how-do-i-install-the-godot-editor-on-my-system-for-desktop-integration)
- [ChatGPT desktop app for Windows](https://learn.chatgpt.com/docs/windows/windows-app)
- [GitHub Desktop](https://github.com/apps/desktop)
- [GitHub Desktop documentation](https://docs.github.com/en/desktop)
