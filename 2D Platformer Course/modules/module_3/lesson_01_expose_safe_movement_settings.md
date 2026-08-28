# Module 3, Lesson 1: Expose Safe Movement Settings

**Status:** Blueprint drafted

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
> - Do not add acceleration or other responsive-movement behavior yet. Those
>   changes begin in Lesson 3.2.

### Part 2: Expose the horizontal speed

1. Add this documentation comment and annotation immediately above the
   existing `speed` variable:

   ```gdscript
   ## Maximum horizontal movement speed in pixels per second.
   @export_range(0.0, 1000.0, 10.0)
   var speed: float = 300.0
   ```

> 💡 An **annotation** begins with `@` and gives Godot extra information
> about the code that follows. `@export_range()` exposes this typed variable
> in the Inspector and limits its editor control to a minimum, maximum, and
> step size. The script still owns the value and the movement code still reads
> the same variable.

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
> as an Inspector tooltip. This explains a customization point where it is
> used without adding comments to the movement calculation itself.

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

### Part 3: Expose gravity and jump velocity

1. Replace the existing `gravity` and `jump_velocity` declarations with these
   documented ranges:

   ```gdscript
   ## Downward acceleration in pixels per second squared.
   @export_range(0.0, 3000.0, 10.0)
   var gravity: float = 980.0

   ## Upward velocity applied when a grounded jump begins.
   @export_range(-1000.0, 0.0, 10.0)
   var jump_velocity: float = -400.0
   ```

You manually exported one representative setting in Part 2. If you are using
Codex, it can accelerate this repeated edit with a focused request such as:

```text
In res://actors/player.gd, expose only gravity and jump_velocity with the
exact documented @export_range declarations shown in Lesson 3.1. Do not
change their defaults or any movement logic. Then explain the resulting diff.
```

Whether you type the code or use Codex, compare the result with the block
above before accepting it. Confirm that Codex changed only the two requested
declarations, explained the diff accurately, and left `_physics_process()`
unchanged.

The minimum gravity is `0.0`, which prevents an Inspector value from
accelerating the Player upward. Jump velocity stays between `-1000.0` and
`0.0`, so it cannot become positive and send a jump downward. Its negative
values reuse Godot's downward-positive Y direction from earlier lessons.

2. Compare the top of the completed script with this version:

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

3. Confirm that the existing `_physics_process()` function below these
   declarations has not changed.
4. Save `player.gd` with `Ctrl+S`.
5. In `player.tscn`, reselect the Player root and confirm that **Speed**,
   **Gravity**, and **Jump Velocity** appear in the Inspector.
6. Confirm that the three Inspector values match their validated defaults.
7. Hover over each property name and confirm that its tooltip explains the
   setting.
8. Confirm that each control stops at its documented minimum and maximum,
   then restore all three defaults.

> ⚠️ **If something differs**
>
> - If only one or two settings appear, check that each variable has its own
>   `@export_range()` line and remains at script-level scope.
> - If a default falls outside its range, compare all signs and decimal values
>   with the completed code block.
> - If Codex changed `_physics_process()` or another file, inspect the diff and
>   keep only the three approved exported declarations.

### Part 4: Verify the defaults and one Inspector customization

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

## Verification checklist

- [ ] `speed`, `gravity`, and `jump_velocity` remain typed `float` variables
      with defaults `300.0`, `980.0`, and `-400.0`.
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
- [ ] Any Codex-assisted edit was inspected, explained, corrected if needed,
      and tested before acceptance.

## References

- [GDScript exported properties](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_exports.html)
- [GDScript documentation comments](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_documentation_comments.html)
- [Static typing in GDScript](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/static_typing.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
