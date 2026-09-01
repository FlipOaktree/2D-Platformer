# Module 3, Lesson 1: Expose Safe Movement Settings

**Status:** Validated

## By the end

Expose the Player's existing movement values in the Inspector so they can be
tuned without editing the movement code. Each setting will keep the validated
default from Module 2, use a range that prevents values which reverse its
intended direction, and provide a short tooltip explaining what it controls.

- **Speed** defaults to `300.0` and allows values from `0.0` to `1000.0`.
- **Gravity** defaults to `980.0` and allows values from `0.0` to `3000.0`.
- **Jump Velocity** defaults to `-400.0` and allows values from `-1000.0` to
  `0.0`.
- Running `main.tscn` with the defaults preserves the movement, falling,
  landing, and grounded jumping validated in Module 2.

## Before you start

- Module 2 is complete.
- `res://actors/player.gd` contains the validated `speed`, `gravity`, and
  `jump_velocity` variables.
- `main.tscn` contains one Player instance and the temporary Floor.
- The Player moves horizontally, falls, lands, and jumps only while grounded.
- The Input Map still supports the validated keyboard and controller actions.

## Build steps

### Part 1: Confirm the movement baseline

1. Open `res://actors/player.gd`.
2. Confirm that the three movement variables still have these values:

   ```gdscript
   var speed: float = 300.0
   var gravity: float = 980.0
   var jump_velocity: float = -400.0
   ```

3. Open `res://scenes/main.tscn` and run the current scene with `F6`.
4. Confirm that the Player moves left and right, falls onto the Floor, and
   jumps only while grounded.
5. If a compatible controller is connected, test its configured horizontal
   controls and jump button too.
6. Stop the running scene with `F8`.

This baseline proves that the movement works before its settings become
editable. The lesson will change how the values are configured, not the
movement calculations that use them.

> ⚠️ **If something differs**
>
> - If any baseline behavior fails, compare `player.gd`, `main.tscn`, and the
>   Input Map with the Module 2 verification checklists before continuing.
> - Do not add acceleration or other responsive-movement behavior yet. The
>   movement model is introduced in Lesson 3.2, and the code changes begin in
>   Lesson 3.3.

### Part 2: Add useful regular comments

1. Return to `res://actors/player.gd`.
2. Add one regular comment above the jump condition and another above the
   gravity condition:

   ```gdscript
   func _physics_process(delta: float) -> void:
       # Prevent another jump from starting while the Player is airborne.
       if Input.is_action_just_pressed("jump") and is_on_floor():
           velocity.y = jump_velocity

       # Skip gravity while the Player is grounded.
       if not is_on_floor():
           velocity.y += gravity * delta

       var direction: float = Input.get_axis("move_left", "move_right")
       velocity.x = direction * speed
       move_and_slide()
   ```

Regular comments were introduced in Lesson 2.4. Godot ignores them when the
game runs, but they can explain an implementation decision to someone reading
the code.

3. Save `player.gd`.

The comments will remain in `_physics_process()`. In the next part, you will
use a different kind of comment to document a setting for the Inspector.

> ⚠️ **If something differs**
>
> - If the script reports an indentation error, align each comment with the
>   `if` statement directly below it.
> - If movement behavior changes, compare the function with the code block and
>   confirm that only the two comment lines were added.

### Part 3: Expose the horizontal speed

1. Add this documentation comment and annotation immediately above the
   existing `speed` variable:

   ```gdscript
   ## Maximum horizontal movement speed in pixels per second.
   @export_range(0.0, 1000.0, 10.0)
   var speed: float = 300.0
   ```

> 💡 An **annotation** starts with `@` and tells Godot how to treat the
> declaration directly below it. `@export_range(...)` shows this variable in
> the Inspector with an allowed range and step value. The first value between
> the parentheses is the minimum, the second is the maximum, and the third is
> the step. It does not change the movement logic: `speed` is still a normal
> `float` that the script reads.

The range starts at `0.0`, so an Inspector edit cannot turn a positive movement
speed into an unintended negative direction. The upper limit keeps early
tuning within a practical test range, while steps of `10.0` make the slider
easy to adjust. The validated `300.0` remains the default.

