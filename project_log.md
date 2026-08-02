# 2D Platformer Project Steps

Use this file to summarize the major steps of the project as it develops.

## Step 1: App Setup

- Install ChatGPT Codex on Windows: https://openai.com/codex/
- Install the latest Godot Engine: https://godotengine.org/download/windows/, place in directory and rename executable to 'Godot.exe'.
- Install Node.js: https://nodejs.org/en/download
- Open the Godot MCP Github page: https://github.com/Coding-Solo/godot-mcp
- Configure the Godot MCP Server in Codex with the info from the Github Godot MCP page: 
Settings > Plugins > MCPs > Add Server:
Command to launch: npx
Arguments: @coding-solo/godot.mcp
Environment variables:
GODOT_PATH = "C:\Program Files\Godot\Godot.exe'
DEBUG = true
- Verify MCP connection by asking Codex to check connection to Godot.
- Install Git: https://git-scm.com/install/windows
- Connect Github to Codex.
- Create a new repository for your project in Github: https://github.com/. In Codex's terminal, paste:
cd "D:\Projects\2D Platformer Template"
git init
git branch -M main
@"
.godot/
.import/
export.cfg
export_presets.cfg
*.tmp
"@ | Out-File -Encoding utf8 .gitignore
git add .
git commit -m "Initial project setup"
git remote add origin https://github.com/FlipOaktree/2D-Platformer-Template.git
git push -u origin main
- 



## Step 2: [Add title]

Summary:

- 

Notes:

- 

## Step 3: [Add title]

Summary:

- 

Notes:

- 

## Step 4: [Add title]

Summary:

- 

Notes:

- 

## Step 5: [Add title]

Summary:

- 

Notes:

- 

## Future Steps

Add new sections as the project progresses.
