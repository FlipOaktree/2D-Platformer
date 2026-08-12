# Module 1, Lesson 1: Create and Run Your First Scene

**Status:** Draft blueprint; not implemented or validated

## Learning outcome

Create, save, and run a simple main scene that displays a short message.

## Finished result

At the end of this lesson:

- A `Main` scene exists at `res://scenes/main.tscn`.
- Its root is a `Node2D` named `Main`.
- It contains a `Label` child that displays `Project ready`.
- Running the current scene opens a game window and shows the message.
- Running the project opens the same scene because it is configured as the
  main scene.

## Why this comes next

The empty project from Module 0 has no content to run. A small first scene gives
learners a visible result and introduces Godot's most important building blocks
before scripts or gameplay systems are added.

## Before you start

- The complete Module 0 setup is finished.
- The `2D Platformer` project opens without errors.
- No Godot or programming experience is required.

## New concepts

- **Node:** One building block with a focused job. A node might display text,
  play a sound, or control a character.
- **Scene:** A saved tree of nodes that can represent a screen, level,
  character, or reusable feature.
- **Scene tree:** The parent-and-child structure shown in the Scene dock.
- **Root node:** The first node in a scene. Every other node in that scene is
  placed under it.
- **Child node:** A node placed under another node in the scene tree.
- **`Node2D`:** A basic root for objects and scenes that live in 2D space.
- **`Label`:** A node that displays text.
- **Main scene:** The scene Godot opens when the whole project is run.
- **`.tscn` file:** Godot's text-based scene file format.

Only the parts of these concepts needed for this small scene are explained now.

## Course decisions

| Decision | Course choice | Why |
| --- | --- | --- |
| Root node | `Node2D` named `Main` | Establishes a clear 2D entry scene without adding gameplay behavior. |
| Child node | `Label` | Produces an immediate visible result without code or external assets. |
| Scene folder | `res://scenes/` | Creates a folder only when the project has a scene to store. |
| Scene filename | `main.tscn` | Uses a short, descriptive snake_case filename. |
| Display text | `Project ready` | Makes successful execution easy to recognize. |

## Blueprint steps

1. Open the `2D Platformer` project.
2. In the empty Scene dock, select **2D Scene** to create a `Node2D` root.
3. Rename the root node to `Main`.
4. Add a `Label` as a child of `Main`.
5. Select the `Label` and set its **Text** property in the Inspector to
   `Project ready`.
6. Save the scene.
7. In the save dialog, create a `scenes` folder.
8. Save the scene as `main.tscn` inside that folder.
9. Run the current scene and confirm that the game window shows
   `Project ready`.
10. Stop the running scene.
11. Run the project.
12. When Godot asks for a main scene, select the current scene.
13. Confirm that running the project opens the same scene and message.
14. Stop the project and reopen `main.tscn` from the FileSystem dock.

## Inspector customization point

The `Label` node's **Text** property is the first Inspector customization point.
Changing it updates what the scene displays without writing code.

## Practical Godot practices and tips

- Save a new scene early so later work is not left in an unsaved editor tab.
- Use descriptive PascalCase names for nodes, such as `Main`, and snake_case
  filenames, such as `main.tscn`.
- Use **Run Current Scene** while working on one scene. Use **Run Project** to
  test the project's configured starting point.
- Create folders when they have real content to hold instead of building a
  large empty folder structure in advance.

## Role of AI

Codex is not needed to build this scene because every action is short and must
be understood directly. If Codex is already available, it can be used after the
scene works to explain the roles of `Main`, `Label`, and `main.tscn` in plain
language. This is a review aid inside the lesson, not a separate path.

Any explanation from Codex should be compared with the working scene and the
definitions in this lesson.

## Learner exercise

Without following the blueprint again:

1. Change the label text to `My framework is running`.
2. Run the current scene and confirm the new message appears.
3. Change it back to `Project ready`.
4. Explain the difference between a node and a scene in one sentence each.

## Common mistakes

| Problem | What to do |
| --- | --- |
| The scene was saved in the project root. | Move or save it as `res://scenes/main.tscn`, then confirm Godot updates the reference. |
| The label is beside `Main` instead of under it. | Drag the `Label` onto `Main` in the Scene dock so it becomes a child. |
| Running the project asks for a main scene. | Choose the current `main.tscn` scene. This prompt is expected the first time. |
| The game window appears empty. | Confirm the `Label` is a child of `Main`, its Text property is not empty, and the scene was saved. |
| Changes do not appear when running. | Save the scene before running it again. |

## Modularity checkpoint

`Main` is an entry scene, not a gameplay module. It should remain small so
future modules can be added as child scenes instead of placing all behavior
directly in `Main`.

No script or reusable gameplay dependency is introduced yet.

## Acceptance checks

- [ ] `res://scenes/main.tscn` exists.
- [ ] The root node is a `Node2D` named `Main`.
- [ ] A `Label` is a child of `Main`.
- [ ] The label displays `Project ready`.
- [ ] Running the current scene succeeds without related errors or warnings.
- [ ] Running the project opens `main.tscn`.
- [ ] Closing and reopening the scene preserves its nodes and text.
- [ ] The learner can explain node, scene, root node, child node, and main
      scene in simple language.
- [ ] The learner can change the Label text through the Inspector.
