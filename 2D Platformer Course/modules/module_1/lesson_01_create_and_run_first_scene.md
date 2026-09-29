# Module 1, Lesson 1: Create and Run Your First Scene

**Status:** Validated

## By the end

Create, save, and run a small main scene that displays `Project ready`. This
first visible result introduces the scene structure that later gameplay
features will build on. You will also learn how to find and inspect small
content in the 2D viewport without moving it.

- Creating and saving a `Main` scene that every later scene will hang off
- Adding a `Label` to it, so the project has something visible to run
- Telling the project which scene to open when it starts
- Moving around the 2D viewport without moving what you are looking at

## Before you start

- Module 0 is complete.
- The `2D Platformer` project opens without errors.

## Build steps

### Part 1: Create the main scene

1. Open the `2D Platformer` project.
2. In the empty **Scene** dock, select **2D Scene**.

> 💡 The **Scene** dock lists the nodes in the scene you are editing, arranged as a tree. It is where you add, rename, select, and rearrange them, and selecting a node here is what decides which node the Inspector and the toolbar act on.

3. In the Scene dock, rename the `Node2D` root node to `Main`.

> 💡 Think of a **node** as a LEGO brick. Godot provides many kinds of nodes, each with a particular role. Combining nodes creates a scene, much like combining bricks creates a model. Every scene begins with one root node at the top, with its other nodes nested inside it. A node nested directly in another is called a **child** node, and the node it is nested in is called its **parent** node.

4. Select `Main`, then select the **Add Child Node** button.
5. Search for `Label`, select it, then select **Create**. `Label` is now a child of `Main`, so the tree shows that this text display is part of the main scene.
6. Select `Label` in the Scene dock.
7. In the Inspector, find **Text** and enter:

   ```text
   Project ready
   ```

> 💡 The **Inspector** dock shows settings for the selected node. Changing this
> Label's Text property changes what it displays without writing code.

8. Double-click `Label`'s icon in the Scene dock to center it in the 2D
   viewport.

> 💡 The **2D viewport** is the large central area where you see and arrange
> your scene.

9. Use the zoom controls above the top-left of the viewport to zoom in and out.
10. Select **Pan Mode** in the toolbar above the viewport, then drag with the left mouse button to move your view.
11. Try either shortcut for panning without selecting Pan Mode:
    - Hold the middle mouse button and drag.
    - Hold `Space` while dragging with the left mouse button.
12. Double-click `Label`'s icon again to return to it. Panning and zooming change only your view inside the editor. They do not move the Label or change what appears when the game runs.
13. Save the scene with **Scene → Save Scene** or `Ctrl+S`.
14. In the save dialog, create a folder named `scenes`.
15. Open `scenes`, enter `main.tscn` as the file name, and select **Save**.

> 💡 A `.tscn` file stores a Godot scene.

> ⚠️ **If something differs**
>
> - If the Label becomes hard to find, double-click its icon in the Scene dock
>   to center it again.
> - If dragging moves the Label instead of the view, undo with `Ctrl+Z`, then
>   select Pan Mode or use one of the panning shortcuts.

### Part 2: Run the scene and set the project starting point

1. Select **Run Current Scene** or press `F6`.
2. Confirm that a game window opens and displays `Project ready`.
3. Stop the running scene with `F8` or the **Stop** button.
4. Select **Run Project** or press `F5`.
5. When Godot asks to choose a main scene, select the current `main.tscn`
   scene.

> 💡 Use **Run Current Scene** while working on one scene. It is a quick way to
   check the scene before testing the whole project. The **main scene** is the project's starting point when you run the whole project, and using **Run Project** will always run that scene.

6. Confirm that the game window again displays `Project ready`.
7. Stop the project.
8. In the FileSystem dock, open `scenes/main.tscn` and confirm that `Main` and
   `Label` are still present.

> ⚠️ **If something differs**
>
> - If `Label` is not visible beneath `Main`, select the arrow beside `Main`
>   in the Scene dock to expand it.
> - If the game window is empty, select `Label` and confirm that its Text
>   property is `Project ready`, then save the scene before running again.
> - If your changes do not appear, save the scene with `Ctrl+S` and rerun it.
> - If Godot asks for a main scene when you run the project, select
>   `res://scenes/main.tscn`. This is expected the first time.

## Learner exercise

Without following the steps again:

1. Change the Label text to `My framework is running`.
2. Run the current scene and confirm that the new message appears.
3. Change the text back to `Project ready` and save the scene.
4. Explain the difference between a node and a scene.
5. Pan and zoom away from the Label, then center it again without moving it.

## Verification checklist

- [ ] `res://scenes/main.tscn` exists.
- [ ] The root node is a `Node2D` named `Main`.
- [ ] A `Label` is a child of `Main`.
- [ ] The Label displays `Project ready` at Position `(0, 0)`.
- [ ] Running the current scene succeeds without related errors or warnings.
- [ ] Running the project opens `main.tscn` and shows the same message.
- [ ] Closing and reopening the scene preserves its nodes and text.
- [ ] The learner can explain node, scene, root node, child node, Inspector,
    and main scene in simple language.
- [ ] The learner can change the Label text through the Inspector.
- [ ] The learner can pan, zoom, and center a node without changing its
    position.

## References

- [Godot scenes and nodes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [Godot user interface introduction](https://docs.godotengine.org/en/4.7/getting_started/introduction/first_look_at_the_editor.html)
- [Running the project](https://docs.godotengine.org/en/4.7/tutorials/editor/running_code_in_the_editor.html)
