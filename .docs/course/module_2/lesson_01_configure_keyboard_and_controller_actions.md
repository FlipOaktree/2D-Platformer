# Module 2, Lesson 1: Configure Keyboard and Controller Actions

**Status:** Blueprint drafted; awaiting approval

## By the end

Create three named input actions that later player code can use without caring
whether the player uses a keyboard or a controller. The running project will
still display `Project ready` and the project icon, while the Input Map will
contain:

- `move_left`, controlled by `A`, `Left Arrow`, controller D-pad left, and the
  left stick moved left.
- `move_right`, controlled by `D`, `Right Arrow`, controller D-pad right, and
  the left stick moved right.
- `jump`, controlled by `Space` and the controller's bottom face button.

## Before you start

- Module 1 is complete.
- `main.tscn` displays `Project ready` and contains one `ProjectIcon` instance
  of `project_icon.tscn`.
- The project opens and runs without related errors or warnings.
- No controller is required to configure the standard controller events. A
  Godot-compatible controller is needed only to verify the physical controls.

## Build steps

### Part 1: Create the input actions

1. Open the `2D Platformer` project.
2. Select **Project → Project Settings**.
3. Select the **Input Map** tab.

> 💡 A key or controller button is a physical **input event**. An **input
> action** is a name for what the player intends to do. An action can contain
> several events, so later code can ask for `move_left` instead of separately
> checking `A`, `Left Arrow`, a D-pad, and an analog stick. This keeps device
> choices out of the movement code and makes controls easier to change.

4. In the **Add New Action** field, enter `move_left`, then select **Add** or
   press `Enter`.
5. Add `move_right` in the same way.
6. Add `jump` in the same way.
7. Confirm that all three actions appear in the action list.

> 💡 Input action names are stored in the project and later used exactly as
> written in code. This project uses descriptive `snake_case` names: lowercase
> words joined with underscores. Naming the intent rather than a particular
> device lets one action serve every supported control method.

> ⚠️ **If something differs**
>
> - If built-in actions such as `ui_accept` are hidden, leave them hidden.
>   This lesson creates project-specific actions instead of changing Godot's
>   built-in interface controls.
> - If an action is rejected as a duplicate, find the existing action in the
>   list and confirm its spelling before continuing.
> - If an action has a space or capital letter, remove it and recreate it with
>   the exact name shown above.

### Part 2: Add keyboard events

1. Expand `move_left`, then select its **Add Event** button.
2. Select the field that listens for an input, press `A`, and confirm the
   event.
3. Add another event to `move_left`, press `Left Arrow`, and confirm it.
4. Expand `move_right` and add `D`.
5. Add `Right Arrow` as a second keyboard event for `move_right`.
6. Expand `jump` and add `Space`.
7. Review the three actions and confirm this keyboard mapping:

   | Action | Keyboard events |
   | --- | --- |
   | `move_left` | `A`, `Left Arrow` |
   | `move_right` | `D`, `Right Arrow` |
   | `jump` | `Space` |

   Each event should appear only under its intended action.

> 💡 Multiple events inside one action are alternatives, not a key
> combination. Either `A` or `Left Arrow` will count as `move_left`; the
> player will not need to press both.

> ⚠️ **If something differs**
>
> - If the dialog captures a mouse click instead of the key, cancel that event,
>   reopen **Add Event**, select the listening field, and press the key again.
> - If an event appears under the wrong action, remove only that event with its
>   delete button, then add it beneath the correct action.
> - If a modifier such as `Shift` appears, remove the event and press only the
>   intended key when listening begins.

### Part 3: Add controller events

1. Expand `move_left`, then select **Add Event**.
2. Under **Filter Inputs**, expand **Joypad Buttons**.
3. Select **Joypad Button 13 (D-pad Left)**, then select **OK**.
4. Add another event to `move_left` and expand **Joypad Axes**.
5. Select **Joypad Axis 0 - (Left Stick Left, Joystick 0 Left)**, then select
   **OK**.
6. Expand `move_right` and add **Joypad Button 14 (D-pad Right)**.
7. Add **Joypad Axis 0 + (Left Stick Right, Joystick 0 Right)** to
   `move_right`.
8. Expand `jump` and add **Joypad Button 0 (Bottom Action, Sony Cross, Xbox A,
   Nintendo B)**.

   The bottom face button is called `A` on an Xbox-style controller and
   Cross on a PlayStation-style controller. Godot maps supported controllers
   by the button's position, so the action does not need a brand-specific
   name.

