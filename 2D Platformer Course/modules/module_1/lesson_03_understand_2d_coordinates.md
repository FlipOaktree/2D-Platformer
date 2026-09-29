# Module 1, Lesson 3: Understand 2D Coordinates

**Status:** Validated

## By the end

Understand how Godot describes a position in 2D using `x` and `y` coordinates.

This is a theory lesson. You will not change the Godot project yet. Its purpose
is to make the transform tools in the next lesson easier to understand.

- Where the origin sits and which way each axis points.
- Why screen coordinates start at the top-left, so positive `y` points down.
- Why a child's Position is measured from its parent rather than the screen.

## Before you start

- Module 1, Lesson 2 is complete.
- You understand that `Main` is the parent of `Label` in the scene tree.

## Build steps

### Part 1: Read a position

A position in 2D uses two coordinates written as `(x, y)`:

- `x` describes the horizontal position.
- `y` describes the vertical position.

The starting point `(0, 0)` is called the **origin**. A positive `x` value is to the right of the origin, while a negative `x` value is to its left. Read these examples:

| Position | Meaning |
| --- | --- |
| `(0, 0)` | At the origin |
| `(256, 0)` | 256 pixels to the right of the origin |
| `(-32, 0)` | 32 pixels to the left of the origin |

> 💡 A **coordinate** is a number that locates something along an axis. A pair of coordinates locates a point in 2D. The order is always `(x, y)`: horizontal first, vertical second. Godot usually measures 2D screen positions in pixels.

### Part 2: Follow Godot's screen axes

You may be used to graphs where `y` increases upward. In Godot's 2D screen
coordinates, the origin is at the top-left: increasing `x` moves right, and
increasing `y` moves down.

This top-to-bottom direction is common in computer graphics because pixel rows
are counted from the top of an image or screen.

Read these examples:

| Position | Direction from the origin |
| --- | --- |
| `(0, 120)` | Down |
| `(200, 120)` | Right and down |
| `(-40, 120)` | Left and down |
| `(200, -40)` | Right and up |

### Part 3: Understand local positions

Nodes are arranged in a hierarchy. A child node's Position is measured from
its parent rather than directly from the screen's origin. This is called a
**local position**.

For example, suppose a parent is at `(100, 50)` and its child is at the local
Position `(20, 10)`. When only their positions are involved, the child appears
at `(120, 60)` because it is 20 pixels to the right and 10 pixels below its
parent.

Moving the parent also moves the child on screen, but the child's stored local
Position remains `(20, 10)`. This lets a whole scene branch move together
without rearranging every child separately.

## Learner exercise

Without opening Godot, answer these questions:

1. From `(0, 0)`, which directions lead to `(200, 80)`?
2. From `(0, 0)`, which directions lead to `(-40, 120)`?
3. In `(60, 130)`, which number is the `x` and which is the `y`?
4. If only `x` increases, does an object move horizontally or vertically?
5. A parent is at `(40, 70)` and its child has local Position `(40, 30)`.
   When only positions are involved, where does the child appear?
6. If that parent moves, does the child's stored local Position change?
7. Why does positive `y` point down in Godot's 2D screen coordinates?

## Verification checklist

- [ ] The learner can identify `x` and `y` in a coordinate pair.
- [ ] The learner can locate the origin at `(0, 0)`.
- [ ] The learner knows that positive `x` points right and negative `x` points left.
- [ ] The learner knows that positive `y` points down and negative `y` points
    up in Godot's 2D screen coordinates.
- [ ] The learner can explain why screen coordinates commonly begin at the top-left.
- [ ] The learner can explain that a child's Position is local to its parent.
- [ ] The learner can predict how moving a parent affects its children.

## References

- [Introduction to 2D](https://docs.godotengine.org/en/4.7/tutorials/2d/introduction_to_2d.html)
- [Vector math](https://docs.godotengine.org/en/4.7/tutorials/math/vector_math.html)
- [Node2D](https://docs.godotengine.org/en/4.7/classes/class_node2d.html)
