# 2D Platformer Course Roadmap

## Purpose and Authority

This file is the canonical source for the course scope, curriculum sequence,
architecture, progress, dependencies, and exact next lesson. It lets a new
Codex task recover the course direction from the repository instead of relying
on chat history.

| Source | Authority |
| --- | --- |
| `AGENTS.md` | Instructions for recovering context and working safely |
| `2D Platformer Course/course_roadmap.md` | Curriculum, architecture, progress, and next step |
| `2D Platformer Course/course_workflow.md` | Lesson planning, implementation, validation, and lesson lifecycle |
| Lesson Markdown | Canonical learner instructions |
| Godot project | Evidence of implemented behavior |

If these sources disagree, report the discrepancy before making changes. Do
not infer progress from chat history or from learner verification checkboxes.

## Current Course State

- **Course goal:** Build and validate a beginner-friendly written course that
  produces a modular Godot 2D platformer template by following the same steps
  learners will use.
- **Validated curriculum:** Module 0, Lessons 0.1-0.4; Module 1, Lessons
  1.1-1.6, which completes Module 1; Module 2, Lessons 2.1-2.12; Module 3,
  Lessons 3.1-3.6, which completes Module 3; and Module 4, Lesson 4.1.
  Lesson 1.2 was replay-verified
  against a scratch copy of Lesson 1.1's validated end state (`e918e66`): its
  Part 2-4 settings, applied there, reproduced the live project's `[display]`
  block exactly, the Label survived, and a headless load and run produced no
  errors or warnings. The
  lessons that state Floor, platform, or jump values were revised for the
  1920-by-1080 viewport and the retuned movement defaults. The
  coordinate-theory split, revised transform and composition procedures,
  dot-syntax bridge, horizontal movement, gravity/floor procedures,
  conditional floor-state procedure, jumping procedure, exported movement
  settings, target-based horizontal acceleration and deceleration, coyote
  time, jump buffering, and variable jump height remain validated. Lesson 0.4 is
  validated from the current Codex
  project, Git metadata, and Changes-to-Review UI evidence; an empty-project
  replay remains part of the full-course rebuild gate.
- **Godot evidence:** The project draws a 1920-by-1080 viewport with stretch
  mode `canvas_items` and aspect `keep`. `Main` contains one inherited `Player`
  instance at
  `(128, 128)`, a `Floor` `StaticBody2D` at `(960, 920)` with a 1920-by-64
  rectangle collision shape, and a centered `CoyoteTestPlatform` `StaticBody2D`
  at `(960, 704)` with its own 512-by-32 rectangle collision shape, leaving a
  200-pixel step between the Floor surface and the platform surface. The Input
  Map defines
  `move_left`, `move_right`, and `jump`, each with a deadzone of `0.2` and the
  validated keyboard/controller events. `res://actors/actor.tscn` provides the
  shared `CharacterBody2D` structure with a 32-by-32 placeholder collider.
  `res://actors/player.tscn` inherits it with `res://actors/player.gd`
  attached, then overrides the collider with a 128-by-128 rectangle matching
  its temporary 128-by-128 `Sprite2D` marker beneath `Visuals`.
  `Main` also holds an empty `Terrain` `TileMapLayer` at `(0, 0)` using
  `res://levels/tiles/terrain_tileset.tres`, a 47-tile TileSet of 128-pixel
  tiles built from `res://levels/tiles/terrain.png`, every tile carrying one
  full-square collision polygon on a single physics layer. That is the Lesson
  4.1 result; the temporary `Floor` and `CoyoteTestPlatform` are still present
  because Lesson 4.2 removes them.
- **Code state:** `res://actors/player.gd` implements typed horizontal
  movement through `Input.get_axis()`, a target horizontal speed, and
  `move_toward()` with exported acceleration and deceleration rates. It uses a
  `coyote_timer` countdown and `can_jump` condition to allow a short
  grace-period jump after leaving the raised test platform. It also uses a
  `jump_buffer_timer` and `has_jump_request` condition to remember a recent
  jump press until landing. It shortens a rising jump by multiplying
  `velocity.y` by `jump_release_multiplier` when the `jump` action is released,
  giving variable jump height. It retains `move_and_slide()`, gravity, and
  grounded jumping. `jump_velocity` defaults to `-1100.0` against a `2400.0`
  gravity, which lifts the 128-pixel Player 261 pixels, about twice its own
  height, in a 0.97-second jump. Horizontal movement runs at `450.0` pixels per
  second and reaches that speed in about a quarter of a second. Modules 3.1-3.5
  are validated in the current project: the eight movement values use
  documented `@export_range()` annotations, and the jump, gravity, and
  jump-shortening conditions have regular implementation comments. Other
  gameplay systems remain absent.
- **Observed Git head:** `d4d0b09` (`Add five evidence rules for recurring
  mistakes`), with a clean working tree. Local `main` is one commit ahead of
  `origin/main`, which is at `b653f5d`.
