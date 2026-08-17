# Module 2, Lesson 1: Configure Keyboard and Controller Actions

**Status:** Validated locally; Notion current

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

> 💡 An **input action** is a name for what the player intends to do. A key or controller button is a physical **input event**. An action can contain several events, so later code can ask for `move_left` instead of separately checking `A`, `Left Arrow`, a D-pad, and an analog stick. Naming the intent rather than a particular device button or key lets one action serve every supported control method, making controls easier to change.

4. In the **Add New Action** field, enter `move_left`, then select **Add** or
   press `Enter`.
5. Add `move_right` in the same way.
6. Add `jump` in the same way.
7. Confirm that all three actions appear in the action list.

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

1. On the right side of the `move_left` row, select **Add Event** (`+`).
2. Select the field that listens for an input, press `A`, and confirm the
   event.
3. Select **Add Event** (`+`) on the right side of `move_left`, press `Left
   Arrow`, and confirm it.
4. Select **Add Event** (`+`) on the right side of `move_right`, press `D`,
   and confirm it.
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

1. On the right side of `move_left`, select **Add Event** (`+`). If a
   controller is connected, choose **Listening for Input** and press D-pad
   left. Otherwise, under **Filter Inputs**, expand **Joypad Buttons**, select
   **Joypad Button 13 (D-pad Left)**, then select **OK**.
2. On the right side of `move_left`, select **Add Event** (`+`). If a
   controller is connected, choose **Listening for Input** and move the left
   stick fully left. Otherwise, under **Filter Inputs**, expand **Joypad
   Axes**, select **Joypad Axis 0 - (Left Stick Left, Joystick 0 Left)**, then
   select **OK**.
3. On the right side of `move_right`, select **Add Event** (`+`). If a
   controller is connected, choose **Listening for Input** and press D-pad
   right. Otherwise, under **Filter Inputs**, expand **Joypad Buttons**,
   select **Joypad Button 14 (D-pad Right)**, then select **OK**.
4. On the right side of `move_right`, select **Add Event** (`+`). If a
   controller is connected, choose **Listening for Input** and move the left
   stick fully right. Otherwise, under **Filter Inputs**, expand **Joypad
   Axes**, select **Joypad Axis 0 + (Left Stick Right, Joystick 0 Right)**,
   then select **OK**.
5. On the right side of `jump`, select **Add Event** (`+`). If a controller is
   connected, choose **Listening for Input** and press the controller's bottom
   face button. Otherwise, under **Filter Inputs**, expand **Joypad Buttons**,
   select **Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)**,
   then select **OK**.

   The bottom face button is called `A` on an Xbox-style controller and
   Cross on a PlayStation-style controller. Godot maps supported controllers
   by the button's position, so the action does not need a brand-specific
   name.

6. Confirm that the completed actions contain these controller inputs:

   | Action | Controller events |
   | --- | --- |
   | `move_left` | D-pad left, left stick left |
   | `move_right` | D-pad right, left stick right |
   | `jump` | Bottom face button |

7. Leave each action's deadzone at `0.2`.

> 💡 An analog stick reports a range of strengths instead of only on or
> off. A **deadzone** ignores small values near the stick's resting position,
> which helps prevent an older or imperfect stick from moving a character by
> itself. This project starts at `0.2`; movement tuning can revisit it after a
> player exists.

> ⚠️ **If something differs**
>
> - If a controller choice is not visible, expand **Joypad Buttons** or
>   **Joypad Axes** under **Filter Inputs** instead of using the listening
>   field.
> - If the stick events show the same direction, remove the incorrect event.
>   Add Axis `0 -` beneath `move_left` and Axis `0 +` beneath `move_right`.
> - If connected hardware is not recognized, confirm that the operating system
>   recognizes it and reconnect it. You can still add the standard event
>   manually from **Joypad Buttons** or **Joypad Axes**.

## Learner exercise

Without repeating the build steps:

1. Add `Up Arrow` as a temporary third event for `jump`.
2. Explain why future jump code would recognize either `Space`, `Up Arrow`, or
   the controller button without checking each one separately.
3. Remove only the temporary `Up Arrow` event.
4. Confirm that the original keyboard and controller mappings remain unchanged.

## Verification checklist

- [ ] `move_left`, `move_right`, and `jump` exist with exact `snake_case`
      names.
- [ ] `move_left` contains `A` and `Left Arrow` keyboard events.
- [ ] `move_right` contains `D` and `Right Arrow` keyboard events.
- [ ] `jump` contains a `Space` keyboard event.
- [ ] `move_left` contains D-pad left and left-stick-left controller events.
- [ ] `move_right` contains D-pad right and left-stick-right controller events.
- [ ] `jump` contains the controller's bottom face button.
- [ ] Each action uses the project deadzone of `0.2`.
- [ ] The learner can explain the difference between an input event and an
      input action.
- [ ] The learner can explain why action names describe intent instead of a
      particular key or controller button.
- [ ] With a connected compatible controller, **Listening for Input** detects
      each mapped control while it is being added.

## References

- [Input examples](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html)
- [Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/4.7/tutorials/inputs/controllers_gamepads_joysticks.html)
- [Listening to player input](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/scripting_player_input.html)
