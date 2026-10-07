# Module 2, Lesson 4: Understand GDScript Fundamentals

**Status:** Validated

## Lesson goals

Understand the small set of GDScript building blocks needed to read and write
the Player scripts introduced over the next lessons: comments, values,
variables, types, operators, and indentation. Horizontal movement begins in
Lesson 2.8 after three short programming bridges.

This is a code-reading lesson. You will not attach a script or change the
Godot project yet. Its purpose is to make the first gameplay script feel
understandable rather than mysterious.

- Learning what a comment, a value, a variable, and a type each are
- Learning which operators the Player script uses, and what each one does
- Understanding why GDScript treats indentation as part of the code

## Before you start

- Module 2, Lesson 3 is complete.
- You understand that `Player` is a `CharacterBody2D` scene inherited from
  `Actor`.
- `main.tscn` contains the Player instance that later lessons will control.

## Build steps

### Part 1: Meet GDScript

Programming is a way to give a computer instructions by writing text. This course uses GDScript, Godot’s own programming language. Its layout is similar to Python’s because both use indentation to group instructions, but GDScript is a separate language designed to work closely with Godot.

A script is a text file containing instructions. When Godot runs a group of instructions, it normally follows the lines from top to bottom.

Look at this short script:

   ```gdscript
   func greet() -> void:
   	var greeting: String = "Hello!"
   	print(greeting)
   ```

For now, focus on the indentation. Both `var greeting: String = "Hello!"` and
`print(greeting)` are indented beneath `func greet() -> void:`. The indentation
is important because it tells GDScript that those lines belong together.


> ⚠️ **If something differs**
>
> - Do not create or attach a script in this lesson. The code blocks are small examples to read, not project files to copy yet.
> - In a later script, make sure lines inside the same code group have the
>   same indentation. Incorrect indentation changes which instructions belong
>   together and causes an editor error.

### Part 2: Store values with variables

A **variable** assigns a name to a **value**. Instead of repeating a value multiple times, use the variable’s name so when its value changes, every later use of that variable uses the updated value.

For example, suppose “my car” refers to a Ford. Your to-do list says “wash my
car” and “check my car's tires”. When you replace the Ford with a Nissan, both
tasks now refer to the Nissan without rewriting the list. Had you written
“Ford” in each task, you would have to change each one. A variable works
similarly: its name stays the same, and code can use that name in several
places. Change its value once, and each later use reads the new value.

A value's **type** describes what kind of information it stores. The first types used in this course are whole numbers, decimal numbers, true-or-false values, text, and two-coordinate positions.

| Type      | Description                            | Example             | Possible Player use            |
| --------- | -------------------------------------- | ------------------- | ------------------------------ |
| `int`     | Whole numbers                          | `3` or `-10`        | Remaining lives                |
| `float`   | Numbers that can include decimals      | `10.2` or `-6.5`    | Movement speed                 |
| `bool`    | True-or-false values                   | `true` or `false`   | Whether the Player is grounded |
| `String`  | Text                                   | `"Alex"`            | The Player's name              |
| `Vector2` | Two numbers stored together as x and y | `Vector2(5.4, 8.1)` | The Player's position          |

Read the following script:

   ```gdscript
   var player_name: String = "Mina"
   var lives: int = 3
   var speed: float = 450.0
   var is_grounded: bool = false
   var spawn_position: Vector2 = Vector2(128.0, 128.0)
   ```

Let's break down the first line `var player_name: String = "Mina"`:
   - `var` declares that you are creating a variable.
   - `player_name` is the name of the variable.
   - `String` is the type hint, which specifies the variable's value type.
   - `=` assigns the value to the variable.
   - `"Mina"` is the variable's value.

So, you read each line as “create a new variable, name it, and assign it a value.” :
   - `var player_name: String = "Mina"` means: create a variable named `player_name` that holds text, and assign it the value `"Mina"`.
   - `var lives: int = 3` means: create a variable named `lives` that holds whole numbers, and assign it the value `3`.
   - Etc.

> 💡 Although **type hints** are optional in GDScript, this course uses them to specify the type each variable can hold. This helps Godot catch mistakes if you later try to assign a value of an incompatible type.

### Part 3: Combine and compare values with operators

1. Read this example:

   ```gdscript
   var coins: int = 2

   coins = 4
   coins += 1
   ```

We use `var` and a type hint only when we first create a variable. After that,
we use its name whenever we read or update its value. In `coins = 4`, the `=`
operator assigns a new value, so `coins` becomes `4`. In `coins += 1`, the `+=`
operator adds `1` to its current value, so `coins` becomes `5`.

> 💡 An **operator** is a symbol or keyword that performs an action with one
> or more values. Operators can calculate a result, update a variable, compare
> values, or combine true-or-false conditions.

| Operators | Purpose |
| --- | --- |
| `+`, `-`, `*`, `/` | Calculate with values |
| `+=`, `-=`, `*=`, `/=` | Calculate and store the result in the variable |
| `=` | Assign a value to a variable |
| `==`, `>=`, `<` | Compare values and produce `true` or `false` |
| `and`, `or`, `not` | Combine or reverse `true`/`false` values |

> 💡 `=` and `==` look similar but answer different questions. `coins = 5`
> assigns `5` in `coins`. `coins == 5` asks whether the current value of `coins`
> is `5`. In short, `=` assigns and `==` compares. Reading that distinction
> carefully prevents many beginner mistakes.

### Part 4: Use comments to explain code

Read this example:

```gdscript
# Start with two coins so the Player must collect one in the test level.
var coins: int = 2
```

The line starting with `#` is a **comment**. Godot ignores it when the game runs. Comments help people reading the code understand why a choice was made. Keep them short, and use them to add useful context instead of repeating what an obvious line already says.

> 💡 Comments can appear on their own lines or at the end of a line of code.

## Learner exercise

Without running any code, answer these questions:

```gdscript
var coins: int = 2
var speed: float = 450.0 # Start with enough speed for the Player to cross the level.
var is_dead: bool = false

speed -= 100.0
```

1. What are the names of each variable?
2. What is the value of `coins`?
3. What is the value type of `is_dead`?
4. What does the comment say?
5. What is the new value of `speed` after the end of the script?

## Verification checklist

- [ ] The learner can explain what GDScript is and why it is used in this
    Godot course.
- [ ] The learner knows that indentation groups related instructions.
- [ ] The learner can identify a comment and explain why it is useful.
- [ ] The learner can identify a variable, its value and type hint.
- [ ] The learner can recognize `int`, `float`, `bool`, `String`, and
    `Vector2` values.
- [ ] The learner can explain the difference between `=` and `==`.
- [ ] The learner can read basic arithmetic, assignment, comparison, and
    logical operators.

## References

- [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html)
- [Creating your first script](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/scripting_first_script.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
