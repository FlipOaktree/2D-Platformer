# 2D Platformer Course Roadmap

## Purpose and Authority

This file is the canonical source for the course scope, curriculum sequence,
architecture, progress, dependencies, and exact next lesson. It lets a new
Codex task recover the course direction from the repository instead of relying
on chat history.

| Source | Authority |
| --- | --- |
| `AGENTS.md` | Instructions for recovering context and working safely |
| `.docs/course_roadmap.md` | Curriculum, architecture, progress, and next step |
| `.docs/course_workflow.md` | Lesson planning, implementation, validation, and publication lifecycle |
| Lesson Markdown | Canonical learner instructions |
| Godot project | Evidence of implemented behavior |
| Notion | Published mirror of validated lessons |

If these sources disagree, report the discrepancy before making changes. Do
not infer progress from chat history or from learner verification checkboxes.

## Current Course State

- **Course goal:** Build and validate a beginner-friendly written course that
  produces a modular Godot 2D platformer template by following the same steps
  learners will use.
- **Validated curriculum:** Module 0, Lessons 0.1-0.4, and Module 1, Lessons
  1.1-1.3.
- **Godot evidence:** The validated Lesson 1.2 state is recorded at `1846a97`.
  The working tree validates Lesson 1.3 with one `StatusMessage` instance of
  `status_message.tscn` in `Main`, positioned at `(96, 72)` and displaying
  `Project ready` without related errors or warnings.
- **Code state:** No GDScript or reusable gameplay systems exist yet.
- **Observed Git head:** `1846a97` (`Position first scene content and validate
  Module 1.2`); some earlier lesson-to-commit associations still
  require reconciliation.
- **Exact next lesson:** **2.1 Configure Keyboard and Controller Actions** -
  Blueprint drafted, pending review and approval.
- **Working-tree caution:** The validated Lesson 1.2 revision, validated Lesson
  1.3 material and artifacts, the Lesson 2.1 blueprint, and roadmap status are
  uncommitted. Preserve them and all unrelated user work.

## Status Model

Lesson lifecycle and publication are independent:

- **Lifecycle:** Planned -> Blueprint drafted -> Blueprint approved ->
  Implemented -> Validated.
- **Notion:** Not published, Current, or Out of sync.
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

**Outcome:** Install the learner toolchain, create the empty project, and place
it under version control.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 0.1 | Install Godot and Codex | Godot editor and optional Codex workflow | Validated | Current | Existing history; exact commit pending reconciliation |
| 0.2 | Create an Empty Godot Project | Project Manager, renderer, project folder | Validated | Current | Existing history; exact commit pending reconciliation |
| 0.3 | Install and Configure Git | Git installation and commit identity | Validated | Current | Existing history; exact commit pending reconciliation |
| 0.4 | Create the First Git Checkpoint | Repository, staging, commit, Godot metadata | Validated | Current | Existing history; exact commit pending reconciliation |

### Module 1: Godot Scene Foundations

**Depends on:** Module 0. **Outcome:** Understand nodes, scenes, positioning,
and scene composition before gameplay code is introduced.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 1.1 | Create and Run Your First Scene | `Node2D`, `Label`, root/child hierarchy, `main.tscn`, main scene | Validated | Current | `e918e66` |
| 1.2 | Position Nodes in 2D | 2D coordinates, position, viewport navigation, parent-relative movement | Validated | Current | `1846a97` + uncommitted validated revision |
| 1.3 | Compose Scenes from Reusable Parts | Instantiation and reusable child scenes | Validated | Current | Uncommitted validated material |

### Module 2: Actor and Player Foundations

**Depends on:** Module 1. **Outcome:** Establish the shared actor boundary and
a basic keyboard/controller player without premature feature inheritance.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 2.1 | Configure Keyboard and Controller Actions | Input Map and action abstraction | Blueprint drafted - exact next lesson | Not published | Uncommitted working tree |
| 2.2 | Build the Shared Actor Scene | Small `Actor` base and attachment points | Planned | Not published | Unassigned |
| 2.3 | Specialize Actor into a Player | Scene inheritance/specialization | Planned | Not published | Unassigned |
| 2.4 | Write Typed Horizontal Movement | Typed GDScript, input axis, velocity | Planned | Not published | Unassigned |
| 2.5 | Add Gravity and Floor Collision | Physics process, collision, grounded state | Planned | Not published | Unassigned |
| 2.6 | Add Jumping | Jump action and vertical velocity | Planned | Not published | Unassigned |