- **Exact next step:** Settle Lesson 4.2's peering-bit data, then implement it.
  The lesson is a drafted blueprint and the only part still unproven is how
  each tile's terrain marks should be set. The practical route is to configure
  the terrain once in the editor against the configured example in Godot's
  **Using TileSets** page, then read the marks back out of the saved
  `terrain_tileset.tres` and turn them into a checkable reference for the
  lesson. Lesson 4.1 is Validated: its procedure was walked in the editor, and
  four steps were corrected in the process. Automatic tile creation was found
  to fill the whole grid rather than skip the fully transparent square, which
  the Godot page's wording had suggested it would, so the lesson now creates
  48 tiles and deletes `(10, 1)` by right-clicking it. The square was confirmed
  to be genuinely empty, with a maximum alpha of `0.0` across all 16384 pixels,
  so the artwork is not the cause. The other corrections were holding `Shift`
  while dragging to select every tile, switching the atlas from **Setup** to
  **Select** before editing tile properties, and drawing each collision polygon
  with the **Add points** tool by clicking the four corners, since a tile
  starts with no polygon at all. Both lessons use `terrain.png`, which is a 2x
  redraw of the
  terrain example tilesheet in Godot's own **Using TileSets** page: the same
  12-by-4 arrangement, the same four shapes, and the same hole at `(10, 1)`.
  Lesson 4.2 does not publish a per-tile peering-bit table. Two attempts to
  derive one failed and were discarded: reading it from the artwork stalls
  because an open bottom edge is drawn the same plain ground as a bottom that
  continues, and assuming each drawn shape is a solid rectangle produces a
  terrain that paints every cell while putting grass along the underside of
  the level. The shapes carry notches that the rectangle model misses. The
  lesson therefore teaches reading the marks from the artwork, points at the
  configured example in the Godot page as a second opinion, and states plainly
  that an absence of empty cells does not mean the terrain is right. Producing
  a verified table belongs to implementing the lesson. The level geometry was
  re-measured for 128-pixel tiles in a scratch copy: the ground surface stays
  at `y = 896` and the Player still rests with its collider bottom there, the
  terrace moves to `y = 768` for a one-tile step of 128 pixels, a held jump
  rises 261 pixels leaving 133 pixels of clearance, and a tapped jump reaches
  95 pixels so it still cannot make the step. A two-tile step of 256 pixels
  would leave 5 pixels and must not be used.
  Module 1, Lesson 1.2, **Set Up the Game Window**, is now
  Validated: its procedure was replayed from Lesson 1.1's end state in a
  scratch copy and reproduced the live project's window settings exactly. The
  **Track Player Movement States** blueprint stays drafted at Lesson 5.5 until
  Module 5 is reached, and must be re-checked against the Module 4 result
  before implementation. Module 6 was also restructured to open with extracting
  input and movement into components, so 5.5 writes the movement state into
  `player.gd` and Lesson 6.1 then moves it into the movement component that
  owns it.
- **Checkpoint:** Commit `8e07139` contains the validated curriculum through
  Module 2, validated Module 3 Lessons 3.1-3.5, the movement-state blueprint
  relocated to Lesson 5.5, and the Lesson 0.4 revision that creates the first
  checkpoint with Git commands. Commit `c1874a8` then validated Lesson 3.6 and
  closed Module 3. Commits `3abdd88`, `5ca7c9d`, and `b9ccbd2` set the
  1920-by-1080 world, retuned movement, and recorded the interactive
  confirmation; `6c74ab2` and `ffa165d` repaired Lesson 1.2 Part 5; `b653f5d`
  and `d4d0b09` corrected two stale references and added the evidence rules.
  Commit `2a23afa` validated
  the Module 3.1 Player settings alongside a standalone target-based movement
  bridge; commit `3b0f0c5` superseded that bridge with the Lesson 2.8
  direct-assignment clarification and the integrated Lesson 3.2 acceleration
  and Lesson 3.3 coyote-time features; commit `dd966c0` added the Lesson 3.4
  jump-buffering feature. Headless Godot loading and runtime checks passed for
  Lessons 3.2 and 3.3, followed by successful interactive validation. Lesson
  3.4 received focused Godot validation. Lesson 3.5 passed headless parse,
  load, and behavior checks, then passed interactive Godot validation
  including the Inspector presentation of **Jump Release Multiplier** and
  keyboard/controller jump testing. The 1920-by-1080 viewport change and the
  movement retune each passed a headless check of every stated value, geometry
  measurement, and timing, and the retuned jump and run speed were then
  confirmed by interactive play.

## Status Model

Track lesson progress and Git association independently:

- **Lifecycle:** Planned -> Blueprint drafted -> Blueprint approved ->
  Implemented -> Validated.
- **Git:** Unassigned, Uncommitted working tree, or an identified commit.

All lessons after 1.1 are provisional until their blueprints are reviewed.
Unless a row says otherwise, lessons in a module are completed in order and
depend on the preceding lesson.

## Curriculum Modularity

Treat each module as a cohesive learning and implementation unit with explicit
prerequisites, a focused outcome, and a clear resulting project state.

- Give each feature core one canonical home. Later modules may integrate with
  that feature, but must not redefine or duplicate its core instruction.
- Keep potentially reusable modules free of unnecessary platformer-specific
  assumptions. Genre-specific behavior belongs where the course genuinely
  diverges.
- Interpret modularity as clear boundaries and explicit dependencies, not as a
  promise that modules can be combined safely in any order.
- Use this complete 2D Platformer course as the proving ground for module
  boundaries and portability.

Defer shared-module libraries, configurable course manifests, and validated
alternate entry checkpoints until the complete written course has passed its
empty-project rebuild. Reconsider them only after repeated use shows which
modules transfer unchanged to another course or learner level.

## Framework Architecture

Use shallow inheritance plus composition:

- A small shared `Actor` definition supports players, NPCs, and enemies.
- `Actor` contains only universal identity, scene structure, and component
  attachment points.
- Movement, health, damage, combat, inventory, equipment, interaction,
  dialogue, quests, faction, and persistence remain removable capabilities.
- Player, NPC, and enemy scenes specialize `Actor` without inheriting
  irrelevant features.
- Systems communicate through typed methods and signals, not fragile node
  paths or repeated actor-type checks.
- An actor script is an orchestrator. It owns the body state that only the
  body can own, such as `velocity`, `is_on_floor()`, and the single call to
  `move_and_slide()`, and it drives its components in a defined order.
- Components own their own configuration and their own runtime state. They do
  not reach upward into their owner and do not call `move_and_slide()`.
- Input is separated from movement by an intent boundary. An input component
  turns devices into intent, such as a direction and whether jump is pressed
  or held; a movement component consumes intent and never reads `Input`. A
  non-player actor supplies the same intent from an AI source instead, which
  is what makes one movement component serve players, NPCs, and enemies.
- Data-driven content uses Godot Resources and stable IDs.
- Global services are limited to state that genuinely crosses scenes, such as
  scene flow, saving, settings, and persistent quest state.

Shared components should be demonstrated on at least two compatible actor
types where practical. Optional features must eventually pass add, remove,
customize, save/load, and regression checks.

## System Boundaries

- **Inventory:** Item definitions, stack entries, capacity, add/remove/count
  operations, and change signals form the core. Equipment is a separate
  optional component. Representative consumables and equipment are included;
  crafting, shops, and complex grids are extension topics.
