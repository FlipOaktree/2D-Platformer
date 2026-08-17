# Module 2, Lesson 2: Build the Shared Actor Scene

**Status:** Validated locally; Notion current

## By the end

Create a reusable `Actor` scene that gives future players, NPCs, and enemies a
small shared structure without giving every actor the same gameplay features.
The finished scene will contain:

- A `CharacterBody2D` root named `Actor`.
- A `Node2D` child named `Visuals` for sprites and other visual nodes.
- A `CollisionShape2D` child with a `RectangleShape2D` placeholder.
- A `Node2D` child named `Components` for optional feature scenes added later.

The scene will be saved as `res://actors/actor.tscn`. It will not contain a
script, movement, health, combat, or other optional behavior yet. Running the
project will still display `Project ready` and the project icon.

## Before you start

- Module 2, Lesson 1 is complete.
- The Input Map contains `move_left`, `move_right`, and `jump`.
- You can create child nodes, use the Inspector, save a scene, and recognize a
  reusable scene from Module 1.
- The project opens and runs without related errors or warnings.

## Build steps

### Part 1: Create the Actor scene

1. In Godot, select **Scene → New Scene**.
2. In the empty Scene dock, select **Other Node**.
3. Search for `CharacterBody2D`, select it, then select **Create**.
4. Rename the root node `Actor`.

> 💡 A `CharacterBody2D` is a 2D physics body designed for characters whose
> movement will be controlled by code. It can detect collisions when it moves,
> but it does not move by itself. Later lessons will add that behavior. Using
> it as the shared root gives players, NPCs, and enemies the same basic
> movement-and-collision foundation without deciding their specific behavior
> yet.

5. Save the scene with `Ctrl+S`.
6. In the save dialog, create a folder named `actors` at the top level of the
   project.
7. Open `actors`, enter `actor.tscn` as the file name, then select **Save**.
8. Confirm that `res://actors/actor.tscn` appears in the FileSystem dock.

> ⚠️ **If something differs**
>
> - If Godot offers **2D Scene**, do not select it for this scene. That shortcut
>   creates a `Node2D`; use **Other Node** to choose `CharacterBody2D`.
> - If the scene was saved in the wrong folder, use **Scene → Save Scene As**
>   and save it at `res://actors/actor.tscn`.
> - If the root name differs, rename only the root node to `Actor`.

### Part 2: Add the collision boundary

1. Select `Actor`, then select **Add Child Node**.
2. Search for `CollisionShape2D`, select it, then select **Create**.
3. With `CollisionShape2D` selected, find **Shape** in the Inspector.
4. Select the empty Shape field, then choose **New RectangleShape2D**.
5. Select the new `RectangleShape2D` resource to expand its properties.
6. Set **Size** to `(32, 32)`.
7. Confirm that `CollisionShape2D` remains at Position `(0, 0)`.

> 💡 `CollisionShape2D` tells the physics body which area can collide. The
> `RectangleShape2D` resource stores the rectangle's dimensions. The
> `(32, 32)` rectangle is a safe placeholder for this shared scene; a later
> actor can replace or resize it to match its visual. The blue rectangle is an
> editor guide and will not appear as artwork when the game runs.

> ⚠️ **If something differs**
> - If a warning remains beside `CollisionShape2D`, confirm that its Shape
>   property contains a `RectangleShape2D` rather than being empty.
> - If the rectangle is offset from the actor origin, restore
>   `CollisionShape2D` Position to `(0, 0)`.
> - If the rectangle is not square, set both Size values to `32` instead of
>   changing the node's Scale.

### Part 3: Add focused attachment points

1. Select `Actor`, then add a `Node2D` child.
2. Rename it `Visuals`.
3. Select `Actor` again, then add a `Node2D` child.
4. Rename it `Components`.
5. Drag the children into this order if needed:
   ```text
   Actor
   ├── Visuals
   ├── CollisionShape2D
   └── Components
   ```
> 💡 In this Actor scene, Visuals and Components are attachment points that work like empty folders. They do nothing by themselves, but they organize related things together. Put visual nodes, such as sprites and animations, under Visuals. They inherit the Visuals node’s Position, Rotation, and Scale, so a later change can affect the whole visual branch without moving the collision shape. Put optional feature scenes under Components. Keeping the branches separate makes Actor easier to understand and lets you add or remove a feature without disturbing its visuals or collision.

6. Save `actor.tscn` with `Ctrl+S`.

   `Actor` does not appear in the running project yet because it has not been
   added to `Main`. The next lesson will specialize this shared scene into a
   player before placing it in the project.

> ⚠️ **If something differs**
>
> - If `Visuals` or `Components` appears beneath `CollisionShape2D`, drag it
>   onto `Actor` so all three nodes are direct children of the root.
> - If either attachment point has a different name, rename it exactly as
>   shown. Later lessons will rely on this shared structure.
> - If running the project changes nothing beyond the existing text and icon,
>   that is expected. This lesson creates a reusable scene but does not
>   instantiate it in `Main`.

## Learner exercise

Without repeating the build steps:

1. Add a `Node2D` named `ExampleComponent` beneath `Components`.
2. Explain why an optional behavior belongs under `Components` instead of
   `Visuals`.
3. Remove `ExampleComponent` and confirm that `Visuals` and
   `CollisionShape2D` remain unchanged.
4. Save `actor.tscn` with only the three intended children beneath `Actor`.

## Verification checklist

- [ ] `res://actors/actor.tscn` exists.
- [ ] Its root is a `CharacterBody2D` named `Actor`.
- [ ] `Visuals` is a direct `Node2D` child of `Actor`.
- [ ] `CollisionShape2D` is a direct child of `Actor` and contains a
      `RectangleShape2D` with Size `(32, 32)`.
- [ ] `Components` is a direct `Node2D` child of `Actor`.
- [ ] The shared scene contains no script or actor-specific gameplay features.
- [ ] The learner can explain why `CharacterBody2D` is the shared root.
- [ ] The learner can explain the different roles of `Visuals`,
      `CollisionShape2D`, and `Components`.
- [ ] A temporary child can be added to and removed from `Components` without
      changing the other branches.
- [ ] Running the project still displays `Project ready` and the project icon
      without related errors or warnings.

## References

- [Using CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
- [CollisionShape2D](https://docs.godotengine.org/en/4.7/classes/class_collisionshape2d.html)
- [RectangleShape2D](https://docs.godotengine.org/en/4.7/classes/class_rectangleshape2d.html)
- [Scene organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html)
