# Module 2, Lesson 6: Use Function Parameters and Return Values

**Status:** Validated

## Lesson goals

Pass values into a custom function, return a calculated value, and print the
result in Godot's Output panel. You will use a small coin-total example, then
remove the temporary code so the Player script is ready for movement.

- Writing a function of your own that takes values in and hands a value back
- Learning the names for the parts: parameter, argument, and return value
- Understanding why a function that returns is more reusable than one that
  prints

## Before you start

- Module 2, Lesson 5 is complete.
- `res://actors/player.gd` is attached to the Player root and contains only
  `extends CharacterBody2D`.
- `main.tscn` contains one Player instance.
- The project runs without related errors or warnings.

## Build steps

### Part 1: Prepare the callback

1. Open `res://actors/player.gd`.
2. Add this callback beneath `extends CharacterBody2D`:

   ```gdscript
   func _ready() -> void:
   	pass
   ```

The temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
	pass
```

3. Save the script with `Ctrl+S`.

Use the same `_ready()` and temporary `pass` pattern from Lesson 2.5. You will
replace `pass` with the calculation after creating the custom function.

> ⚠️ **If something differs**
>
> - Confirm that `pass` is indented beneath the line ending in `:`.
> - `pass` is temporary. Do not add the calculation inside `_ready()` yet.

### Part 2: Create a function that receives values

As we saw in Lesson 2.5, a function can *return* a value after following its instructions. It can also *receive* values through **parameters**. Imagine asking a waiter to “Collect payment” and handing him a bill. He takes the bill to the customer, collects the payment, and brings it back to you. The bill is like a value the function receives through a parameter; the payment brought back is like its returned value. The same instructions work with a different bill each time.

1. Beneath the complete `_ready()` function, add this custom function:

   ```gdscript
   func add_coins(current_coins: int, collected_coins: int) -> int:
   	return current_coins + collected_coins
   ```

The script now reads:

```gdscript
extends CharacterBody2D

func _ready() -> void:
	pass

func add_coins(current_coins: int, collected_coins: int) -> int:
	return current_coins + collected_coins
```

2. Save the script with `Ctrl+S`.

`current_coins` and `collected_coins` are parameters. A parameter is a
named value that a function receives and can use while it runs. The `int` type
hints say that both parameters must receive whole numbers.

`-> int` says that `add_coins()` returns an integer. Unlike the `-> void`
function from Lesson 2.5, it sends a value back to the code that called it.

`return current_coins + collected_coins` adds the two values and sends the
result back to the code that called the function.

> ⚠️ **If something differs**
>
> - If Godot reports an error, confirm that the function line ends with `:`
>   and that the `return` line is indented beneath it.
> - Check that `int` and both parameter names are spelled consistently.

### Part 3: Call the function with arguments

1. In `_ready()`, delete the indented `pass` line.
2. In its place, add these two indented lines:

   ```gdscript
   var total_coins: int = add_coins(2, 3)
   print(total_coins)
   ```

> 💡 A variable can store the result of a function call. GDScript runs
> `add_coins(2, 3)` first; the function returns `5`, then `total_coins` stores
> that returned value. The variable stores the result, not the function itself.

The complete temporary script is:

```gdscript
extends CharacterBody2D

func _ready() -> void:
	var total_coins: int = add_coins(2, 3)
	print(total_coins)

func add_coins(current_coins: int, collected_coins: int) -> int:
	return current_coins + collected_coins
```

3. Save the script with `Ctrl+S`.

The values `2` and `3` are **arguments**. Arguments are the actual values
provided when a function is called. Godot gives them to the function's
parameters in the same order: `2` becomes `current_coins`, and `3` becomes
`collected_coins`.

> 💡 A **parameter** is a named, typed placeholder for a value a function will
> receive. An **argument** is the actual value supplied when the function is
> called.
>
>  Imagine a coffee order slip with a field labeled **Sugar cubes: ____**. The label **Sugar cubes:** is like a parameter: it names the value the barista needs. Writing **2** after the colon is like supplying an argument. You enter a whole number because it counts cubes, just as an `int` parameter expects a whole number. The same slip can be used for another order with **3** cubes.

4. Open `res://scenes/main.tscn`.
5. In the **Output** panel, select **Clear** if it contains messages from an
   earlier run.
6. Run the current scene with `F6`.
7. Confirm that the Output panel shows `5`.
8. Stop the running scene with `F8`.

> ⚠️ **If something differs**
>
> - If no value appears, confirm that `player.gd` is attached to the Player
>   root, the script was saved, and the **Output** panel is open.
> - If Godot reports an argument error, confirm that `add_coins()` receives
>   exactly two integer arguments separated by a comma.

### Part 4: Change an argument

1. In `_ready()`, change the second argument from `3` to `5`:

   ```gdscript
   var total_coins: int = add_coins(2, 5)
   ```

2. Save the script with `Ctrl+S`. In the **Output** panel, select **Clear**,
   then run `main.tscn` with `F6` again.
3. Confirm that the Output panel now shows `7`.
4. Stop the running scene with `F8`.

The function itself did not change. The same instructions produced a different
result because the call supplied a different argument.

> 💡 Parameters make a function reusable. Instead of fixing one value inside
> the function, each call can provide the values needed for that use.

### Part 5: Remove the temporary calculation

1. Delete the complete `_ready()` and `add_coins()` functions, including their
   indented lines.
2. Leave this single line in `player.gd`:

   ```gdscript
   extends CharacterBody2D
   ```

3. Save the script with `Ctrl+S`.

The temporary calculation demonstrated how values enter and leave a function.
Removing it gives the horizontal-movement lesson a clean starting point.

## Learner exercise

Without adding the temporary code again, explain:

1. Why did `_ready()` use `pass` at the start of the lesson?
2. In `add_coins(2, 5)`, which values are arguments?
3. Which parameters receive those arguments?
4. What does `-> int` promise that the function will return?
5. Why did changing only the second argument change the result from `5` to `7`?

## Verification checklist

- [ ] The learner created `_ready()` with a temporary `pass` instruction.
- [ ] The learner can explain the difference between a parameter and an argument.
- [ ] Both parameters in `add_coins()` use `int` type hints.
- [ ] The learner knows that `-> int` means the function returns an integer.
- [ ] The learner replaced `pass` with code that calls `add_coins()`.
- [ ] The learner used `return` to send the calculated value back to `_ready()`.
- [ ] `add_coins(2, 3)` printed `5`.
- [ ] Changing the call to `add_coins(2, 5)` printed `7`.
- [ ] The temporary `_ready()` and `add_coins()` functions have been removed.
- [ ] `player.gd` ends with only `extends CharacterBody2D`.
- [ ] No input or physics behavior has been added yet.

## References

- [GDScript functions](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html#functions)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