- **Dialogue:** Resource-driven entries, choices, conditions, and actions
  support branching, quest-aware conversations without a custom graph editor.
- **Quests:** Resource-driven definitions and composable collect, defeat,
  interact, and reach-location objectives support prerequisites, rewards, and
  a journal.
- **Saving:** Versioned data, manual slots, autosave, separate settings, stable
  IDs, validation, migration, atomic replacement, backup, reset, and recovery
  form the persistence target.
- **Combat:** Reusable damage contracts, melee attacks, projectiles, knockback,
  invulnerability, factions, and removable combat components.
- **Enemies:** Patrol, chase, and flying variants reuse actor, movement,
  health, combat, and persistence features.

The first release does not include procedural generation, networking, a
custom dialogue editor, crafting, shops, or a complex grid inventory. Prefer
small extensible cores over feature-heavy implementations.

## Curriculum and Progress

### Module 0: Project Setup

**Outcome:** Install the learner toolchain, create the empty project, connect
its folder to Codex, and place it under version control.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 0.1 | Install Godot and Codex | Tool installation, Windows-native Codex, approval setting; no project association | Validated | `2452c6e` |
| 0.2 | Create an Empty Godot Project | Project Manager, renderer, `project.godot`, exact existing folder path | Validated | `2452c6e` |
| 0.3 | Install and Configure Git | Git installation, global commit identity, and default branch; no repository yet | Validated | `2452c6e` |
| 0.4 | Connect the Existing Project to Codex and Create the First Git Checkpoint | Existing-folder association, repository, read-only AI review, staging, diff, commit, Godot metadata | Validated | `2452c6e`; clean-project replay deferred to the full-course rebuild |

### Module 1: Godot Scene Foundations

**Depends on:** Module 0. **Outcome:** Understand nodes, scenes, 2D coordinates,
basic transforms, parent-relative positioning, scene composition, and instance
overrides before gameplay code is introduced, then record the tested result in
a reviewed Git checkpoint.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 1.1 | Create and Run Your First Scene | `Node2D`, `Label`, hierarchy, `main.tscn`, running, viewport navigation | Validated | `2452c6e` |
| 1.2 | Set Up the Game Window | Viewport size versus window size, `1920`-by-`1080` world, stretch mode and aspect, window override | Validated | `3abdd88`; Part 5 repaired in `6c74ab2` and `ffa165d`; replay-verified against the Lesson 1.1 end state in `e918e66` |
| 1.3 | Understand 2D Coordinates | Coordinate pairs, origin, screen axes, and local positions | Validated | Committed; exact commit pending reconciliation |
| 1.4 | Transform Nodes in 2D | `ProjectIcon`, Position, Rotation, Scale, toolbar tools, and applied parent-relative transforms | Validated | Committed; exact commit pending reconciliation |
| 1.5 | Compose Scenes from Reusable Parts | Reusable child scenes, source propagation, per-instance overrides | Validated | Committed; exact commit pending reconciliation |
| 1.6 | Create a Module 1 Git Checkpoint | Tested module boundary, Codex-assisted read-only review, local commit, and post-commit verification | Validated | `2452c6e` |

### Module 2: Actor and Player Foundations

**Depends on:** Module 1. **Outcome:** Establish the shared actor boundary and
a basic keyboard/controller player without premature feature inheritance, then
record the tested foundation in a reviewed Git checkpoint.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 2.1 | Configure Keyboard and Controller Actions | Input Map and action abstraction | Validated | `624d69b` |
| 2.2 | Build the Shared Actor Scene | Small `Actor` base and attachment points | Validated | `62a02c3` |
| 2.3 | Specialize Actor into a Player | Scene inheritance/specialization | Validated | `2452c6e` |
| 2.4 | Understand GDScript Fundamentals | GDScript syntax, comments, values, types, variables, and operators | Validated | `2452c6e` |
| 2.5 | Attach and Run Your First Player Script | Script attachment, `extends`, functions, callbacks, Output, local and script-level scope, and custom function calls | Validated | `2452c6e` |
| 2.6 | Use Function Parameters and Return Values | Typed parameters, arguments, return types, and returned values | Validated | Committed; exact commit pending reconciliation |
| 2.7 | Access Properties and Call Methods | Dot syntax, properties, and methods on existing values | Validated | `cf34c54` |
| 2.8 | Write Typed Horizontal Movement | Temporary `Sprite2D` test marker and matching Player collider override, typed movement speed, physics callback, input axis, velocity, and `move_and_slide()` | Validated | `3b0f0c5` |
| 2.9 | Add Gravity and Floor Collision | `StaticBody2D`, aligned Player/floor collision, gravity, and `delta` | Validated | `9f0efc4` |
| 2.10 | Use Conditions to Respond to Floor State | `if`, `else`, `not`, conditions, and `is_on_floor()` | Validated | `ae5d31c`; audit fix in `5efd79a` |
| 2.11 | Add Jumping | Jump action, one-time input checks, compound conditions, and vertical velocity | Validated | `cf34c54` |
| 2.12 | Create a Module 2 Git Checkpoint | Tested Player foundation, Codex-assisted read-only review, local UI commit, and post-commit verification | Validated | `2452c6e` |

### Module 3: Responsive Player Movement

**Depends on:** Module 2. **Outcome:** Turn basic movement into a configurable,
responsive controller.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 3.1 | Expose Safe Movement Settings | Exported properties, defaults, tooltips | Validated | Validated in `2a23afa`; sequence-reference revision in `3b0f0c5` |
| 3.2 | Add Acceleration and Deceleration | Current and target velocity, exported acceleration/deceleration settings, `delta`, `move_toward()`, and target-based horizontal movement | Validated | `3b0f0c5`; headless and interactive validation passed |
| 3.3 | Add Coyote Time | Configurable jump grace period, runtime countdown, `or`, and a raised reusable test platform | Validated | `3b0f0c5`; headless and interactive validation passed |
| 3.4 | Add Jump Buffering | Configurable pre-landing input memory, request/permission separation, and a consumed countdown | Validated | `dd966c0`; focused Godot validation passed |
| 3.5 | Add Variable Jump Height | Released-input detection, proportional velocity change, and a rising-only condition | Validated | `63f1115`; headless behavior checks and interactive Godot validation passed |
| 3.6 | Create a Module 3 Git Checkpoint | Tested module boundary, Inspector default audit, Codex-assisted read-only review, local commit, and post-commit verification | Validated | `3c28cb6`; expected file list, staging, commit, and verification commands replayed in a scratch clone; Codex UI path deferred to the full-course rebuild |