### Module 3: Responsive Player Movement

**Depends on:** Module 2. **Outcome:** Turn basic movement into a configurable,
responsive controller while making player states explicit.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 3.1 | Expose Safe Movement Settings | Exported properties, defaults, tooltips | Planned | Not published | Unassigned |
| 3.2 | Add Acceleration and Deceleration | Smoothing movement values | Planned | Not published | Unassigned |
| 3.3 | Add Coyote Time | Short grace timers | Planned | Not published | Unassigned |
| 3.4 | Add Jump Buffering | Buffered input | Planned | Not published | Unassigned |
| 3.5 | Add Variable Jump Height | Held/released input behavior | Planned | Not published | Unassigned |
| 3.6 | Track Player Movement States | Explicit movement state | Planned | Not published | Unassigned |

### Module 4: Modular Level Building

**Depends on:** Module 3. **Outcome:** Create reusable levels and platform
elements around clear spawn and boundary contracts.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 4.1 | Build a TileSet with Collision | TileSet and terrain collision | Planned | Not published | Unassigned |
| 4.2 | Build a Reusable Level Scene | Level scene boundary | Planned | Not published | Unassigned |
| 4.3 | Add Player Spawn Points | Spawn marker contract | Planned | Not published | Unassigned |
| 4.4 | Add One-Way Platforms | One-way collision | Planned | Not published | Unassigned |
| 4.5 | Add Moving Platforms | Reusable moving surface | Planned | Not published | Unassigned |
| 4.6 | Add Level Bounds and Fall Detection | World bounds and fall signal | Planned | Not published | Unassigned |

### Module 5: Camera and Character Presentation

**Depends on:** Module 4. **Outcome:** Present movement clearly with a reusable
camera and animated character visuals.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 5.1 | Add a Following Camera | `Camera2D` ownership | Planned | Not published | Unassigned |
| 5.2 | Configure Camera Limits and Smoothing | Limits and smoothing | Planned | Not published | Unassigned |
| 5.3 | Add Look-Ahead Behavior | Camera behavior component | Planned | Not published | Unassigned |
| 5.4 | Import Character Art | Import settings and sprite presentation | Planned | Not published | Unassigned |
| 5.5 | Animate and Face the Player | Animation and facing direction | Planned | Not published | Unassigned |

### Module 6: Shared Actor Capabilities

**Depends on:** Modules 2-5. **Outcome:** Add the common removable components
that later player, NPC, and enemy features reuse.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 6.1 | Create a Reusable Health Component | Health API and change signals | Planned | Not published | Unassigned |
| 6.2 | Create Hitbox and Hurtbox Components | Damage contract and collision layers | Planned | Not published | Unassigned |
| 6.3 | Add Actor Factions | Faction data and targeting rules | Planned | Not published | Unassigned |
| 6.4 | Add an Interaction Component | Generic interaction contract | Planned | Not published | Unassigned |
| 6.5 | Add Persistent Actor Identity | Stable persistent IDs | Planned | Not published | Unassigned |
| 6.6 | Customize and Remove Actor Components | Optional-component verification | Planned | Not published | Unassigned |

### Module 7: Hazards, Defeat, and Respawning

**Depends on:** Modules 4 and 6. **Outcome:** Connect reusable damage and actor
identity to recovery and level reset behavior.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 7.1 | Build a Reusable Hazard | Hazard using damage contract | Planned | Not published | Unassigned |
| 7.2 | Handle Actor Defeat | Defeat signal and policy | Planned | Not published | Unassigned |
| 7.3 | Respawn the Player | Respawn flow | Planned | Not published | Unassigned |
| 7.4 | Add Checkpoints | Checkpoint state | Planned | Not published | Unassigned |
| 7.5 | Reset Level Actors Safely | Reset contract across actors | Planned | Not published | Unassigned |

