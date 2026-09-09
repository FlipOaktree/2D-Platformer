# Module 1, Lesson 2: Set Up the Game Window

**Status:** Blueprint drafted

## By the end

Choose the size of the world the game draws, and make the running game
comfortable to look at on your monitor. Lesson 1.1 ran the project in a small
window; this lesson replaces that default with a deliberate choice.

- The game draws a world **1920 by 1080** pixels.
- The running game scales to fit its window instead of staying a fixed size.
- The window keeps its shape when resized, so the view never stretches.
- On a large monitor the window opens at a comfortable size.
- Running `main.tscn` still shows the Lesson 1.1 `Label`.

## Before you start

- Module 1, Lesson 1 is complete.
- `main.tscn` contains `Main` and its `Label`.
- The project runs with `F6` and shows the label text.

## Build steps

### Part 1: See the current window

1. Open `res://scenes/main.tscn` and run the current scene with `F6`.
2. Look at the size of the game window compared with your screen.
3. Stop the scene with `F8`.

On most monitors the window is small, and on a 4K screen it is very small. The
project is using Godot's default size, which no one chose for this game.

> 💡 Two different sizes are involved, and mixing them up causes confusion
> later. The **viewport size** is how many pixels of game world are drawn: it
> decides what `(0, 0)` and `(1920, 1080)` mean to every node you place. The
> **window size** is how large that picture appears on your desktop. Changing
> the window does not move anything in your game.

### Part 2: Set the viewport size

1. Open **Project > Project Settings**.
2. Select the **General** tab.
3. In the left list, open **Display > Window**.
4. Under **Size**, set **Viewport Width** to `1920`.
5. Set **Viewport Height** to `1080`.

> 💡 `1920` by `1080` is the most common screen shape in use, often called
> 1080p. Choosing it now means the world you build has the same proportions as
> the screens most players use. Every position and size in the rest of this
> course assumes this viewport.

6. Run the scene with `F6` and confirm that the label still appears.
7. Stop the scene with `F8`.

The window is now larger, but the game still draws at a fixed size. If you
resize the window, the view does not follow.

> ⚠️ **If something differs**
>
> - If the settings list looks unfamiliar, confirm that the **General** tab is
>   selected rather than **Input Map**.
> - If **Viewport Width** does not accept the value, click into the field, clear
>   it, type `1920`, and press `Enter`.

### Part 3: Make the view scale with the window

1. Return to **Project Settings > Display > Window**.
2. Under **Stretch**, set **Mode** to `canvas_items`.
3. Set **Aspect** to `keep`.
4. Run the scene with `F6`.
5. Drag a corner of the game window to resize it. Confirm that the label grows
   and shrinks with the window instead of staying one size.
6. Make the window very wide and very short. Confirm that the picture keeps its
   shape and adds empty bars rather than stretching.
7. Stop the scene with `F8`.

> 💡 **Mode** `canvas_items` scales the drawn world to fill the window, so the
> game looks right on any monitor while your positions stay in the same
> 1920-by-1080 space. **Aspect** `keep` refuses to distort the picture: rather
> than squashing the world to match an odd window shape, Godot keeps the
> proportions and fills the leftover space with bars. Keeping the aspect also
> guarantees that the visible area is always exactly the world you designed.

> ⚠️ **If something differs**
>
> - If resizing stretches or squashes the label, confirm that **Aspect** is
>   `keep` and not `expand` or `ignore`.
> - If resizing does nothing, confirm that **Mode** is `canvas_items` and not
>   `disabled`.

### Part 4: Choose a comfortable window size

1. Return to **Project Settings > Display > Window**.
2. Under **Size**, find **Window Width Override** and **Window Height
   Override**.
3. Choose the values that fit your monitor:

   | Your monitor | Window Width Override | Window Height Override |
   | --- | --- | --- |
   | 1920 by 1080 | `1280` | `720` |
   | 2560 by 1440 or larger | `0` | `0` |

4. Run the scene with `F6` and confirm that the window is large enough to see
   comfortably while still leaving the editor visible.
5. Stop the scene with `F8`.
6. Save the project with `Ctrl+S`.

An override of `0` means "use the viewport size", so a large monitor opens the
window at the full 1920 by 1080. On a 1080p monitor that would cover the whole
screen, so the override shrinks the window without changing the world inside
it.

> 💡 If the game window opens on the wrong monitor, open **Editor > Editor
> Settings**, then **Run > Window Placement**, and choose the screen you want.
> That is an editor preference, so it affects only your machine and is not
> stored in the project.

> ⚠️ **If something differs**
>
> - If the window still fills your screen, confirm that both override values
>   were entered and that the project was saved.
> - If the window is tiny, confirm that you set the overrides and not the
>   viewport size.

### Part 5: Confirm the setting is stored in the project

1. In the **FileSystem** dock, open `res://project.godot`.
2. Confirm that it now contains a `[display]` section listing the viewport size
   and the stretch settings.
3. Close the file without editing it.

> 💡 Project Settings writes to `project.godot`, the same file Lesson 0.2
> introduced. Settings you change in the editor are stored in the project and
> travel with it, which is why the next Git checkpoint will include this file.

## Learner exercise

1. Temporarily set **Aspect** to `expand` and run the scene.
2. Resize the window to a wide shape and describe what happens to the visible
   area compared with `keep`.
3. Restore **Aspect** to `keep`, save, and run the scene once more.
4. Explain the difference between the viewport size and the window size in your
   own words.

## Verification checklist

- [ ] **Viewport Width** is `1920` and **Viewport Height** is `1080`.
- [ ] **Stretch Mode** is `canvas_items`.
- [ ] **Stretch Aspect** is `keep`.
- [ ] Resizing the running window scales the label instead of leaving it a
      fixed size.
- [ ] An unusual window shape adds bars instead of distorting the picture.
- [ ] The window override values suit the learner's monitor, and the running
      window is comfortable to look at.
- [ ] `project.godot` contains a `[display]` section with the viewport and
      stretch settings.
- [ ] Running `main.tscn` still shows the Lesson 1.1 label and reports no
      related errors or warnings.
- [ ] The exercise ends with **Aspect** restored to `keep`.
- [ ] The learner can explain the difference between the viewport size and the
      window size.

## References

- [Multiple resolutions](https://docs.godotengine.org/en/4.7/tutorials/rendering/multiple_resolutions.html)
- [Project Settings](https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html)
- [Editor settings](https://docs.godotengine.org/en/4.7/tutorials/editor/editor_settings.html)