### Module 4: Modular Level Building

**Depends on:** Module 3. **Outcome:** Create reusable levels and platform
elements around clear spawn and boundary contracts.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 4.1 | Build a TileSet with Collision | TileSet resource, atlas source, 128-pixel tile size, a tile physics layer, and per-tile collision polygons across 47 tiles | Validated | Uncommitted working tree; procedure walked in the editor and four UI steps corrected |
| 4.2 | Paint a Level with Terrain Autotiling | Terrain set, Match Corners and Sides mode, peering bits, terrain painting, and removal of the temporary Floor and CoyoteTestPlatform | Blueprint drafted | Uncommitted working tree |
| 4.3 | Build a Reusable Level Scene | Level scene boundary | Planned | Unassigned |
| 4.4 | Add Player Spawn Points | Spawn marker contract | Planned | Unassigned |
| 4.5 | Add One-Way Platforms | One-way collision | Planned | Unassigned |
| 4.6 | Add Moving Platforms | Reusable moving surface | Planned | Unassigned |
| 4.7 | Add Level Bounds and Fall Detection | World bounds and fall signal | Planned | Unassigned |
| 4.8 | Create a Module 4 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 5: Camera and Character Presentation

**Depends on:** Module 4. **Outcome:** Present movement clearly with a reusable
camera and animated character visuals, making the Player's movement state
explicit where the animation work first needs it.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 5.1 | Add a Following Camera | `Camera2D` ownership | Planned | Unassigned |
| 5.2 | Configure Camera Limits and Smoothing | Limits and smoothing | Planned | Unassigned |
| 5.3 | Add Look-Ahead Behavior | Camera behavior component | Planned | Unassigned |
| 5.4 | Import Character Art | Import settings and sprite presentation | Planned | Unassigned |
| 5.5 | Track Player Movement States | `enum`, a stored movement state, and nested conditions decided after `move_and_slide()`; the state moves into the movement component in Lesson 6.1 | Blueprint drafted | `34c9235`; retuned values in `3abdd88` and `5ca7c9d` |
| 5.6 | Animate and Face the Player | Animation and facing direction | Planned | Unassigned |
| 5.7 | Create a Module 5 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 6: Shared Actor Capabilities

**Depends on:** Modules 2-5. **Outcome:** Turn the Player's built-in movement
into reusable components, then add the common removable capabilities that later
player, NPC, and enemy features reuse.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 6.1 | Extract Input and Movement into Components | Component contract, the intent boundary, an orchestrator script, and refactoring working code without changing its behavior | Planned | Unassigned |
| 6.2 | Reuse Movement on a Second Actor | A minimal NPC driven by the same movement component through a different intent source | Planned | Unassigned |
| 6.3 | Create a Reusable Health Component | Health API and change signals | Planned | Unassigned |
| 6.4 | Build a Destructible Box | An actor with health and no movement or input, proving components are independent | Planned | Unassigned |
| 6.5 | Create Hitbox and Hurtbox Components | Damage contract and collision layers | Planned | Unassigned |
| 6.6 | Add Actor Factions | Faction data and targeting rules | Planned | Unassigned |
| 6.7 | Add an Interaction Component | Generic interaction contract | Planned | Unassigned |
| 6.8 | Add Persistent Actor Identity | Stable persistent IDs | Planned | Unassigned |
| 6.9 | Customize and Remove Actor Components | Optional-component verification | Planned | Unassigned |
| 6.10 | Create a Module 6 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 7: Hazards, Defeat, and Respawning

**Depends on:** Modules 4 and 6. **Outcome:** Connect reusable damage and actor
identity to recovery and level reset behavior.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 7.1 | Build a Reusable Hazard | Hazard using damage contract | Planned | Unassigned |
| 7.2 | Handle Actor Defeat | Defeat signal and policy | Planned | Unassigned |
| 7.3 | Respawn the Player | Respawn flow | Planned | Unassigned |
| 7.4 | Add Respawn Checkpoints | Respawn checkpoint state | Planned | Unassigned |
| 7.5 | Reset Level Actors Safely | Reset contract across actors | Planned | Unassigned |
| 7.6 | Create a Module 7 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 8: Player Combat

**Depends on:** Module 6. **Outcome:** Add removable melee and ranged combat
through the shared damage and faction contracts.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 8.1 | Add Attack Input and Timing | Attack action, cooldown, timing | Planned | Unassigned |
| 8.2 | Build a Melee Attack | Reusable melee hitbox | Planned | Unassigned |
| 8.3 | Build a Reusable Projectile | Projectile scene and ownership | Planned | Unassigned |
| 8.4 | Add Knockback | Damage response data | Planned | Unassigned |
| 8.5 | Add Temporary Invulnerability | Invulnerability window | Planned | Unassigned |
| 8.6 | Customize or Remove Combat | Combat add/remove regression | Planned | Unassigned |
| 8.7 | Create a Module 8 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 9: Modular Enemies

**Depends on:** Modules 6 and 8. **Outcome:** Reuse actor capabilities across
distinct ground and flying enemy behaviors.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 9.1 | Specialize Actor into an Enemy | Enemy specialization | Planned | Unassigned |
| 9.2 | Create a Patrolling Enemy | Patrol behavior | Planned | Unassigned |
| 9.3 | Add Ledge and Wall Detection | Environment sensors | Planned | Unassigned |
| 9.4 | Create a Chasing Enemy | Targeting and chase behavior | Planned | Unassigned |
| 9.5 | Create a Flying Enemy | Alternate movement capability | Planned | Unassigned |
| 9.6 | Handle Enemy Defeat, Drops, and Reset | Enemy lifecycle and drops | Planned | Unassigned |
| 9.7 | Create a Module 9 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 10: Items, Inventory, and Equipment