### Module 8: Player Combat

**Depends on:** Module 6. **Outcome:** Add removable melee and ranged combat
through the shared damage and faction contracts.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 8.1 | Add Attack Input and Timing | Attack action, cooldown, timing | Planned | Not published | Unassigned |
| 8.2 | Build a Melee Attack | Reusable melee hitbox | Planned | Not published | Unassigned |
| 8.3 | Build a Reusable Projectile | Projectile scene and ownership | Planned | Not published | Unassigned |
| 8.4 | Add Knockback | Damage response data | Planned | Not published | Unassigned |
| 8.5 | Add Temporary Invulnerability | Invulnerability window | Planned | Not published | Unassigned |
| 8.6 | Customize or Remove Combat | Combat add/remove regression | Planned | Not published | Unassigned |

### Module 9: Modular Enemies

**Depends on:** Modules 6 and 8. **Outcome:** Reuse actor capabilities across
distinct ground and flying enemy behaviors.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 9.1 | Specialize Actor into an Enemy | Enemy specialization | Planned | Not published | Unassigned |
| 9.2 | Create a Patrolling Enemy | Patrol behavior | Planned | Not published | Unassigned |
| 9.3 | Add Ledge and Wall Detection | Environment sensors | Planned | Not published | Unassigned |
| 9.4 | Create a Chasing Enemy | Targeting and chase behavior | Planned | Not published | Unassigned |
| 9.5 | Create a Flying Enemy | Alternate movement capability | Planned | Not published | Unassigned |
| 9.6 | Handle Enemy Defeat, Drops, and Reset | Enemy lifecycle and drops | Planned | Not published | Unassigned |

### Module 10: Items, Inventory, and Equipment

**Depends on:** Modules 6 and 9. **Outcome:** Build a data-driven inventory core
with optional equipment and reusable world items.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 10.1 | Define Reusable Items with Resources | Item Resource and stable item ID | Planned | Not published | Unassigned |
| 10.2 | Build the Inventory Data Model | Stacks, capacity, add/remove/count | Planned | Not published | Unassigned |
| 10.3 | Add an Inventory Component to an Actor | Inventory attachment and signals | Planned | Not published | Unassigned |
| 10.4 | Create Item Pickups and Drops | World/inventory transfer contract | Planned | Not published | Unassigned |
| 10.5 | Build the Inventory Interface | Inventory view decoupled from data | Planned | Not published | Unassigned |
| 10.6 | Add Consumable Items | Item-use contract | Planned | Not published | Unassigned |
| 10.7 | Add an Equipment Component | Optional equipment capability | Planned | Not published | Unassigned |
| 10.8 | Extend Inventory Without Changing Its Core | Extension and regression exercise | Planned | Not published | Unassigned |

### Module 11: NPCs and Dialogue

**Depends on:** Modules 6 and 10. **Outcome:** Add NPC specialization and
Resource-driven branching dialogue through the shared interaction contract.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 11.1 | Specialize Actor into an NPC | NPC specialization | Planned | Not published | Unassigned |
| 11.2 | Start Interaction-Based Conversations | Conversation trigger contract | Planned | Not published | Unassigned |
| 11.3 | Define Dialogue with Resources | Dialogue entries and stable IDs | Planned | Not published | Unassigned |
| 11.4 | Present Dialogue in the Interface | Dialogue view/controller separation | Planned | Not published | Unassigned |
| 11.5 | Add Branching Choices | Choice paths | Planned | Not published | Unassigned |
| 11.6 | Add Conditions and Actions | Data-driven conditions/actions | Planned | Not published | Unassigned |
| 11.7 | Reuse Dialogue Across NPCs | Dialogue reuse verification | Planned | Not published | Unassigned |

### Module 12: Quests and Objectives