9. Confirm that the completed actions contain these controller inputs:

   | Action | Controller events |
   | --- | --- |
   | `move_left` | D-pad left, left stick left |
   | `move_right` | D-pad right, left stick right |
   | `jump` | Bottom face button |

10. Leave each action's deadzone at its default value of `0.5`.
11. If a compatible controller is connected, select **Add Event** beneath an
    action and use **Listening for Input** to press or move its mapped control.
    Confirm that Godot detects the expected event, then select **Cancel** so a
    duplicate is not added. Repeat for D-pad left and right, left-stick left
    and right, and the bottom face button.
12. If no compatible controller is available, record the physical controller
    test as pending. Keep all five standard controller events configured.

> 💡 Selecting standard events from **Joypad Buttons** and **Joypad Axes**
> configures controller support even when no controller is connected. Hardware
> is needed to test the physical controls, not to create their Input Map
> entries.

> 💡 An analog stick reports a range of strengths instead of only on or
> off. A **deadzone** ignores small values near the stick's resting position,
> which helps prevent an older or imperfect stick from moving a character by
> itself. The default is a safe starting point; movement tuning can revisit it
> after a player exists.

> ⚠️ **If something differs**
>
> - If a controller choice is not visible, expand **Joypad Buttons** or
>   **Joypad Axes** under **Filter Inputs** instead of using the listening
>   field.
> - If the stick events show the same direction, remove the incorrect event.
>   Add Axis `0 -` beneath `move_left` and Axis `0 +` beneath `move_right`.
> - If connected hardware is not recognized, confirm that the operating system
>   recognizes it and reconnect it. Keep the standard events configured and
>   record the physical controller check as pending.

### Part 4: Save and inspect the result

1. Close **Project Settings**. Godot saves Input Map changes in
   `project.godot`.
2. Reopen **Project → Project Settings → Input Map**.
3. Expand `move_left`, `move_right`, and `jump`, then confirm that every added
   event is still present and the left and right stick directions are
   opposite.
4. Close **Project Settings**.
5. Run the project with `F5`.
6. Confirm that the existing `Project ready` message and project icon still
   appear and that the project reports no related errors or warnings.
7. Stop the project with `F8`.

   The new actions do not move anything yet. This lesson creates the shared
   control vocabulary; a later lesson will read `move_left` and `move_right`
   from typed GDScript, and another will use `jump`.

> ⚠️ **If something differs**
>
> - If an action or event disappears after reopening Project Settings, add it
>   again, close Project Settings, and reopen the Input Map to recheck it.
> - If the running project shows the same message and icon but nothing moves,
>   that is expected. No movement code exists yet.
> - If the project reports an error, stop it and confirm that only Input Map
>   settings changed during this lesson.

## Learner exercise

Without repeating the build steps:

1. Add `Up Arrow` as a temporary third event for `jump`.
2. Explain why future jump code would recognize either `Space`, `Up Arrow`, or
   the controller button without checking each one separately.
3. Remove only the temporary `Up Arrow` event.
4. Close and reopen the Input Map, then confirm that the original keyboard and
   controller mappings remain unchanged.

## Verification checklist

- [ ] `move_left`, `move_right`, and `jump` exist with exact `snake_case`
      names.
- [ ] `move_left` contains `A` and `Left Arrow` keyboard events.
- [ ] `move_right` contains `D` and `Right Arrow` keyboard events.
- [ ] `jump` contains a `Space` keyboard event.
- [ ] `move_left` contains D-pad left and left-stick-left controller events.
- [ ] `move_right` contains D-pad right and left-stick-right controller events.
- [ ] `jump` contains the controller's bottom face button.
- [ ] Each action keeps the default deadzone of `0.5`.
- [ ] Closing and reopening Project Settings preserves every action and event.
- [ ] Running the project still displays `Project ready` and the project icon
      without related errors or warnings.
- [ ] The learner can explain the difference between an input event and an
      input action.
- [ ] The learner can explain why action names describe intent instead of a
      particular key or controller button.
- [ ] If compatible controller hardware is available, the mapped controls are
      recognized physically.
- [ ] If compatible controller hardware is unavailable, all standard events
      are still configured and the physical controller test is recorded as
      pending rather than assumed to pass.

## References

- [Input examples](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html)
- [Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html)
- [Listening to player input](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/scripting_player_input.html)