**Depends on:** Modules 6 and 9. **Outcome:** Build a data-driven inventory core
with optional equipment and reusable world items.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 10.1 | Define Reusable Items with Resources | Item Resource and stable item ID | Planned | Unassigned |
| 10.2 | Build the Inventory Data Model | Stacks, capacity, add/remove/count | Planned | Unassigned |
| 10.3 | Add an Inventory Component to an Actor | Inventory attachment and signals | Planned | Unassigned |
| 10.4 | Create Item Pickups and Drops | World/inventory transfer contract | Planned | Unassigned |
| 10.5 | Build the Inventory Interface | Inventory view decoupled from data | Planned | Unassigned |
| 10.6 | Add Consumable Items | Item-use contract | Planned | Unassigned |
| 10.7 | Add an Equipment Component | Optional equipment capability | Planned | Unassigned |
| 10.8 | Extend Inventory Without Changing Its Core | Extension and regression exercise | Planned | Unassigned |
| 10.9 | Create a Module 10 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 11: NPCs and Dialogue

**Depends on:** Modules 6 and 10. **Outcome:** Add NPC specialization and
Resource-driven branching dialogue through the shared interaction contract.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 11.1 | Specialize Actor into an NPC | NPC specialization | Planned | Unassigned |
| 11.2 | Start Interaction-Based Conversations | Conversation trigger contract | Planned | Unassigned |
| 11.3 | Define Dialogue with Resources | Dialogue entries and stable IDs | Planned | Unassigned |
| 11.4 | Present Dialogue in the Interface | Dialogue view/controller separation | Planned | Unassigned |
| 11.5 | Add Branching Choices | Choice paths | Planned | Unassigned |
| 11.6 | Add Conditions and Actions | Data-driven conditions/actions | Planned | Unassigned |
| 11.7 | Reuse Dialogue Across NPCs | Dialogue reuse verification | Planned | Unassigned |
| 11.8 | Create a Module 11 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 12: Quests and Objectives

**Depends on:** Modules 9-11. **Outcome:** Track data-driven quests with
composable objectives connected to dialogue, combat, items, and locations.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 12.1 | Define Quests with Resources | Quest definitions, IDs, prerequisites | Planned | Unassigned |
| 12.2 | Build the Quest Log | Runtime quest state | Planned | Unassigned |
| 12.3 | Create the Objective Contract | Composable objective interface | Planned | Unassigned |
| 12.4 | Add Collect and Defeat Objectives | Inventory/combat event objectives | Planned | Unassigned |
| 12.5 | Add Interaction and Location Objectives | Interaction/location event objectives | Planned | Unassigned |
| 12.6 | Connect Quests to Dialogue | Quest-aware conditions and actions | Planned | Unassigned |
| 12.7 | Deliver Quest Rewards | Reward contract | Planned | Unassigned |
| 12.8 | Build the Quest Journal | Quest view decoupled from state | Planned | Unassigned |
| 12.9 | Create a Module 12 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 13: World Progression and Game Flow

**Depends on:** Modules 4, 7, and 12. **Outcome:** Move between levels while
preserving the world and actor state that should survive transitions.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 13.1 | Add Collectibles Outside Inventory | Dedicated progression collectibles | Planned | Unassigned |
| 13.2 | Add Level Goals | Goal completion contract | Planned | Unassigned |
| 13.3 | Transition Between Levels | Scene transitions | Planned | Unassigned |
| 13.4 | Centralize Scene Flow | Minimal cross-scene service | Planned | Unassigned |
| 13.5 | Build Title, Restart, and Game-Over Flows | Game flow states | Planned | Unassigned |
| 13.6 | Restore Persistent Actors Across Levels | Cross-level actor restoration | Planned | Unassigned |
| 13.7 | Create a Module 13 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 14: HUD, Menus, and Settings

**Depends on:** Modules 10, 12, and 13. **Outcome:** Present gameplay state and
settings without coupling UI to concrete actor implementations.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 14.1 | Build the Gameplay HUD | HUD scene boundary | Planned | Unassigned |
| 14.2 | Display Health, Inventory, and Objectives | Signal-driven state displays | Planned | Unassigned |
| 14.3 | Add a Pause Menu | Pause behavior | Planned | Unassigned |
| 14.4 | Add Audio Settings | Audio preferences | Planned | Unassigned |
| 14.5 | Add Display and Accessibility Settings | Display/accessibility preferences | Planned | Unassigned |
| 14.6 | Keep UI Independent from Actor Implementations | UI dependency audit | Planned | Unassigned |
| 14.7 | Create a Module 14 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 15: Saving and Persistence

**Depends on:** Modules 6, 10, 12-14. **Outcome:** Save and restore modular
framework state safely across versions and failure cases.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 15.1 | Define Stable Saveable Identities | Saveable identity contract | Planned | Unassigned |
| 15.2 | Define the Versioned Save Schema | Versioned save data | Planned | Unassigned |
| 15.3 | Capture and Restore Modular Component State | Component persistence contract | Planned | Unassigned |
| 15.4 | Create Manual Save Slots | Multiple slots and metadata | Planned | Unassigned |
| 15.5 | Add Autosave | Autosave policy | Planned | Unassigned |
| 15.6 | Persist Inventory, Quests, Dialogue, and World State | Integrated persistent state | Planned | Unassigned |
| 15.7 | Persist Settings Separately | Settings storage boundary | Planned | Unassigned |
| 15.8 | Migrate Older Save Versions | Migration functions | Planned | Unassigned |
| 15.9 | Validate, Back Up, Reset, and Recover Save Data | Atomic replace and recovery | Planned | Unassigned |
| 15.10 | Create a Module 15 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 16: Audio and Gameplay Feedback

