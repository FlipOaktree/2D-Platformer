# Module 1, Lesson 1: Create and Run Your First Scene

**Status:** Written procedure validated and logged in Notion

## By the end

Create, save, and run a small main scene that displays `Project ready`. This
first visible result introduces the scene structure that later gameplay
features will build on.

- A `Main` scene exists at `res://scenes/main.tscn`.
- Its root is a `Node2D` named `Main`.
- It contains a `Label` child that displays `Project ready`.
- Running the current scene and the whole project both show that message.

## Before you start

- Module 0 is complete.
- The `2D Platformer` project opens without errors.

## Build steps

### Part 1: Create the main scene

1. Open the `2D Platformer` project.
2. In the empty **Scene** dock, select **2D Scene**.

   > 💡 Think of a node as a LEGO brick. Godot provides many kinds of nodes, each with a particular role, such as displaying text, showing an image, or playing an animation. Combining nodes creates a scene, much like combining bricks creates a model. A scene can also be placed inside another scene, just as a large LEGO model can be assembled from smaller models. Every scene begins with one root node at the top, with its other nodes arranged beneath it.

3. In the Scene dock, rename the `Node2D` root node to `Main`.

   This root stays small so later features can be added as child scenes instead
   of placing all gameplay behavior directly here.

4. Select `Main`, then select the **Add Child Node** button.
5. Search for `Label`, select it, then select **Create**.

   > 💡 A **child node** belongs under another node in the Scene dock. `Label`
   > is now a child of `Main`, so the tree shows that this text display is part
   > of the main scene.

6. Select `Label` in the Scene dock.
7. In the Inspector, find **Text** and enter:

   ```text
   Project ready
   ```

   > 💡 The **Inspector** shows settings for the selected node. Changing this
   > Label's Text property changes what it displays without writing code.

8. Double-click Label's icon in the Scene dock to center it in the viewport.
   You can use the zoom controls above the top-left of the 2D viewport to zoom in if the label appears too small.
9. Save the scene with **Scene → Save Scene** or `Ctrl+S`.
10. In the save dialog, create a folder named `scenes`.
11. Open `scenes`, enter `main.tscn` as the file name, and select **Save**.

   > 💡 A `.tscn` file stores a Godot scene.

### Part 2: Run the scene and set the project starting point

1. Select **Run Current Scene** or press `F6`.
2. Confirm that a game window opens and displays `Project ready`.
3. Stop the running scene with `F8` or the **Stop** button.

   Use **Run Current Scene** while working on one scene. It is a quick way to
   check the scene before testing how the whole project starts.

4. Select **Run Project** or press `F5`.

5. When Godot asks to choose a main scene, select the current `main.tscn`
   scene.

   > 💡 The **main scene** is the scene Godot opens when you run the whole
   > project. Choosing `main.tscn` sets this project's starting point.

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
4. Explain the difference between a node and a scene in one sentence each.

## Verification checklist

- [ ] `res://scenes/main.tscn` exists.
- [ ] The root node is a `Node2D` named `Main`.
- [ ] A `Label` is a child of `Main`.
- [ ] The Label displays `Project ready`.
- [ ] Running the current scene succeeds without related errors or warnings.
- [ ] Running the project opens `main.tscn` and shows the same message.
- [ ] Closing and reopening the scene preserves its nodes and text.
- [ ] The learner can explain node, scene, root node, child node, Inspector,
      and main scene in simple language.
- [ ] The learner can change the Label text through the Inspector.

## References

- [Godot scenes and nodes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [Godot user interface introduction](https://docs.godotengine.org/en/4.7/getting_started/introduction/first_look_at_the_editor.html)
- [Running the project](https://docs.godotengine.org/en/4.7/tutorials/editor/running_code_in_the_editor.html)
