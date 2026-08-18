# Module 2, Lesson 4: Understand GDScript Fundamentals

**Status:** Validated

## By the end

Understand the small set of GDScript building blocks needed to read and write
the Player movement script in the next lesson: values, variables, types,
operators, and indentation.

This is a code-reading lesson. You will not attach a script or change the
Godot project yet. Its purpose is to make the first gameplay script feel
understandable rather than mysterious.

## Before you start

- Module 2, Lesson 3 is complete.
- You understand that `Player` is a `CharacterBody2D` scene inherited from
  `Actor`.
- `main.tscn` contains the Player instance that later lessons will control.

## Build steps

### Part 1: Meet GDScript

**GDScript** is Godot's own programming language. Its layout is similar to Python because both use indentation to group instructions, but GDScript is a separate language designed to work closely with Godot. A script is a text file containing instructions. Godot reads those instructions when the game runs.

Read this short script:

   ```gdscript
   func greet() -> void:
       print("Hello, Player!")
   ```

Notice that the `print("Hello, Player!")` line is indented beneath theline above it. The indentation tells GDScript that those lines belong together. For now, the important thing to understand is that indentation matters.

> ⚠️ **If something differs**
>
> - Do not create or attach a script in this lesson. The code blocks are small examples to read, not project files to copy yet.
> - In a later script, make sure lines inside the same code group have the
>   same indentation. Incorrect indentation changes which instructions belong
>   together and causes an editor error.

### Part 2: Store values with variables

A **variable** gives a **value** a name so code can read or change it later. Instead of repeating a value multiple times, use the variable’s name. When its value changes, every later use of that variable uses the updated value.

> 💡 Here are the main value types you will use first:
>
> - `int` for whole numbers, such as `3` or `-10`. An `int` could be used for
>   the Player’s remaining lives.
> - `float` for decimal numbers, such as `10.2` or `-6.5`. A `float` could be
>   used for movement speed.
> - `bool` for `true` or `false`. A `bool` could track whether the Player is on
>   the ground.
> - `String` for text, such as `"Player"`. A `String` could be used for the
>   Player’s name.
> - `Vector2` for an X/Y pair, such as `Vector2(5.4, 8.1)`. A `Vector2` could
>   be used for the Player’s position.

Read the following script:
   
   ```gdscript
   var player_name: String = "Mina"
   var lives: int = 3
   var speed: float = 300.0
   var is_grounded: bool = false
   var spawn_position: Vector2 = Vector2(128.0, 128.0)
   ```

Read each line as “create a new variable, name it, and assign it a value.” Let's break down the first line `var player_name: String = "Mina"`:
   - `var` declares that you are creating a variable.
   - `player_name` is the name of the variable.
   - `String` is the type hint, which specifies the variable's value type.
   - `=` assigns the value to the variable.
   - `"Mina"` is the variable's value.

> 💡 **Type hints** are optional in GDScript. This course uses type hints
> because they let Godot catch more mistakes in the editor before the game
> runs.

### Part 3: Combine and compare values with operators

1. Read this example:

   ```gdscript
   var coins: int = 2

   coins += 1
   ```

Note that we only use `var` the first time we create a variable.

In `coins += 1`, the `+=` operator adds `1` to the current value of the variable (`2`). The new value of `coins` is `3`.

> 💡 Here are the meanings of the different operators you will use in this course:
>
> - `+` adds values. `+=` adds a value to the variable’s current value.
> - `-` subtracts values. `-=` subtracts a value from the variable’s current
>   value.
> - `*` multiplies values. `*=` multiplies the variable’s current value by a
>   value.
> - `/` divides values. `/=` divides the variable’s current value by a value.
> - `=` assigns a value to a variable.
> - `==`, `>=`, and `<` compare values and produce `true` or `false`.
> - `and`, `or`, and `not` combine or reverse `true`/`false` values.

> 💡 `=` and `==` look similar but answer different questions. `coins = 3`
> stores `3` in `coins`. `coins == 3` asks whether the current value of
> `coins` is `3`. In short, `=` assigns and `==` compares. Reading that
> distinction carefully prevents many beginner mistakes.

## Learner exercise

Without running any code, answer these questions:

```gdscript
var coins: int = 2
var speed: float = 300.0
var is_dead: bool = false

speed -= 100.0
```

1. What are the names of each variable?
2. What is the value of `coins`?
3. What is the value type of `is_dead`?
4. What is the new value of `speed` after `speed -= 100.0`?

## Verification checklist

- [ ] I can explain what GDScript is and why it is used in this Godot course.
- [ ] I know that indentation groups related instructions.
- [ ] I can identify a variable, its value and type hint.
- [ ] I can recognize `int`, `float`, `bool`, `String`, and `Vector2` values.
- [ ] I can explain the difference between `=` and `==`.
- [ ] I can read basic arithmetic, assignment, comparison, and logical operators.

## References

- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
- [Creating your first script](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/scripting_first_script.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