**Depends on:** Modules 5, 8, 13, and 14. **Outcome:** Add reusable feedback
that respects player preferences and accessibility settings.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 16.1 | Configure Audio Buses | Audio routing | Planned | Unassigned |
| 16.2 | Add Reusable Actor and World Sounds | Signal-driven sound components | Planned | Unassigned |
| 16.3 | Add Music Transitions | Music state transitions | Planned | Unassigned |
| 16.4 | Add Particles and Hit Flash | Reusable visual feedback | Planned | Unassigned |
| 16.5 | Add Camera Shake | Decoupled camera feedback | Planned | Unassigned |
| 16.6 | Respect Feedback Accessibility Settings | Reduced/disabled feedback paths | Planned | Unassigned |
| 16.7 | Create a Module 16 Git Checkpoint | Tested module boundary, reviewed local commit, and verification | Planned | Unassigned |

### Module 17: Validation, Packaging, and Extension

**Depends on:** Modules 0-16. **Outcome:** Prove that shared and optional
systems remain reusable, then package and document the framework.

| ID | Lesson | First concepts or artifacts | Lifecycle | Git |
| --- | --- | --- | --- | --- |
| 17.1 | Add Focused Automated Test Scenes | Deterministic test scenes | Planned | Unassigned |
| 17.2 | Test Shared Components Across Actor Types | Cross-actor component tests | Planned | Unassigned |
| 17.3 | Test Inventory, Quest, Dialogue, and Save Integration | System integration tests | Planned | Unassigned |
| 17.4 | Audit Add, Remove, and Customize Workflows | Optional-feature acceptance matrix | Planned | Unassigned |
| 17.5 | Assemble Demonstration Levels | Representative framework demos | Planned | Unassigned |
| 17.6 | Export the Framework Project | Export configuration | Planned | Unassigned |
| 17.7 | Document Extension and Licensing Rules | Extension guide and licenses | Planned | Unassigned |
| 17.8 | Create a Module 17 Git Checkpoint | Final tested course and framework checkpoint | Planned | Unassigned |

## Concept Sequencing Ledger

Use this ledger before drafting so concepts are introduced near their first
practical use and later lessons can build on them without re-teaching them.

| Concept family | First introduction | Principal reuse |
| --- | --- | --- |
| Nodes, scenes, hierarchy, running, and viewport navigation | 1.1 | Every later lesson |
| Viewport size, window size, stretch mode, and aspect | 1.2 | Every placed position and size, level design, cameras, and UI |
| Coordinate pairs, screen axes, and local positions | 1.3 | Transforms, levels, actors, cameras, combat, enemies, feedback, UI |
| Position, Rotation, Scale, toolbar tools, and applied parent-relative transforms | 1.4 | Levels, actors, cameras, combat, enemies, feedback, UI |
| Scene composition, instantiation, source propagation, and instance overrides | 1.5 | Actors, components, levels, attacks, enemies, items |
| Codex project context, read-only requests, and diff review | 0.4 | AI-assisted changes, review, debugging, testing, and documentation |
| Git checkpoint cycle | 0.3-0.4 | End-of-module recovery points and reviewed course milestones |
| Input actions and device abstraction | 2.1 | Movement, combat, interaction, UI |
| Actor boundary and specialization | 2.2-2.3 | Player, NPCs, enemies |
| Physics bodies and collision shapes | 2.2 | Movement, levels, platforms, combat, and enemies |
| GDScript fundamentals | 2.4 | All scripted gameplay |
| Script attachment, functions, callbacks, Output, local and script-level scope, and custom function calls | 2.5 | All scripted gameplay |
| Function parameters, arguments, and returned values | 2.6 | Input, physics, and reusable gameplay logic |
| Dot syntax, properties, and methods | 2.7 | All later engine and gameplay APIs |
| Built-in Godot access through `Input` | 2.8 | Movement, combat, interaction, and UI |
| Conditional logic and grounded state | 2.10 | Jumping, responsive movement, combat, and actor behavior |
| Player movement and physics | 2.8-2.11 | Responsive movement and actor behavior |
| Exported configuration | 3.1 | Reusable systems and content |
| TileSets, TileMapLayer, and per-tile collision | 4.1 | Level scenes, spawn points, one-way and moving platforms, level bounds, and all later level content |
| Terrain sets, Match Corners and Sides matching, and terrain painting | 4.2 | Every later level and platform element built from tiles |
| Target-based value changes and `move_toward()` | 3.2 | Responsive movement, cameras, and reusable behaviors |
| Jump grace windows, runtime countdowns, and `or` | 3.3 | Jump buffering and other short-lived gameplay allowances |
| Buffered input and request/permission separation | 3.4 | Combat, interaction, and responsive controls |
| Released-input detection and proportional velocity change | 3.5 | Held actions, charged abilities, and responsive controls |
| `enum` and a stored movement state | 5.5 | Animation, facing direction, enemy behavior, and combat state |
| Component contract, intent boundary, and orchestrator script | 6.1 | Every later component, and all NPC and enemy behavior |
| Signals and removable components | 6.1-6.9 | Combat, inventory, quests, UI, saving |
| Stable IDs and Resources | 6.8, 10.1 | Dialogue, quests, persistence |
| Minimal global services | 13.4 | Scene flow, saving, settings, quest state |
| Versioned persistence | 15.1-15.9 | All persistent systems |

### Downstream Transform Audit

The approved coordinate-theory split does not change the order of Modules
2-17. Later lessons may build on these foundations but must explain values
that are specific to the feature being built:

- Modules 2-4 may assume basic 2D coordinate, Position, Rotation, and Scale
  knowledge while explaining actor, physics, and level-specific choices in
  context.
- Module 5 reuses Sprite2D, texture assignment, and basic transforms for
  character presentation instead of introducing them for the first time.
- Modules 8-9 reuse transforms, reusable scenes, and instance overrides for
  attacks, projectiles, and enemy variants.
- Module 16 reuses Rotation and Scale when adding visual gameplay feedback.
- Modules 6-7, 10-15, and 17 need no lesson-boundary or dependency change from
  this revision; they may reuse the foundations wherever their practical
  implementation requires them.
- No later lesson should claim to introduce the 2D screen axes, local
  positions, Position, Rotation, Scale, source-scene propagation, or
  per-instance overrides for the first time.

## Production Gates After the Written Curriculum

These are production gates, not learner lessons:

