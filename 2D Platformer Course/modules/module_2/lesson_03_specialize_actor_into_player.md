# Module 2, Lesson 3: Specialize Actor into a Player

**Status:** Validated

## By the end

Create a reusable `Player` scene that inherits the shared structure from
`Actor`, then add one `Player` instance to `Main`. The finished project will
contain:

- `res://actors/player.tscn`, inherited from `res://actors/actor.tscn`.
- A `CharacterBody2D` root named `Player`.
- The inherited `Visuals`, `CollisionShape2D`, and `Components` children.
- One `Player` instance in `main.tscn` at Position `(128, 128)`.

The player will not move or display artwork yet. With collision shapes visible
for debugging, its square collision boundary will appear when the project runs.

## Before you start

- Module 2, Lesson 2 is complete.
- `res://actors/actor.tscn` contains the validated shared Actor structure.
- `main.tscn` displays `Project ready` and contains one `ProjectIcon` instance.
- The project opens and runs without related errors or warnings.

## Build steps

### Part 1: Create an inherited Player scene

1. In the FileSystem dock, right-click `res://actors/actor.tscn`.
2. Select **New Inherited Scene**.
3. Confirm that a new unsaved scene opens with `Actor` as its root and the
   inherited `Visuals`, `CollisionShape2D`, and `Components` children.
4. Rename the root node `Player`.

> 💡 A new inherited scene starts with another scene's saved structure and
> keeps a link to it. `Player` receives the shared Actor children, while the
> inherited scene can add or override details that belong only to a player.
> Later changes to shared, non-overridden Actor details will also reach Player.
> This keeps common actor structure in one place without copying it.

5. Save the scene with `Ctrl+S`.
6. In the `actors` folder, enter `player.tscn` as the file name, then select
   **Save**.
7. Confirm that `res://actors/player.tscn` appears in the FileSystem dock.
8. Confirm that the open Player scene still contains this structure:

   ```text
   Player
   ├── Visuals
   ├── CollisionShape2D
   └── Components
   ```

> ⚠️ **If something differs**
>
> - If the open tab is `actor.tscn` instead of a new unsaved inherited scene,
>   do not rename or save it. In the FileSystem dock, right-click `actor.tscn`
>   and select **New Inherited Scene**.
> - If the new scene has an empty root or copied children that can be freely
>   removed, it was created as an independent scene. Close that unsaved scene
>   and create a new inherited scene from `actor.tscn`.
> - If the scene was saved in the wrong folder, use **Scene → Save Scene As**
>   and save it at `res://actors/player.tscn`.

### Part 2: Add Player to Main

1. Open `res://scenes/main.tscn`.
2. Select `Main` in the Scene dock.
3. Select **Instantiate Child Scene**.
4. In the file dialog, open `res://actors/player.tscn`.
5. Confirm that a `Player` instance appears as a direct child of `Main`.
6. With `Player` selected, find **Transform** in the Inspector and set
   **Position** to `(128, 128)`.
7. Save `main.tscn` with `Ctrl+S`.

> 💡 Scene inheritance and scene instancing solve different problems here.
> `player.tscn` **inherits** `actor.tscn` so it can specialize the shared Actor
> design. `Main` **instances** `player.tscn` so one usable Player exists in the
> running scene. Changes saved to the Player source scene can reach its
> instances, while an override on one instance stays with that placement.

> ⚠️ **If something differs**
>
> - If `Player` appears beneath `Label` or `ProjectIcon`, drag it onto `Main`
>   so it becomes a direct child.
> - If the instantiated node is named `Actor`, reopen `player.tscn`, rename its
>   root `Player`, save it, then return to `main.tscn`.
> - If the Inspector shows Position `(0, 0)`, select the Player instance in
>   `Main`, not the root of the Player source scene, and set `(128, 128)` there.

### Part 3: Verify the invisible Player

1. In the top editor menu bar, select **Debug → Visible Collision Shapes** so the option is enabled.
2. Run the project with `F6` or **Run Current Scene** while `main.tscn` is open.
3. Confirm that `Project ready` and the project icon still appear.
4. Confirm that a square collision outline appears around `(128, 128)`.
5. Stop the running project with `F8`.

> 💡 `CollisionShape2D` defines physics, not artwork. **Visible Collision
> Shapes** is a debugging view that lets you inspect collision boundaries while
> the game runs. It does not turn the shape into a player visual or change what
> an exported game displays.

> ⚠️ **If something differs**
>
> - If no collision outline appears, confirm that **Visible Collision Shapes**
>   is enabled and that `Player` is present beneath `Main`.
> - If the outline appears at the top-left corner, stop the project and confirm
>   that the Player instance in `Main` has Position `(128, 128)`.
> - If the project shows no new artwork, that is expected. A later lesson will
>   add the player's visual branch.

## Learner exercise

Without repeating the build steps:

1. Open `player.tscn` and add a temporary `Marker2D` beneath `Visuals`.
2. Rename it `PlayerOnlyMarker`.
3. Open `actor.tscn` and confirm that `PlayerOnlyMarker` was not added to the
   shared Actor scene.
4. Return to `player.tscn`, remove `PlayerOnlyMarker`, and save the scene.
5. Explain why the movement script added later in Lesson 2.8 should belong to
   `Player` instead of the shared `Actor`.

## Verification checklist

- [ ] `res://actors/player.tscn` exists and inherits `actor.tscn`.
- [ ] Its root is a `CharacterBody2D` named `Player`.
- [ ] `Visuals`, `CollisionShape2D`, and `Components` remain inherited children.
- [ ] The Player scene contains no script, movement, camera, or artwork yet.
- [ ] `main.tscn` contains one direct `Player` instance at Position
      `(128, 128)`.
- [ ] Running `main.tscn` still displays `Project ready` and the project icon.
- [ ] **Visible Collision Shapes** reveals the Player collision boundary at its
      expected position.
- [ ] A Player-only child can be added and removed without changing
      `actor.tscn`.
- [ ] The learner can explain the difference between inheriting a scene and
      instancing a scene.
- [ ] The learner can explain why player-specific behavior does not belong in
      the shared Actor scene.

## References

- [Godot's design philosophy](https://docs.godotengine.org/en/4.7/getting_started/introduction/godot_design_philosophy.html)
- [Applying object-oriented principles in Godot](https://docs.godotengine.org/en/4.7/tutorials/best_practices/what_are_godot_classes.html)
- [Nodes and scenes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [EditorInterface](https://docs.godotengine.org/en/4.7/classes/class_editorinterface.html)
