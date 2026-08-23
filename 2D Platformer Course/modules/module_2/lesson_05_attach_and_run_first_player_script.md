# Module 2, Lesson 5: Attach and Run Your First Player Script

**Status:** Validated

## By the end

Attach the first script to `Player`, print a simple message in Godot's Output
panel, and compare local and script-level variables. You will build the script
one part at a time, then remove the temporary diagnostic code so the project is
ready for movement in the next lesson.

## Before you start

- Module 2, Lesson 4 is complete.
- `res://actors/player.tscn` inherits from `res://actors/actor.tscn`.
- `main.tscn` contains one Player instance.
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

`func` starts a **function**. A function is simply a named group of instructions.

Some functions are **callbacks**. Godot calls these functions automatically at
specific moments. `_ready()` is a Godot callback that runs when the Player is
ready in the running scene.

`-> void` is a **type hint** that describes the type of value a function
returns. `void` is used when no value is returned. The next lesson explores
functions that do return a value.

A function needs at least one indented instruction; otherwise, Godot reports an error. You can use `pass`, which simply means “do nothing,” to keep a function valid while you add its instructions later.

> ⚠️ **If something differs**
>
> - If Godot marks the function as an error, confirm that `pass` is indented
>   beneath the line ending in `:`.
> - Use the same indentation for every instruction that belongs to this
>   function.

### Part 3: Print a temporary message

1. Delete the indented `pass` line.
2. In its place, add these two indented lines:

   ```gdscript
   var message: String = "Player is ready"
   print(message)
   ```

The complete temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
    var message: String = "Player is ready"
    print(message)
```

3. Save the script with `Ctrl+S`.

`message` applies the variable and `String` type-hint syntax from Lesson 2.4.
The text between quotation marks is its value.

`print(message)` sends the value of that variable to the **Output** panel,
located under the main viewport. `print()` is often used only for testing.

> 💡 Because the variable `message` is declared inside `_ready()`, it
> has **local scope**: it can be used only inside that function, not outside or
> in another function.

4. Open `res://scenes/main.tscn`.
5. In the **Output** panel, select **Clear** if it contains messages from an
   earlier run.
6. Run the current scene with `F6`.
7. Find `Player is ready` in the **Output** panel at the bottom of the editor.
8. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If no message appears, confirm that `main.tscn` is open, `player.gd` is attached to the Player
>   root, the script was saved, and the **Output** panel is open.
> - If the script editor shows an error, compare the spelling, punctuation,
>   and indentation with the complete script above.

### Part 4: Compare local and script-level scope

1. Beneath the complete `_ready()` function, add this new function:

   ```gdscript
   func show_message() -> void:
       print(message)
   ```

The complete temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
    var message: String = "Player is ready"
    print(message)

func show_message() -> void:
    print(message)
```

> 💡 `show_message()` is a **custom function**: you give it a name and choose
> the instructions it contains. Unlike `_ready()`, Godot does not call it
> automatically. A custom function can help you avoid writing the same large
> block of instructions multiple times: write the instructions once, then call
> the function by name when needed.

2. Save the script with `Ctrl+S`.

Godot reports an error because it cannot find `message` inside
`show_message()`. The variable was created inside `_ready()`, so it
can be used only there.

3. Move the `var message: String = "Player is ready"` line out of `_ready()`
   and place it directly beneath `extends CharacterBody2D`. Make sure it is no longer indented and do not leave a copy inside `_ready()`.

   The script now reads:

   ```gdscript
   extends CharacterBody2D

   var message: String = "Player is ready"

   func _ready() -> void:
       print(message)

   func show_message() -> void:
       print(message)
   ```

4. Save the script with `Ctrl+S`. The scope error disappears.
5. Open `res://scenes/main.tscn`. In the **Output** panel, select **Clear** so
   you can compare this run by itself.