1. Complete the visual support pass.
2. Rebuild the entire course from a new empty project.
3. Correct and revalidate every affected lesson.
4. Adapt validated lessons for recording.
5. Prepare learner downloads.
6. Freeze and record the supported Godot/course version.

## Audit Repair Record

The following editorial repairs preserve validated behavior and were completed
in the local course files:

- Lesson 1.1's local status now reflects its validated state.
- Lesson 1.1 no longer treats the single-word node name `Main` as an example
  of PascalCase; naming conventions will be introduced later with useful
  multiword examples.
- Lesson 0.4's missing step number is corrected.
- Lesson 0.3's recovery notes now sit beside the lesson parts they address.

Remaining reconciliation work:

- Propagate the roadmap's descriptive Module titles to local lesson and
  navigation material where needed.
- Reconcile the exact Git associations still marked pending for Lessons 1.3,
  1.4, and 2.6. Modules 0, 2, and 3 are reconciled, and Lesson 1.2 now names
  its commits.
- Replay Lesson 0.4's revised `Checkpoint empty Godot project` staging and
  commit path during the full-course empty-project rebuild. The production
  repository's earliest historical message differs and must not be rewritten
  merely to imitate the learner procedure.

## Decision Log

| Decision | Reason and downstream effect |
| --- | --- |
| Keep local Markdown files as the sole authoritative course record | New tasks can recover course state directly from the repository. |
| Store course material under `2D Platformer Course/` | The descriptive folder is the canonical home for the roadmap, workflow, lessons, and course assets. |
| Use a small `Actor` base plus removable components | Player, NPC, and enemy share only genuine common behavior. |
| Include combat, inventory, dialogue, quests, and robust saving in the core roadmap | The final template must support a coherent modular game framework, not only movement. |
| Defer visual production until the written curriculum is complete | Visuals should reflect validated steps and avoid repeated rework. |
| Keep learner verification boxes unchecked | They belong to each learner; production completion is tracked here. |
| Keep curriculum modules cohesive and portability-aware without introducing configurable course assembly yet | The first complete course will reveal which modules are genuinely reusable; shared libraries, course manifests, and alternate entry checkpoints remain deferred until then. |
| Teach viewport navigation when the first small Label appears in Lesson 1.1 | Centering, zooming, Pan Mode, and panning shortcuts solve an immediate viewing problem without changing scene content. |
| Separate 2D coordinates into a theory-focused Lesson 1.3 | Beginners can understand the origin, screen axes, and parent-relative local positions before applying them with editor tools; the existing transform and composition lessons move to 1.4 and 1.5 without changing the Godot result. |
| Teach Position, Rotation, and Scale together in Module 1 with a Sprite2D | Lesson 1.4 uses `ProjectIcon` to make all three transforms visible without introducing Control pivots; later modules can reuse the complete basic transform vocabulary. |
| Demonstrate source propagation and per-instance overrides with `ProjectIcon` in Lesson 1.5 | Rotation makes the distinction visible while keeping the source scene and instance responsibilities small; Modules 2-17 retain their order. |
| Introduce GDScript fundamentals before Player movement | Beginners should understand the small code vocabulary used in their first script before combining it with Godot input and physics. Lesson 2.4 introduces the foundations. |
| Add first-script bridges before Player movement | Lesson 2.5 introduces script attachment, `extends`, functions, callbacks, Output, local and script-level scope, and custom function calls through a temporary message diagnostic. Lesson 2.6 introduces typed parameters, arguments, and returned values. Lesson 2.7 then teaches property access and method calls on existing values. Lesson 2.8 introduces built-in Godot access through `Input` when movement first needs it. Each bridge removes its temporary code; horizontal movement moves to 2.8, gravity to 2.9, conditional logic to 2.10, and jumping to 2.11. |
| Introduce conditional logic after gravity | Lesson 2.9 makes gravity and the floor state visible first. Lesson 2.10 then uses temporary Output messages to show `if`, `else`, `not`, and `is_on_floor()` in that working context before applying gravity only while airborne. Lesson 2.11 can reuse the established floor state for jumping without redefining it. |
| Define physics bodies once, then use type-specific reminders | Lesson 2.2 is the first and only general definition of a physics body. Modules 3-17 must not repeat it; when they introduce another physics-body type, they should state only how that type differs from `CharacterBody2D` or `StaticBody2D`. |
| Match temporary Player collision to its visible marker without changing Actor's shared default | Lesson 2.8 replaces Player's inherited Shape with a local 128-by-128 rectangle matching its temporary marker. Actor keeps its reusable 32-by-32 placeholder, and later actor specializations choose collision shapes that fit their own visuals. |
| Connect the existing Godot folder to Codex during the first Git checkpoint | Module 0 now gives each lesson one explicit responsibility: install the tools in 0.1, create the only Godot project in 0.2, configure Git without creating a repository in 0.3, then associate the existing folder with Codex and checkpoint it in 0.4. The learner initializes Git manually in Codex's terminal, uses a read-only prompt to review the proposed checkpoint, inspects the diff, and commits through Codex's Git controls. Later checkpoints should use prompts only when review, explanation, or error detection adds value. |
| Keep the first Codex/Git checkpoint focused | Lesson 0.4 teaches only the decisions a beginner must make: select the existing project folder, initialize Git, inspect the starting status, request a read-only review, inspect the staged diff, commit, and verify. It defers folder-listing commands, repeated status checks, and detailed line-ending metadata to avoid turning setup into a terminal tour. |
| Validate Lesson 0.4 without a separate empty-project replay | The current Codex project, Git metadata, branch state, and Changes-to-Review UI evidence are accepted as sufficient for Lesson 0.4. Its complete clean-project replay remains required by the final full-course rebuild gate. |
| Add one reviewed Git checkpoint at the end of each completed module | Module 0 teaches the manual checkpoint cycle first. Modules 1 and 2 use Codex for a read-only review that can detect mismatches, then use the Git UI for staging and the local commit. Every roadmap module now reserves a final checkpoint lesson using the tested-review-inspect-commit-verify order, with prompting only when it adds useful safety or understanding. |
| Set the game window in Module 1 and size the world at 1920 by 1080 | Lesson 1.1 ran the project in Godot's default 1152-by-648 window, which is uncomfortably small on a high-resolution monitor and was never a deliberate choice. New Lesson 1.2 sets the viewport, stretch mode, and aspect right after the learner first feels the problem, following the same reasoning that placed viewport navigation in 1.1. Later Module 1 lessons shift to 1.3-1.6. Because jump height is a fixed pixel distance rather than a proportion of the screen, a larger viewport makes the same jump look smaller, so `jump_velocity` moved from `-400.0` to `-700.0` and the Player again clears twice its own height. The Floor, the test platform, and the 200-pixel step between them were repositioned to match. The result felt floaty and slow, so a follow-up pass raised `gravity` to `2400.0` and `jump_velocity` to `-1100.0`, cutting airtime from 1.47 to 0.97 seconds at the same height, and scaled the three horizontal values by 1.5 to `450.0`, `1800.0`, and `2700.0`. The jump-velocity range widened to `-1500.0` so the new default is not pinned at the limit. |
| Create the first checkpoint with Git commands, not the Codex controls | Lesson 0.4 now has the learner stage with `git add .`, read `git status`, and commit with `git commit -m`. The Codex Review tab and the read-only AI review are unchanged, because inspecting a diff visually is genuinely easier for a beginner. Typing the commands once makes the later checkpoint lessons' offline fallback actionable, keeps the commands transferable to any editor, and limits how much of the course depends on third-party UI wording that cannot be version-frozen the way the Godot version is. Modules 1 onward still use the Codex controls as the convenient path, so the manual cycle is taught first and the tool is used afterward. |
| Track movement state in Module 5 rather than Module 3 | The state has no consumer until the animation lesson, so teaching it in Module 3 produced a lesson with no observable result and a payoff two modules away. This applies the same rule that removed the standalone target-based movement bridge. Module 3 now ends with five felt movement features and its checkpoint. Placing the lesson after Module 4 also lets its conditions account for one-way and moving platforms: a Player standing on a moving platform can carry horizontal velocity, which a naive `velocity.x != 0.0` check would report as running. |
| Teach target-based movement beside its first implementation | Lesson 2.8 identifies direct assignment as the reason basic movement starts, stops, and reverses instantly. Lesson 3.2 then introduces current and target velocity, horizontal rates, and `move_toward()` beside the acceleration code that needs them, while referring back to Lesson 2.9's established `rate * delta` pattern. This removes the separate theory bridge and keeps later Module 3 lessons focused. |
| Open Module 4 with tiles, and include terrain autotiling before any level is drawn | Autotiling is what makes painting a level faster than placing bodies by hand, so teaching the TileSet without it would leave the learner choosing corner tiles manually through the rest of Module 4 and returning to the TileSet later. Match Sides compares only the four sides, so 16 tiles cover every combination; Match Corners and Sides would need 47. |
| Split the TileSet lesson in two at the collision boundary | The first draft carried two outcomes in one lesson: tiles that are solid, and tiles that connect automatically. Lesson 4.1 now ends when the Player stands on tiles the learner painted, and Lesson 4.2 adds the terrain and draws the level. Both halves keep an observable result, so neither becomes the kind of payoff-deferred lesson that moved the movement-state lesson to Module 5. The terrain half also carries the repetition risk of sixteen tiles, so it earns its own Codex review and its own checklist. Former Lessons 4.2-4.7 shift to 4.3-4.8. |
| Supply the tile artwork with the course | The project contained no art but `icon.svg`, and Module 5.4 is the first lesson that teaches import settings. A course-supplied atlas keeps Lessons 4.1 and 4.2 on the tiles themselves, works with Godot import defaults, and leaves character-art importing to 5.4. The first draft used a generated 16-tile placeholder of 64-pixel tiles; it was replaced by `terrain.png`, a hand-drawn 47-tile blob atlas of 128-pixel tiles authored in `terrain-template.af`, and the placeholder and its generator were deleted. The atlas was verified in Godot 4.7.2: 12 by 4 cells with one transparent cell at `(10, 1)`, which is a hole in a drawn shape rather than a spare slot, giving 47 tiles for `Match Corners and Sides`. Its exposed-edge silhouette insets the artwork about 10 pixels from the tile boundary on open vertical edges, so tile collision is still the full square. |
| Replace both temporary bodies in Lesson 4.2 rather than across Module 4 | Leaving the grey `Floor` or `CoyoteTestPlatform` beside painted tiles would show two kinds of ground at once. The painted level reproduces both roles: a full-width ground with its surface at `y = 896` and a raised terrace at `y = 704`. The step becomes 192 pixels instead of 200, against a measured jump rise of 261 pixels, leaving 69 pixels of clearance, so coyote time, jump buffering, and variable jump height all stay testable. |
| Teach movement as built-in first, then extract it into components in Module 6 | Modules 2 and 3 build movement directly inside `player.gd`, and new Lesson 6.1 refactors it into an input component, a movement component, and an orchestrator. Extracting earlier would repeat the mistake this log already recorded twice: the standalone target-based movement bridge was removed and the movement-state lesson moved to Module 5, both because the lesson arrived before anything consumed it. No second actor exists until Module 6, which is also where the architecture already requires a component to be shown on two actor types. Refactoring is additive, so Lessons 2.8-3.5 keep their validated text and only their result changes. It also teaches the component contract on code the learner wrote and already understands. |
| Separate input from movement with an intent boundary | An input component turns devices into intent and a movement component consumes intent, so neither knows about the other. A movement component that read `Input` directly could never drive an NPC or an enemy, which is the whole reason for extracting it. Lesson 6.2 proves the boundary immediately by driving a second actor with the same movement component from a different intent source, and Lesson 6.4 adds a destructible box that takes health with no movement or input at all. |
| Keep Actor as a shallow scene base rather than removing inheritance | The composition material that prompted this change treats inheritance as a trap, but `Actor` carries shared scene structure and attachment points, not behavior. Behavior already lives in components after Lesson 6.1. Replacing the scene base with duplicated structure in every actor would cost reuse and gain nothing, so the shallow base stays. |
