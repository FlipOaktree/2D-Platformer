# Module 0, Lesson 1: Install Godot and Codex on Windows

**Status:** Written procedure validated and logged in Notion

## Learning outcome

Install, open, and verify the two core applications used throughout the
course: Godot and Codex.

## Finished result

At the end of this lesson:

- Godot 4.7.1 opens to the Project Manager.
- The ChatGPT desktop app opens and the learner can access Codex.
- Both applications can be closed and reopened from Windows.
- Godot is stored in a stable location outside the Downloads folder.
- The learner can explain the different role of each tool.
- No Godot project or extra developer tool has been created or installed yet.

## Why this comes first

Godot is where the game is assembled and run. Codex is the agent that will
help inspect and edit project files, run useful checks, explain changes, and
reduce repetitive work. Verifying both now prevents setup problems from
interrupting later project lessons.

This is a short working setup, not a complete tour. Each tool will be learned
as the project needs it.

## Before you start

- No Godot or programming experience is required.
- Basic Windows and file-management skills are expected.
- A Windows PC with internet access is available.
- The learner can download and run applications on that computer.
- An OpenAI account with Codex access is available. Any required AI plan is a
  separate cost from the course's free core production tools.

## Course decisions

| Decision | Course choice | Why |
| --- | --- | --- |
| Supported course platform | Windows | Keeps paths, shortcuts, commands, and troubleshooting consistent for beginners. |
| Godot edition | Standard Godot 4.7.1 for 64-bit Windows | The course uses GDScript, so the additional .NET/C# edition is unnecessary. |
| Godot source | Official Godot website | Reduces the risk of downloading an outdated or modified copy. |
| Codex application | ChatGPT desktop app for Windows | Provides a Windows-native agent, project workspace, file review, and PowerShell commands in one place. |
| Codex protection | **Ask for approval** with the project sandbox | Keeps the agent focused on the selected project and makes broader actions visible to the learner. |
| Additional setup | None in this lesson | Git, the Godot project, and the working Codex project are introduced in later focused lessons. |

No Godot MCP server is required. Codex can work directly with Godot's
text-based project files and can run Godot from the command line when that adds
a useful check. Visual scene editing remains in the Godot editor.

## New concepts

- **Game engine:** A collection of tools and systems used to build and run a
  game. Godot is the game engine used in this course.
- **Agent:** An AI assistant that can inspect a selected project, propose or
  make file changes, and run commands. The learner remains responsible for
  reviewing and testing its work.
- **Version:** A number identifying a particular release of an application.
  Using the tested version helps the course instructions match the interface.
- **Portable application:** An application that can run after its downloaded
  files are extracted, without a traditional installer. Godot works this way
  on Windows.
- **Project sandbox:** A boundary that limits where Codex can work. Actions
  outside that boundary can require the learner's approval.

Only these concepts are introduced now. Creating projects and using the tools
together come in later lessons.

## Lesson steps

### Part 1: Install and verify Godot

1. Open the official [Godot download page for Windows](https://godotengine.org/download/windows/).
2. Download the standard **Godot Engine 4.7.1** 64-bit Windows version.
   Do not choose the **.NET** version; that edition is intended for C# support.
3. Open the downloaded ZIP file and extract its contents.
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

### Part 2: Install and verify Codex

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
8. Do not add a project yet. The Godot project does not exist until Lesson 2,
   and the safe project workflow is introduced later.
9. Close the application, then reopen it and confirm that Codex is still
   available.

## Understand the tool roles

### Godot builds and runs the game

Use Godot to create and arrange nodes, edit Inspector properties, preview
scenes, run the game, and inspect visual results.

### Codex works with the project

Once a project is connected, Codex can read and edit scripts, scenes,
resources, and configuration files because these are stored as files on disk.
It can also search the project, compare changes, run commands, and help check
for errors.

Codex does not make a change correct simply because it produced the change.
The course will show a small task, inspect what changed, and test the result
before accepting it.

## Practical setup practices and tips

- Download applications from their official sources.
- Keep Godot in a stable folder so shortcuts and later command-line checks do
  not break when Downloads is cleaned.
- Record the installed versions when troubleshooting or asking for help.
- Keep Codex inside the selected project sandbox and read approval requests
  before accepting them.
- Do not install extra tools in advance. Add a tool when the project has a
  clear use for it.

## Role of AI

Codex cannot accelerate this lesson until it has been installed. Its first
use is therefore a verification: open it successfully and recognize that it
can act on project files later, not merely answer chat questions.

The course maintains one lesson path. When Codex provides a clear advantage,
learners use it after understanding the representative action and then review
and test its output.

## Learner exercise

Without reading the steps again:

1. Close both applications.
2. Reopen Godot and identify the Project Manager.
3. Reopen the ChatGPT desktop app and access Codex.
4. Explain in one sentence what Godot does.
5. Explain in one sentence how Codex will support the project.

## Common mistakes

| Problem | What to do |
| --- | --- |
| Godot remains in Downloads. | Move the extracted folder to a stable location before creating a shortcut. |
| The .NET version was downloaded. | Download the standard version; the course uses GDScript rather than C#. |
| Windows warns about the application. | Stop and confirm the official source and expected publisher before continuing. |
| Codex is not available after signing in. | Confirm that the account has Codex access and check the current official access requirements. |
| The app is set to full access. | Select **Ask for approval** so the project sandbox is active. |

## Acceptance checks

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
- [ ] No Godot MCP server or unrelated developer tool was installed.

## Validation record

- The project owner validated the written procedure on Windows.
- Godot 4.7.1 and Codex both open and can be accessed as described.
- Current interface wording and Codex access requirements should be checked
  again during the final end-to-end course rebuild before recording.

## Instructor and production notes

- Keep this as a working setup, not a full Godot, Codex, or Windows tour.
- Clearly disclose current Codex access or subscription requirements before
  purchase. Godot remains free and open source.
- The course itself can be followed without maintaining a second non-AI path;
  short manual continuation notes are enough where Codex is unavailable.
- Do not record video or create learner downloads until the complete written
  course passes end-to-end validation.

## References

- [Godot download for Windows](https://godotengine.org/download/windows/)
- [Godot installation and stable-location guidance](https://docs.godotengine.org/en/stable/about/faq.html#how-do-i-install-the-godot-editor-on-my-system-for-desktop-integration)
- [ChatGPT desktop app for Windows](https://learn.chatgpt.com/docs/windows/windows-app)