**Depends on:** Modules 9-11. **Outcome:** Track data-driven quests with
composable objectives connected to dialogue, combat, items, and locations.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 12.1 | Define Quests with Resources | Quest definitions, IDs, prerequisites | Planned | Not published | Unassigned |
| 12.2 | Build the Quest Log | Runtime quest state | Planned | Not published | Unassigned |
| 12.3 | Create the Objective Contract | Composable objective interface | Planned | Not published | Unassigned |
| 12.4 | Add Collect and Defeat Objectives | Inventory/combat event objectives | Planned | Not published | Unassigned |
| 12.5 | Add Interaction and Location Objectives | Interaction/location event objectives | Planned | Not published | Unassigned |
| 12.6 | Connect Quests to Dialogue | Quest-aware conditions and actions | Planned | Not published | Unassigned |
| 12.7 | Deliver Quest Rewards | Reward contract | Planned | Not published | Unassigned |
| 12.8 | Build the Quest Journal | Quest view decoupled from state | Planned | Not published | Unassigned |

### Module 13: World Progression and Game Flow

**Depends on:** Modules 4, 7, and 12. **Outcome:** Move between levels while
preserving the world and actor state that should survive transitions.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 13.1 | Add Collectibles Outside Inventory | Dedicated progression collectibles | Planned | Not published | Unassigned |
| 13.2 | Add Level Goals | Goal completion contract | Planned | Not published | Unassigned |
| 13.3 | Transition Between Levels | Scene transitions | Planned | Not published | Unassigned |
| 13.4 | Centralize Scene Flow | Minimal cross-scene service | Planned | Not published | Unassigned |
| 13.5 | Build Title, Restart, and Game-Over Flows | Game flow states | Planned | Not published | Unassigned |
| 13.6 | Restore Persistent Actors Across Levels | Cross-level actor restoration | Planned | Not published | Unassigned |

### Module 14: HUD, Menus, and Settings

**Depends on:** Modules 10, 12, and 13. **Outcome:** Present gameplay state and
settings without coupling UI to concrete actor implementations.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 14.1 | Build the Gameplay HUD | HUD scene boundary | Planned | Not published | Unassigned |
| 14.2 | Display Health, Inventory, and Objectives | Signal-driven state displays | Planned | Not published | Unassigned |
| 14.3 | Add a Pause Menu | Pause behavior | Planned | Not published | Unassigned |
| 14.4 | Add Audio Settings | Audio preferences | Planned | Not published | Unassigned |
| 14.5 | Add Display and Accessibility Settings | Display/accessibility preferences | Planned | Not published | Unassigned |
| 14.6 | Keep UI Independent from Actor Implementations | UI dependency audit | Planned | Not published | Unassigned |

### Module 15: Saving and Persistence

**Depends on:** Modules 6, 10, 12-14. **Outcome:** Save and restore modular
framework state safely across versions and failure cases.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 15.1 | Define Stable Saveable Identities | Saveable identity contract | Planned | Not published | Unassigned |
| 15.2 | Define the Versioned Save Schema | Versioned save data | Planned | Not published | Unassigned |
| 15.3 | Capture and Restore Modular Component State | Component persistence contract | Planned | Not published | Unassigned |
| 15.4 | Create Manual Save Slots | Multiple slots and metadata | Planned | Not published | Unassigned |
| 15.5 | Add Autosave | Autosave policy | Planned | Not published | Unassigned |
| 15.6 | Persist Inventory, Quests, Dialogue, and World State | Integrated persistent state | Planned | Not published | Unassigned |
| 15.7 | Persist Settings Separately | Settings storage boundary | Planned | Not published | Unassigned |
| 15.8 | Migrate Older Save Versions | Migration functions | Planned | Not published | Unassigned |
| 15.9 | Validate, Back Up, Reset, and Recover Save Data | Atomic replace and recovery | Planned | Not published | Unassigned |

### Module 16: Audio and Gameplay Feedback

**Depends on:** Modules 5, 8, 13, and 14. **Outcome:** Add reusable feedback
that respects player preferences and accessibility settings.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 16.1 | Configure Audio Buses | Audio routing | Planned | Not published | Unassigned |
| 16.2 | Add Reusable Actor and World Sounds | Signal-driven sound components | Planned | Not published | Unassigned |
| 16.3 | Add Music Transitions | Music state transitions | Planned | Not published | Unassigned |
| 16.4 | Add Particles and Hit Flash | Reusable visual feedback | Planned | Not published | Unassigned |
| 16.5 | Add Camera Shake | Decoupled camera feedback | Planned | Not published | Unassigned |
| 16.6 | Respect Feedback Accessibility Settings | Reduced/disabled feedback paths | Planned | Not published | Unassigned |

