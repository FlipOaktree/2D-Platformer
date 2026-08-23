# Module 2, Lesson 7: Access Properties and Call Methods

**Status:** Validated

## By the end

Read two common uses of the period in GDScript: accessing a property and
calling a method. You will print the Player's horizontal position,
call a `String` method with an argument, and distinguish property access from
a method call.

The examples are temporary. You will remove them at the end so the Player
script is ready for movement.

## Before you start

- Module 2, Lesson 6 is complete.
- `res://actors/player.gd` is attached to the Player root and contains only
  `extends CharacterBody2D`.
- `main.tscn` contains one Player instance at Position `(128, 128)`.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Prepare the callback

1. Open `res://actors/player.gd`.
2. Add the familiar temporary callback beneath `extends CharacterBody2D`:

   ```gdscript
   func _ready() -> void:
       pass
   ```

3. Save the script with `Ctrl+S`.

The temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
    pass
```

> ⚠️ **If something differs**
>
> - If Godot reports an error, confirm that the function line ends with `:`
>   and that `pass` is indented beneath it.

### Part 2: Access a property with a period

1. Delete the indented `pass` line.
2. In its place, add:

   ```gdscript
   print(position.x)
   ```

3. Save the script with `Ctrl+S`.

> 💡 You have already changed node properties in the Inspector. `position` is
> the Player's inherited `Vector2` property. In `position.x`, the period
> accesses the X value within that `Vector2`.

4. Open `res://scenes/main.tscn`.
5. In the **Output** panel, select **Clear** if it contains earlier messages.
6. Run the current scene with `F6`.
7. Confirm that the Output panel reports the Player's horizontal position as
   `128.0` or an equivalent representation.
8. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If the Output reports `0.0`, confirm that you ran `main.tscn`, not
>   `player.tscn`, and that the Player instance in `main.tscn` has Position
>   `(128, 128)`.
> - If no value appears, confirm that `player.gd` is attached to the Player
>   root, the script is saved, and the Output panel is open.

### Part 3: Call a method with a period

1. Return to `res://actors/player.gd`.
2. Add this local variable above `print(position.x)`:

   ```gdscript
   var player_name: String = "Player"
   ```

3. Add this line beneath `print(position.x)`:

   ```gdscript
   print(player_name.begins_with("Play"))
   ```

The callback now reads:

```gdscript
func _ready() -> void:
    var player_name: String = "Player"
    print(position.x)
    print(player_name.begins_with("Play"))
```

A **method** is a function that belongs to something, such as a node or a value. For example, `add_coins()` from the previous lessons is a method, as it belongs to the Player script. `print()` on the other hand, is a globally available function: it does not belong to a particular node or value, so it is not a method.

In `player_name.begins_with("Play")`, the period accesses the method `begins_with()` and the parentheses call it. `begins_with()` is a built-in method belonging to String values. The method checks whether the text in `player_name` starts with the supplied argument. It returns a `bool`, just as the custom function in Lesson 2.6 returned an `int`.

> 💡 Between **functions**, **callbacks**, and **methods**, it can become
> confusing. Although they are closely related, they have specific definitions.
>
> A **function** is a named group of instructions. A **method** is a function
> that belongs to a node or a value. A **callback** is a function automatically
> called at a specific time.
>
> All methods and callbacks are functions. Not all functions are methods or
> callbacks. `print()` is only a function; `_ready()` is a function, a method,
> and a callback.

So, for both **properties** and **methods**, the period (.) is used essentially the same way; simply to access something that belongs to whatever's on the left.
- `position.x` accesses the `x` property belonging to the `position` value.
- `player_name.begins_with("Play")` accesses the `begins_with()` method belonging to the `player_name` value.

4. Save the script, clear the Output panel, and run `main.tscn` with `F6`.
5. Confirm that the Output reports the horizontal position followed by
   `true`.
6. Stop the running scene with `F8`.
7. Change the argument from `"Play"` to `"Enemy"`:

   ```gdscript
   print(player_name.begins_with("Enemy"))
   ```

8. Save, clear the Output panel, and run `main.tscn` again.
9. Confirm that the Output now reports the horizontal position followed by
   `false`.
10. Stop the running scene with `F8`.

The value stored in `player_name` did not change. The result changed because
the method received a different argument.

> ⚠️ **If something differs**
>
> - If Godot reports that the method does not exist, confirm that
>   `begins_with` is lowercase and contains an underscore.
> - If the result is unexpected, compare the argument with the beginning of
>   the exact text stored in `player_name`. Capitalization matters.

### Part 4: Remove the temporary example

1. Return to `res://actors/player.gd`.
2. Delete the complete `_ready()` function and its contents.
3. Leave only:

   ```gdscript
   extends CharacterBody2D
   ```

4. Save the script with `Ctrl+S`.

> ⚠️ **If something differs**
>
> - If an error remains, confirm that no indented lines from `_ready()` were
>   left beneath `extends CharacterBody2D`.
> - If the temporary values still appear, save `player.gd`, clear the Output
>   panel, and run `main.tscn` again.

## Learner exercise

Without adding the temporary code again:

1. In `position.x`, identify what appears on the left and what the period
   accesses.
2. In `player_name.begins_with("Play")`, identify the value, method, argument,
   and returned value type.
3. Explain why `begins_with("Play")` includes parentheses but `position.x`
   does not.

## Verification checklist

- [ ] `position.x` reports the Player's horizontal position from `main.tscn`.
- [ ] `player_name.begins_with("Play")` reports `true`.
- [ ] Changing the argument to `"Enemy"` makes the method report `false`.
- [ ] I can explain that a property stores a value belonging to something.
- [ ] I can explain that a method is a function belonging to something.
- [ ] I can distinguish property access from a method call by the parentheses.
- [ ] `res://actors/player.gd` ends with only `extends CharacterBody2D`.

## References

- [GDScript basics](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
- [String](https://docs.godotengine.org/en/4.7/classes/class_string.html)
- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