2. Save `player.gd` with `Ctrl+S`.
3. Open `res://actors/player.tscn` and select the `Player` root.
4. Find **Speed** near the top of the Inspector and confirm that it displays
   `300.0`.
5. Hover over the **Speed** property name and confirm that its tooltip
   describes the maximum horizontal movement speed.

> 💡 A documentation comment begins with `##` and describes the code
> directly below it. On an exported variable, Godot can show that description
> as an Inspector tooltip.

The regular `#` comments inside `_physics_process()` explain implementation
decisions to a code reader. The `##` documentation comment above `speed`
describes that variable to Godot as well, allowing the editor to reuse the
description as a tooltip. Both are useful, but they serve different purposes.

6. Try dragging the Inspector control toward both ends. Confirm that it stays
   between `0.0` and `1000.0` and changes in steps of `10.0`.
7. Restore **Speed** to `300.0` before continuing.

> ⚠️ **If something differs**
>
> - If **Speed** does not appear, confirm that `@export_range()` is directly
>   above `var speed`, then save the script and reselect the Player root.
> - If the script reports an error, compare the commas, parentheses, decimal
>   values, and indentation with the code block.
> - If the tooltip is missing, confirm that the comment begins with two `#`
>   characters and sits directly above the annotation without unrelated code
>   between them.

### Part 4: Expose gravity and jump velocity

You manually exported one representative setting in Part 3. Codex can now
accelerate the repeated pattern for the other two settings while leaving the
movement logic alone.

1. If you are using Codex, give it this focused request:

   ```text
   In player.gd, use the exported speed declaration as the pattern. Add
   @export_range() annotations with sensible minimum, maximum, and step
   values, plus documentation comments, to gravity and jump_velocity. Do not
   change their defaults or _physics_process().
   ```

2. Before accepting the result, inspect Codex's diff.
3. Confirm that it changed only the `gravity` and `jump_velocity`
   declarations. Their default values must remain `980.0` and `-400.0`, and
   `_physics_process()` must retain both regular comments and all its existing
   movement logic.
4. Ask Codex to explain the minimum, maximum, and step values it chose. Treat
   those choices as suggestions until you compare them with the intended
   settings below.

If you are not using Codex, continue with the same declarations manually. The
lesson outcome and final code remain the same.

5. Compare the proposed declarations with these required comments and ranges:

   ```gdscript
   ## Downward acceleration in pixels per second squared.
   @export_range(0.0, 3000.0, 10.0)
   var gravity: float = 980.0

   ## Upward velocity applied when a grounded jump begins.
   @export_range(-1000.0, 0.0, 10.0)
   var jump_velocity: float = -400.0
   ```

6. For the purpose of this exercise, manually correct every difference in
   wording or annotation values. If a declaration already matches, leave it
   unchanged rather than introducing an unnecessary edit.

The minimum gravity is `0.0`, which prevents an Inspector value from
accelerating the Player upward. Jump velocity stays between `-1000.0` and
`0.0`, so it cannot become positive and send a jump downward. Its negative
values reuse Godot's downward-positive Y direction from earlier lessons. The
step of `10.0` keeps both Inspector controls consistent with Speed.

7. Compare the top of the completed script with this version:

   ```gdscript
   extends CharacterBody2D

   ## Maximum horizontal movement speed in pixels per second.
   @export_range(0.0, 1000.0, 10.0)
   var speed: float = 300.0

   ## Downward acceleration in pixels per second squared.
   @export_range(0.0, 3000.0, 10.0)
   var gravity: float = 980.0

   ## Upward velocity applied when a grounded jump begins.
   @export_range(-1000.0, 0.0, 10.0)
   var jump_velocity: float = -400.0
   ```

8. Confirm that `_physics_process()` still contains the two regular comments
   from Part 2 and that none of its executable instructions changed.
9. Save `player.gd` with `Ctrl+S`.
10. In `player.tscn`, reselect the Player root and confirm that **Speed**,
   **Gravity**, and **Jump Velocity** appear in the Inspector.
11. Confirm that the three Inspector values match their validated defaults.
12. Hover over each property name and confirm that its tooltip explains the
   setting.
