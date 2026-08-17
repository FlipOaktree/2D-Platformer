# Course Visual Design System

## Direction

Use the Module 0 visual as the reference: a minimalist, warm dark workspace
with a large clear title and one simplified interface mockup. It should feel
modern and calm, without looking like a full screenshot or a busy slide.

## Asset Organization

- Keep lesson-specific visual assets in that module's `assets` folder. For
  example: `2D Platformer Course/modules/module_0/assets/`.
- Keep editable source files (such as `.af` and `.svg`) beside the exported
  `.png` used in the written lessons and later course production.
- Treat the exported PNG as the learner-facing delivery asset. Keep raw
  captures and temporary production files out of the final lesson unless they
  serve a defined teaching purpose.
- Keep course-wide resources, such as fonts, in
  `2D Platformer Course/fonts/`.
- Link to a lesson asset from its Markdown file with a short relative path.

## Production and Learner Tools

- Screenshot-production tools are internal. Learners do not need to install or
  learn them to complete the course.
- Mention the software visible in a lesson only when the learner must interact
  with it.
- Do not turn a production technique into a learner requirement merely because
  it was used to create a visual.

## Palette

| Role | Color |
| --- | --- |
| Canvas | `#12110F` |
| Window | `#1C1B17` |
| Surface | `#181713` |
| Border | `#393730` |
| Primary text | `#F3F1EB` |
| Muted text | `#A6A29A` |
| Secondary text | `#858179` |
| File accent | `#D7836F` |
| Folder accent | `#82A7BE` |
| Root accent | `#C9A95E` |

Use off-white rather than pure white. Use accent colors only where they help
learners identify a file, folder, root, or focused UI detail.

## Typography

Use **Onest** for all course visuals. It is installed on the Windows system and
is the working font for editable visual source files.

- Titles: Onest SemiBold or Bold.
- UI labels and file names: Onest Regular or Medium.
- Use generous letter spacing only for small uppercase labels.
- Export a PNG with each visual so the design remains portable when the font is
  not installed on another device.

## Layout

- Artboard: `1600 x 900` pixels (16:9).
- For concept slides, place a large short title on the left and one simplified
  UI mockup on the right, with generous empty space between them.
- Use one rounded dark panel for the mockup, with a restrained border and no
  strong shadow.
- Align files that sit at the same project-folder level. Indent only children
  that belong inside a folder.
- Prefer one main idea per visual and show only the relevant part of the tool.

## Components

- **UI panel:** one dark rounded surface with a small header such as
  `FileSystem`.
- **Tree rows:** consistent vertical rhythm; use file and folder colors to show
  structure at a glance.
- **Callout:** short sentence, with one highlighted word or control at most.
- **Status pill:** optional; muted green or blue, never a bright warning color.

## Image Rules

- Use real UI screenshots only when learners need to locate a real setting or
  menu.
- Use simplified mockups when explaining folder structure, hierarchy, or a
  concept that benefits from less visual noise.
- Avoid gradients, decorative illustrations, fake IDE chrome, and dense text.
- Give every visual one defined teaching purpose. Remove visuals that only
  decorate or repeat the surrounding text.
- Check readability at the size used in the written lesson and the future
  video frame.
- Do not use color as the only way to communicate meaning; pair it with labels,
  icons, position, or shape.
- Give learner-facing images a concise descriptive caption or alternative-text
  description.