### Module 17: Validation, Packaging, and Extension

**Depends on:** Modules 0-16. **Outcome:** Prove that shared and optional
systems remain reusable, then package and document the framework.

| ID | Lesson | First concepts or artifacts | Lifecycle | Notion | Git |
| --- | --- | --- | --- | --- | --- |
| 17.1 | Add Focused Automated Test Scenes | Deterministic test scenes | Planned | Not published | Unassigned |
| 17.2 | Test Shared Components Across Actor Types | Cross-actor component tests | Planned | Not published | Unassigned |
| 17.3 | Test Inventory, Quest, Dialogue, and Save Integration | System integration tests | Planned | Not published | Unassigned |
| 17.4 | Audit Add, Remove, and Customize Workflows | Optional-feature acceptance matrix | Planned | Not published | Unassigned |
| 17.5 | Assemble Demonstration Levels | Representative framework demos | Planned | Not published | Unassigned |
| 17.6 | Export the Framework Project | Export configuration | Planned | Not published | Unassigned |
| 17.7 | Document Extension and Licensing Rules | Extension guide and licenses | Planned | Not published | Unassigned |

## Concept Sequencing Ledger

Use this ledger before drafting so concepts are introduced near their first
practical use and later lessons can build on them without re-teaching them.

| Concept family | First introduction | Principal reuse |
| --- | --- | --- |
| Nodes, scenes, hierarchy, running | 1.1 | Every later lesson |
| 2D coordinates and transforms | 1.2 | Levels, actors, cameras, UI |
| Scene composition and instantiation | 1.3 | Actors, components, levels, items |
| Input actions and device abstraction | 2.1 | Movement, combat, interaction, UI |
| Actor boundary and specialization | 2.2-2.3 | Player, NPCs, enemies |
| Typed GDScript and physics | 2.4-2.5 | All scripted gameplay |
| Exported configuration | 3.1 | Reusable systems and content |
| Signals and removable components | 6.1-6.6 | Combat, inventory, quests, UI, saving |
| Stable IDs and Resources | 6.5, 10.1 | Dialogue, quests, persistence |
| Minimal global services | 13.4 | Scene flow, saving, settings, quest state |
| Versioned persistence | 15.1-15.9 | All persistent systems |

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
locally and in Notion where a corresponding page needed updating:

- Lesson 1.1's local status now reflects its validated, published state.
- Lesson 1.1 no longer treats the single-word node name `Main` as an example
  of PascalCase; naming conventions will be introduced later with useful
  multiword examples.
- Lesson 0.4's missing step number is corrected.
- Lesson 0.3's recovery notes now sit beside the lesson parts they address.

Remaining reconciliation work:

- Propagate the roadmap's descriptive Module titles to local lesson and
  navigation material where needed.
- Reconcile Module titles in Notion only after explicit permission.
- Reconcile exact Git associations for validated lessons without rewriting
  unrelated working-tree changes.

## Decision Log

| Decision | Reason and downstream effect |
| --- | --- |
| Keep local files canonical and Notion as a validated mirror | New tasks can recover state without depending on a signed-in external service. |
| Organize Notion lessons under their parent Module page and omit lesson icons | Matches the established publication structure. |
| Use a small `Actor` base plus removable components | Player, NPC, and enemy share only genuine common behavior. |
| Include combat, inventory, dialogue, quests, and robust saving in the core roadmap | The final template must support a coherent modular game framework, not only movement. |
| Defer visual production until the written curriculum is complete | Visuals should reflect validated steps and avoid repeated rework. |
| Keep learner verification boxes unchecked | They belong to each learner; production completion is tracked here. |
| Keep curriculum modules cohesive and portability-aware without introducing configurable course assembly yet | The first complete course will reveal which modules are genuinely reusable; shared libraries, course manifests, and alternate entry checkpoints remain deferred until then. |
