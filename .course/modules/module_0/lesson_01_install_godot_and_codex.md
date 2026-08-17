# Module 0, Lesson 1: Install Godot and Codex on Windows

**Status:** Written procedure validated and logged in Notion

## By the end

Install, open, and verify Godot and Codex, the two core applications used
throughout the course. Godot is where the game is built and run; Codex will
later help inspect, edit, and check project files.

- Godot 4.7.1 opens to the Project Manager.
- The ChatGPT desktop app opens and the learner can access Codex.
- Both applications can be closed and reopened from Windows.
- Godot is stored in a stable location outside the Downloads folder.
- The learner can explain the different role of each tool.
- No Godot project or extra developer tool has been created or installed yet.

## Before you start

- Basic Windows and file-management skills are expected.
- A Windows PC with internet access is available.
- The learner can download and run applications on that computer.
- An OpenAI account with Codex access is available. Any required AI plan is a
  separate cost from the course's free core production tools.

## Build steps

### Part 1: Install and verify Godot

> 💡 Godot is the **game engine** used in this course. A game engine is a
> collection of tools that builds and runs the game.

1. Open the official [Godot download page for Windows](https://godotengine.org/download/windows/).
2. Download the standard **Godot Engine 4.7.1** 64-bit Windows version.
   Do not choose the **.NET** version; that edition is intended for C# support.
3. Open the downloaded ZIP file and extract its contents. Godot is a
   **portable application**, so it runs from the extracted files rather than a
   traditional installer.
4. Move the extracted Godot folder to a stable location owned by the learner,
   outside the Downloads folder. For example:

   `C:\Users\<your-name>\Applications\Godot-4.7.1\`

5. Open the extracted Godot executable.
6. If Windows displays a security prompt, confirm that the publisher and
   download source are expected before continuing.
7. Confirm that the Godot Project Manager opens and shows version **4.7.1**.
8. Pin Godot to the taskbar or create a shortcut if that makes it easier to
   reopen. This is optional.
9. Close Godot, then reopen it from the stable location or shortcut.

> ⚠️ **If something differs**
>
> - If the .NET edition was downloaded, return to the official page and choose
>   the standard build; this course uses GDScript.
> - If Windows warns about the application, stop and confirm the official
>   source and expected publisher.
> - If Godot is still in Downloads, move it before relying on a shortcut.

### Part 2: Install and verify Codex

> 💡 An **agent** like Codex is an AI that can do more than answer questions:
> it can work toward a goal by planning steps, using available tools, editing
> files, and running commands. The learner still reviews and tests its work.

1. Open the official [ChatGPT desktop app for Windows page](https://learn.chatgpt.com/docs/windows/windows-app).
2. Follow its Microsoft Store download link and install the application.
3. If you do not have an OpenAI account, create one using the official
[ChatGPT sign-up page](https://chatgpt.com/auth/login) and complete any required
verification.
4. Open the ChatGPT desktop app and sign in to the OpenAI account that has
   Codex access.
5. Open Codex in the app.
6. Confirm that Codex is using the **Windows-native agent**. In Codex, open the
   agent or environment selector near the message box and select the option
   labeled **Windows-native**. Do not select a WSL or Linux environment.
7. Beneath the message box, select **Ask for approval** so sandbox protections
   are active.

   > 💡 **Ask for approval** keeps Codex inside the project sandbox. This
   > limits where it can work and lets you review broader actions first. Once a
   > project is connected, Codex can inspect its files, but you still need to
   > review and test its suggestions.
8. Do not add a project yet. The Godot project does not exist until Lesson 2,
   and the safe project workflow is introduced later.
9. Close the application, then reopen it and confirm that Codex is still
   available.

> ⚠️ **If something differs**
>
> - If Codex is unavailable after signing in, confirm that the account has
>   access and check the current official requirements.
> - If the app is set to full access, switch it back to **Ask for approval**.
>   Do not install extra tools yet; later lessons introduce each one when it
>   has a clear use.

## Learner exercise

Without reading the steps again:

1. Close both applications.
2. Reopen Godot and identify the Project Manager.
3. Reopen the ChatGPT desktop app and access Codex.
4. Explain in one sentence what Godot does.
5. Explain in one sentence how Codex will support the project.

## Verification checklist

- [ ] The standard Godot 4.7.1 Windows build is extracted.
- [ ] Godot is stored outside the Downloads folder.
- [ ] The Godot Project Manager opens and shows version 4.7.1.
- [ ] Godot closes and reopens successfully.
- [ ] The ChatGPT desktop app is installed from the official source.
- [ ] The learner can sign in and access Codex.
- [ ] The Windows-native agent is selected.
- [ ] **Ask for approval** is selected.
- [ ] The ChatGPT desktop app closes and reopens successfully.
- [ ] The learner can explain the different roles of Godot and Codex.

## References

- [Godot download for Windows](https://godotengine.org/download/windows/)
- [Godot installation and stable-location guidance](https://docs.godotengine.org/en/stable/about/faq.html#how-do-i-install-the-godot-editor-on-my-system-for-desktop-integration)
- [ChatGPT desktop app for Windows](https://learn.chatgpt.com/docs/windows/windows-app)
