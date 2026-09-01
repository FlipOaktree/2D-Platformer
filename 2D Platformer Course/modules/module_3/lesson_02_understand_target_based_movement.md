# Module 3, Lesson 2: Understand Target-Based Movement

**Status:** Validated

## By the end

Understand the movement model that will make the Player accelerate and
decelerate in the next lesson. You will trace how a current horizontal
velocity approaches a target over repeated physics updates without changing
the Godot project yet.

- Distinguish maximum speed, target velocity, and current velocity.
- Explain how acceleration and deceleration change velocity over time.
- Read the three values passed to `move_toward()`.
- Explain why a time-based rate is multiplied by `delta`.

## Before you start

- Module 3, Lesson 1 is complete and validated.
- You know that `direction * speed` produces the Player's requested horizontal
  velocity.
- You have used function arguments and returned values.
- You have used `_physics_process()` and multiplied gravity by `delta`.
- You have read `if`, `else`, and comparison operators.

This is a theory lesson. You will read and trace small examples, but you will
not edit `player.gd` or another project file.

## Build steps

### Part 1: Separate the current value from the target

The validated Player currently uses this direct assignment:

```gdscript
velocity.x = direction * speed
```

The right side calculates the requested horizontal velocity. The assignment
immediately replaces the current `velocity.x` with that result.

With the default `speed` of `300.0`, common input values produce these results:

| `direction` | Input | `direction * speed` |
| ---: | --- | ---: |
| `-1.0` | Full left | `-300.0` |
| `0.0` | No horizontal input | `0.0` |
| `1.0` | Full right | `300.0` |
| `0.5` | Half-strength right stick | `150.0` |

> 💡 A **target velocity** is the horizontal velocity requested by the current
> input. The **current velocity** is the value the Player has reached so far.
> Direct assignment makes both values equal immediately. Target-based movement
> keeps them separate so the current value can approach the target over time.

For example, the target may be `300.0` while the current `velocity.x` is only
`80.0`. On the next physics update, the current value can move closer without
jumping directly to the target.

### Part 2: Change velocity at a rate

`speed` and acceleration describe different parts of movement:

| Setting | What it controls | Unit |
| --- | --- | --- |
| `speed` | The maximum horizontal velocity requested by full input | Pixels per second |
| `acceleration` | How quickly current velocity approaches an input target | Pixels per second squared |
| `deceleration` | How quickly current velocity approaches zero without input | Pixels per second squared |

> 💡 An acceleration of `1200.0` pixels per second squared means horizontal
> velocity can change by `1200.0` pixels per second over one second. It does
> not mean the Player moves `1200.0` pixels in one second.

At approximately 60 physics updates per second, `delta` is approximately
`1.0 / 60.0`. Multiplying the rate by that elapsed time gives the maximum
velocity change for one update:

```text
acceleration × delta
1200.0 × (1.0 / 60.0) = 20.0
```

With deceleration set to `1800.0`, the same example gives:

```text
deceleration × delta
1800.0 × (1.0 / 60.0) = 30.0
```

Godot does not need every update to last exactly `1.0 / 60.0` seconds. Using
the actual `delta` keeps the change based on elapsed time when an update is a
little shorter or longer.

### Part 3: Move one number toward another

> 💡 `move_toward()` is a global GDScript function that produces a number
> closer to a target. It receives three values: the current value, the target
> value, and the maximum amount the current value may change during this
> update. It stops exactly at the target rather than passing it.
>
> For example, `move_toward(0.0, 300.0, 20.0)` returns `20.0`. If the current
> value is already `290.0`, it returns `300.0`, not `310.0`.
>
> Inside `_physics_process()`, Godot calls this code repeatedly. With this
> example, the value can increase by up to `20.0` on each physics update until
> it reaches the target value, `300.0`.

Trace the first updates of that example:

| Physics update | Current value | Target | Maximum change | Returned value |
| ---: | ---: | ---: | ---: | ---: |
| 1 | `0.0` | `300.0` | `20.0` | `20.0` |
| 2 | `20.0` | `300.0` | `20.0` | `40.0` |
| 3 | `40.0` | `300.0` | `20.0` | `60.0` |
| Near target | `290.0` | `300.0` | `20.0` | `300.0` |

`move_toward()` returns the new number; it does not change `velocity.x` by
itself. The next lesson will assign that returned value back to the property:

```gdscript
velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
```

Read its arguments from left to right:

| Argument | Meaning |
| --- | --- |
| `velocity.x` | Current horizontal velocity |
| `target_speed` | Horizontal velocity requested by input |
| `acceleration * delta` | Maximum change during this physics update |

### Part 4: Compare acceleration and deceleration

The same function can approach a movement target or a complete stop. Only the
target and rate change:

| Situation | Target | Maximum change |
| --- | --- | --- |
| Horizontal input is held | `direction * speed` | `acceleration * delta` |
| No horizontal input is held | `0.0` | `deceleration * delta` |

Suppose current velocity is `60.0`, no horizontal input is held, and the
maximum deceleration change is `30.0`:

| Physics update | Current value | Target | Maximum change | Returned value |
| ---: | ---: | ---: | ---: | ---: |
| 1 | `60.0` | `0.0` | `30.0` | `30.0` |
| 2 | `30.0` | `0.0` | `30.0` | `0.0` |
| 3 | `0.0` | `0.0` | `30.0` | `0.0` |

The value reaches zero without passing it and becoming negative. A condition
in the next lesson will choose acceleration while input exists and
deceleration when it does not.

## Learner exercise

Without opening Godot, answer these questions:

1. If `direction` is `-1.0` and `speed` is `300.0`, what is the target
   horizontal velocity?
2. Starting at `0.0`, trace the next three results when the target is `300.0`
   and the maximum change is `20.0`.
3. What does `move_toward(290.0, 300.0, 20.0)` return, and why?
4. Starting at `60.0`, trace two updates toward `0.0` with a maximum change of
   `30.0`.
5. Explain why `move_toward()` must be called repeatedly to create gradual
   movement.
6. Explain why acceleration is multiplied by `delta` before it is used as the
   maximum change.
7. Explain the difference between maximum speed, target velocity, and current
   velocity.

## Verification checklist

- [ ] The learner can distinguish current velocity from target velocity.
- [ ] The learner can calculate `direction * speed` for left, no input, right,
      and partial analog input.
- [ ] The learner can distinguish maximum speed from acceleration and
      deceleration.
- [ ] The learner can identify the current value, target, and maximum-change
      arguments passed to `move_toward()`.
- [ ] The learner understands that `move_toward()` returns a value and does not
      change `velocity.x` unless that result is assigned.
- [ ] The learner can trace repeated movement toward a target without passing
      it.
- [ ] The learner can explain why multiplying a per-second rate by `delta`
      produces the allowed change for one physics update.
- [ ] No Godot project file was changed during this theory lesson.

## References

- [GlobalScope `move_toward()`](https://docs.godotengine.org/en/4.7/classes/class_%40globalscope.html#class-globalscope-method-move-toward)
- [Idle and Physics Processing](https://docs.godotengine.org/en/4.7/tutorials/scripting/idle_and_physics_processing.html)
- [CharacterBody2D](https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html)