6. Run the current scene with `F6`.
7. The Output panel shows `Player is ready` only once. `_ready()` runs
   automatically, but `show_message()` does not run yet because nothing calls
   it.
8. Stop the running scene with `F8`.
9. In `_ready()`, add this indented line beneath `print(message)`:

   ```gdscript
   show_message()
   ```

   The complete temporary script is:

   ```gdscript
   extends CharacterBody2D

   var message: String = "Player is ready"

   func _ready() -> void:
       print(message)
       show_message()

   func show_message() -> void:
       print(message)
   ```

10. Save the script with `Ctrl+S`. In the **Output** panel, select **Clear**,
    then run `main.tscn` with `F6` again.
11. The Output panel now shows `Player is ready` twice. `_ready()` prints the
    first line, then calls `show_message()`, which prints the second. You call
    a custom function by typing its name followed by parentheses.
12. Stop the running scene with `F8`.
13. Change the variable's text from `"Player is ready"` to `"Hello World!"`.

   ```gdscript
   extends CharacterBody2D

   var message: String = "Hello World!"

   func _ready() -> void:
       print(message)
       show_message()

   func show_message() -> void:
       print(message)
   ```

14. Save the script with `Ctrl+S`. In the **Output** panel, select **Clear**,
    then run `main.tscn` with `F6` again.
15. The Output panel now shows `Hello World!` twice. You could write
    `print("Hello World!")` directly in both functions, but the variable gives
    that text one place to change. Both `print()` calls use the variable's
    updated value.
16. Stop the running scene with `F8`.

> 💡 A variable declared directly in the script, outside every function, has
> **script-level scope**. Any function in this Player script can use it. It is
> still not a project-wide variable: each Player node has its own `message`
> value.

> ⚠️ **If something differs**
>
> - The error in step 2 is expected. After step 4, confirm that the variable
>   was moved, rather than copied, so only one `var message` line remains.
> - If the Output panel shows only one line after step 11 or 15, confirm that
>   `show_message()` is indented inside `_ready()` and that the script was
>   saved.

### Part 5: Remove the temporary diagnostic

1. Delete the complete `_ready()` and `show_message()` functions, including their indented lines.
2. Leave this single line in `player.gd`:

   ```gdscript
   extends CharacterBody2D
   ```

3. Save the script with `Ctrl+S`.

The temporary message proved that the script ran correctly and showed the
difference between a callback and a custom function. Removing the diagnostic
keeps the script focused and gives the next lesson a clean starting point.

## Learner exercise

Without adding the temporary code again, explain:

1. Why did `show_message()` produce an error before `message` was moved outside
   `_ready()`?
2. Why did the Output panel show one line after the variable moved, but before
   `_ready()` called `show_message()`?
3. Why did the Output panel show two lines after `_ready()` called
   `show_message()`?
4. Why did changing the script-level `message` variable change both printed
   lines?
5. What line remains in `player.gd`, and what does it tell GDScript?

## Verification checklist

- [ ] `res://actors/player.gd` exists and is attached to the Player root.
- [ ] I can explain what `extends CharacterBody2D` means.
- [ ] I can explain what a function and a Godot callback are.
- [ ] I know that `-> void` means the function returns no value.
- [ ] I used `pass` as a temporary instruction and then replaced it.
- [ ] Running `main.tscn` printed `Player is ready` in the Output panel.
- [ ] I saw why a local `message` variable caused an error in another function.
- [ ] I can explain the difference between local and script-level scope.
- [ ] I called `show_message()` from `_ready()` and saw the message twice.
- [ ] I changed `message` once and saw both printed lines use its updated value.
- [ ] The temporary `_ready()` diagnostic has been removed.
- [ ] `player.gd` ends with only `extends CharacterBody2D`.
- [ ] No input or physics behavior has been added yet.

## References

- [Creating your first script](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/scripting_first_script.html)
- [Output panel](https://docs.godotengine.org/en/4.7/tutorials/scripting/debug/output_panel.html)
- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