13. Confirm that each control stops at its documented minimum and maximum,
   then restore all three defaults.

> ⚠️ **If something differs**
>
> - If only one or two settings appear, check that each variable has its own
>   `@export_range()` line and remains at script-level scope.
> - If a default falls outside its range, compare all signs and decimal values
>   with the completed code block.
> - If Codex changed `_physics_process()` or another file, reject those changes
>   or restore the function from the inspected diff. Keep its two regular
>   comments and existing executable instructions.
> - If Codex chose different comments or ranges, this is not a failure. Replace
>   those suggestions manually with the required declarations before testing.

### Part 5: Verify the defaults and one Inspector customization

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Confirm that the default horizontal movement, gravity, and grounded jump
   still behave as they did in Module 2.
3. Test the validated keyboard controls and, when available, the configured
   controller controls.
4. Stop the scene with `F8`.
5. Open `res://actors/player.tscn`, select the Player root, and change
   **Speed** from `300.0` to `150.0` in the Inspector.
6. Save `player.tscn`, run `main.tscn`, and confirm that horizontal movement
   is slower while gravity and jumping still work.
7. Stop the scene, restore **Speed** to `300.0`, and save `player.tscn`.
8. Run `main.tscn` once more and confirm that the validated default movement
   has returned without parser errors, runtime errors, or unexplained
   warnings.

> ⚠️ **If something differs**
>
> - If the Inspector value changes but movement does not, confirm that the
>   script still multiplies horizontal input by `speed`.
> - If changing **Speed** also changes falling or jumping, compare
>   `_physics_process()` with the validated Module 2 script and confirm that
>   its calculations were not edited.
> - If the final movement remains slow, restore **Speed** to `300.0` on the
>   Player source scene and save it before running again.

## Learner exercise

Without editing `player.gd`:

1. In the Player Inspector, change **Jump Velocity** from `-400.0` to
   `-250.0`.
2. Predict how the new value will change the jump, then run `main.tscn` and
   check the prediction.
3. Try to move **Jump Velocity** above `0.0` and explain why the Inspector
   range prevents it.
4. Restore **Jump Velocity** to `-400.0`, save `player.tscn`, and verify the
   original jump again.
5. Explain the separate purpose of the exported default, range, step, and
   tooltip.
6. Explain why the function comments use `#` while the exported-property
   descriptions use `##`.

## Verification checklist

- [ ] `speed`, `gravity`, and `jump_velocity` remain typed `float` variables
      with defaults `300.0`, `980.0`, and `-400.0`.
- [ ] `_physics_process()` contains regular comments explaining why the jump
      condition prevents airborne jumps and why gravity is skipped while
      grounded.
- [ ] Each movement variable has a documentation comment and an
      `@export_range()` annotation.
- [ ] **Speed** is limited to `0.0` through `1000.0` in steps of `10.0`.
- [ ] **Gravity** is limited to `0.0` through `3000.0` in steps of `10.0`.
- [ ] **Jump Velocity** is limited to `-1000.0` through `0.0` in steps of
      `10.0`.
- [ ] All three settings appear on the Player root in the Inspector.
- [ ] Hovering each setting reveals a useful tooltip.
- [ ] `_physics_process()` and its movement calculations remain unchanged.
- [ ] The default keyboard movement and grounded jump still work.
- [ ] Configured controller movement and jumping still work when a compatible
      controller is available.
- [ ] The slower-Speed test works and ends with **Speed** restored to `300.0`.
- [ ] The learner exercise ends with **Jump Velocity** restored to `-400.0`.
- [ ] Running `main.tscn` produces no related parser errors, runtime errors,
      or unexplained warnings.
- [ ] The learner can explain how exported ranges and documentation tooltips
      make Inspector customization safer and clearer.
- [ ] The learner can distinguish a regular implementation comment from a
      documentation comment used for an Inspector property.
- [ ] Any Codex-assisted edit was inspected, explained, corrected if needed,
      and tested before acceptance.

## References

- [GDScript exported properties](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_exports.html)
- [GDScript documentation comments](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_documentation_comments.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
