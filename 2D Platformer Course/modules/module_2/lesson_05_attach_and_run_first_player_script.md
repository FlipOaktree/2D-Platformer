# Module 2, Lesson 5: Attach and Run Your First Player Script

**Status:** Validated

## By the end

Attach the first script to `Player`, run a small piece of code, and read the
Player's starting position in Godot's Output panel. You will build the script
one part at a time, then remove the temporary diagnostic code so the project is
ready for movement in the next lesson.

## Before you start

- Module 2, Lesson 4 is complete.
- `res://actors/player.tscn` inherits from `res://actors/actor.tscn`.
- `main.tscn` contains one Player instance at Position `(128, 128)`.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Attach an empty script to Player

1. Open `res://actors/player.tscn`.
2. In the Scene dock, select the `Player` root node.
3. Select **Attach Script** from the Scene dock toolbar, or right-click
   `Player` and select **Attach Script**.
4. In the Create Script dialog, keep **Language** set to **GDScript**.
5. Set **Template** to **Object: Empty**.
6. Set **Path** to `res://actors/player.gd`.
7. Select **Create**.

> 💡 A script adds instructions and behavior to the node it is attached to. This script belongs on `Player`, not the shared `Actor`, because later it will read the player's controls.

The new script contains one line:

```gdscript
extends CharacterBody2D
```

`extends` tells GDScript which kind of node the script builds on—in this case,
`CharacterBody2D`. That gives the script access to the properties and methods
provided by `CharacterBody2D`.

> ⚠️ **If something differs**
>
> - If the script contains extra code, confirm that **Template** was set to
>   **Object: Empty**. For this lesson, remove everything except
>   `extends CharacterBody2D`.
> - If the script was attached to `Actor`, detach it there and attach it to the
>   `Player` root instead. Shared Actor must remain free of player-specific
>   behavior.

### Part 2: Add a function Godot runs automatically

1. Add the following code beneath `extends CharacterBody2D`, including the indentation before `pass`:

   ```gdscript
   func _ready() -> void:
       pass
   ```

The script now reads:

```gdscript
extends CharacterBody2D

func _ready() -> void:
    pass
```

`func` starts a **function**. A function is a named group of instructions. You can create your own function to avoid writing the same large block of code multiple times: write the instructions once inside a function, then call that function by name when needed. We will explore this more later.

Some functions are **callbacks**. Godot calls these functions automatically at
specific moments. `_ready()` is a Godot callback that runs when the Player is
ready in the running scene.

`-> void` is a **type hint** that describes the type of value a function
returns. Some functions return a value; others do not. `void` tells GDScript
that this function does not return a value. We will explore returned values
later.

A function needs at least one indented instruction; otherwise, Godot reports an error. You can use `pass`, which simply means “do nothing,” to keep a function valid while you add its instructions later.

> ⚠️ **If something differs**
>
> - If Godot marks the function as an error, confirm that `pass` is indented
>   beneath the line ending in `:`.
> - Use the same indentation for every instruction that belongs to this
>   function.

### Part 3: Print the Player's starting position

1. Delete the indented `pass` line.
2. In its place, add these two indented lines:

   ```gdscript
   var starting_position: Vector2 = position
   print(starting_position)
   ```

The complete temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
    var starting_position: Vector2 = position
    print(starting_position)
```

3. Save the script with `Ctrl+S`.

`var starting_position: Vector2 = position` creates a new variable that stores
the Player's position. `position` is a built-in **property**. A property is a
value that belongs to a node, and every node type has its own set of
properties. `position` is a `Vector2` value that stores the node’s X and Y
position. Godot node types can be built on top of other node types.
`CharacterBody2D` is built on `Node2D`, so it inherits `Node2D`’s `position`
property.

`print(starting_position)` sends the value of that variable to the **Output** panel, located under the main viewport. `print()` is often used only for testing.

> 💡 Because the variable `starting_position` is declared inside `_ready()`, it
> has **local scope**: it can be used only inside that function, not outside or
> in another function.

4. Open `res://scenes/main.tscn`.
5. Run the current scene with `F6`.
6. Find `(128.0, 128.0)`, `(128, 128)`, or an equivalent value in the
   **Output** panel at the bottom of the editor. The output matches the Player
   instance's position in `main.tscn`.
7. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the output is `(0, 0)`, you may have run `player.tscn` by itself. Open
>   `main.tscn` and use `F6` so the Player instance uses its `(128, 128)`
>   position from Main.
> - If no position appears, confirm that `player.gd` is attached to the Player
>   root, the script was saved, and the **Output** panel is open.
> - If the script editor shows an error, compare the spelling, punctuation,
>   and indentation with the complete script above.

### Part 4: Test local scope

1. Beneath the complete `_ready()` function, add this new function:

   ```gdscript
   func show_starting_position() -> void:
       print(starting_position)
   ```

The complete temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
    var starting_position: Vector2 = position
    print(starting_position)

func show_starting_position() -> void:
    print(starting_position)
```

2. Save the script with `Ctrl+S`.

Godot reports an error because it cannot find `starting_position` inside
`show_starting_position()`. The variable was created inside `_ready()`, so it
can be used only there.

> 💡 `show_starting_position()` is a **custom function**: you give it a name
> and choose the instructions it contains. Unlike `_ready()`, Godot does not
> call it automatically.

### Part 5: Remove the temporary diagnostic

1. Delete the complete `_ready()` and `show_starting_position()` functions, including their indented lines.
2. Leave this single line in `player.gd`:

   ```gdscript
   extends CharacterBody2D
   ```

3. Save the script with `Ctrl+S`.

The position output proved that the script ran correctly. Removing that
temporary diagnostic keeps the script focused and gives the movement lesson a
clean starting point.

## Learner exercise

Without adding the temporary code again, explain:

1. Why did the Output panel report the Player's position as `(128, 128)` when
   you ran `main.tscn`?
2. Why could `starting_position` be used only inside `_ready()`?
3. What line remains in `player.gd`, and what does it tell GDScript?

## Verification checklist

- [ ] `res://actors/player.gd` exists and is attached to the Player root.
- [ ] I can explain what `extends CharacterBody2D` means.
- [ ] I can explain what a function and a Godot callback are.
- [ ] I know that `-> void` means the function returns no value.
- [ ] I used `pass` as a temporary instruction and then replaced it.
- [ ] Running `main.tscn` printed the Player's starting position in the Output
      panel.
- [ ] I can explain why `starting_position` had local scope.
- [ ] The temporary `_ready()` diagnostic has been removed.
- [ ] `player.gd` ends with only `extends CharacterBody2D`.
- [ ] No input or physics behavior has been added yet.

## References

- [Creating your first script](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/scripting_first_script.html)
- [Output panel](https://docs.godotengine.org/en/4.7/tutorials/scripting/debug/output_panel.html)
- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
