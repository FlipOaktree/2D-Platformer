# Module 1, Lesson 5: Understand Node Types and Families

**Status:** Blueprint drafted

## Lesson goals

Learn what a node's type is, how node types are grouped into families, and how
each type inherits abilities from the types above it. This is a short theory
lesson: you will read the Inspector but not change the project.

- Telling a node's type apart from its name
- Recognising the main node families and what each is for
- Seeing how a node inherits abilities from a line of ancestor types
- Reading the Inspector as a list of what each ancestor contributes

## Before you start

- Module 1, Lesson 4 is complete.
- `main.tscn` contains `Main`, `Label`, and `ProjectIcon`.

## Build steps

### Part 1: Tell a node's type from its name

1. Open `res://scenes/main.tscn`.
2. Select `ProjectIcon` in the Scene dock.
3. Look at the top of the Inspector. Confirm that it shows `Sprite2D`, not
   `ProjectIcon`.
4. Select `Main` and confirm that the Inspector shows `Node2D`.

> 💡 Every node has a **type** and a **name**. The type decides what the node
> can do; the name is only a label you choose. Renaming `Node2D` to `Main`
> changed what it is called, not what it is. Naming a cat Luna doesn't change
> the fact that it's a cat.

### Part 2: Meet the main node families

Godot has hundreds of node types, but most belong to a few families:

| Family | What it is for | Examples in this course |
| --- | --- | --- |
| `Node2D` | Objects placed in the 2D game world | `Main`, `ProjectIcon` |
| `Control` | Interface elements such as text, buttons, and menus | `Label` |
| `Node3D` | Objects in a 3D world | None; this course is 2D |

`Node2D` and `Control` both belong to a larger family, `CanvasItem`, which
holds everything Godot draws in 2D. At the very top sits `Node`, which every
node type comes from.

1. Select `Main`, then select **Add Child Node**.
2. With the search field empty, look at the list. It is arranged as a tree:
   `Node` at the top, with families such as `CanvasItem`, `Node2D`, and
   `Control` nested inside it.
3. Expand `Node2D` and find `Sprite2D` inside it. Expand `Control` and find
   `Label` inside it.
4. Close the dialog with **Cancel** without creating anything.

> ⚠️ **If something differs**
>
> - If the list is not shown as a tree, clear the search field.
> - If a node was created by accident, select it and press `Delete`.

### Part 3: Read a node's ancestor line

A node type **inherits** from the type above it, the way a cat is a kind of
mammal and a mammal is a kind of animal. Everything true of animals is true of
mammals, and everything true of mammals is true of cats, which add traits of
their own. A `Sprite2D` works the same way: it has everything a `Node2D` has
and adds a texture, and a `Node2D` has everything a `CanvasItem` has and adds a
position. Following the line upward:

`Node` → `CanvasItem` → `Node2D` → `Sprite2D`

So a `Sprite2D` *is* a `Node2D`, a `CanvasItem`, and a `Node` at once.

1. Select `ProjectIcon`.
2. Scroll down the Inspector and read the four section headings in order:
   **Sprite2D**, **Node2D**, **CanvasItem**, **Node**.
3. Confirm that **Texture** sits under **Sprite2D**, **Transform** under
   **Node2D**, and **Script** under **Node**.

> 💡 The Inspector lists a node's own type first and its oldest ancestor last.
> Each section holds what that ancestor contributes, which is how you can tell
> where a property comes from.

4. Select `Label` and read its section headings. Confirm that **Transform**
   appears under **Control → Layout**, not under a **Node2D** section.

This is why **Transform** appeared in a different place on `Label` earlier: a
`Label` belongs to the `Control` family, not the `Node2D` family.

> ⚠️ **If something differs**
>
> - If the sections are collapsed, the headings still show; expand one only to
>   look inside.
> - If you see a different first heading, confirm that `ProjectIcon`, not
>   `Main`, is selected.

## Learner exercise

Without opening the dialog again:

1. Predict which section headings the Inspector shows for `Main`.
2. Select `Main` and check your prediction.
3. Explain why `Main` has a **Transform** but no **Texture**.

## Verification checklist

- [ ] `main.tscn` is unchanged by this lesson.
- [ ] The learner can explain the difference between a node's type and its name.
- [ ] The learner can name the `Node2D`, `Control`, and `Node3D` families and
    say what each is for.
- [ ] The learner can trace `Sprite2D` up its ancestor line to `Node`.
- [ ] The learner can use the Inspector's section headings to tell which
    ancestor a property comes from.
- [ ] The learner can explain why `Label` and `ProjectIcon` show
    **Transform** in different places.

## References

- [Nodes and scenes](https://docs.godotengine.org/en/4.7/getting_started/step_by_step/nodes_and_scenes.html)
- [Node](https://docs.godotengine.org/en/4.7/classes/class_node.html)
- [CanvasItem](https://docs.godotengine.org/en/4.7/classes/class_canvasitem.html)
- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
- [Control](https://docs.godotengine.org/en/4.7/classes/class_control.html)
- [Sprite2D](https://docs.godotengine.org/en/4.7/classes/class_sprite2d.html)
