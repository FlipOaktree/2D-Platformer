# Course Development Workflow

## Goal

Create the written training material and the Godot template together. The
written material is the build plan; the working template proves that the plan
is accurate. Videos and learner downloads are a later production phase.

The course assumes no Godot or programming experience. Learners should have
basic computer and file-management skills.

## Roadmap and Continuity

`2D Platformer Course/course_roadmap.md` is the canonical source for the course
scope, curriculum sequence, architectural direction, progress, and next lesson.
Individual lesson files remain authoritative for learner-facing instructions,
and the Godot project is the evidence for what has actually been implemented.

Before planning or changing a lesson:

1. Read the roadmap and the affected completed and upcoming lessons.
2. Inspect the relevant Godot artifacts and `git status`.
3. Compare the observed state with the roadmap.
4. Report discrepancies before proceeding.
5. Review which prerequisites and concepts have already been taught so the
   lesson neither assumes unexplained knowledge nor repeats a full introduction.

Track each lesson with this lifecycle:

- **Planned** - the lesson exists only in the approved provisional roadmap.
- **Blueprint drafted** - learner instructions exist but are not yet approved.
- **Blueprint approved** - the written build plan is approved for implementation.
- **Implemented** - the lesson result exists in the Godot project but has not
  passed the complete lesson verification.
- **Validated** - the written procedure and resulting project behavior have
  passed the lesson verification.

Learner verification checkboxes stay unchecked so learners can use them;
production validation belongs in the lesson status and roadmap.

Update the roadmap after an approved change to scope, sequence, dependencies,
architecture, lifecycle, validation, or Git association.
When implementation changes an earlier assumption, identify every downstream
lesson, test, visual, and task affected before updating the roadmap. Curriculum
changes remain welcome, but record the decision and its reason so future tasks
continue from the same plan.

## Integrated AI Workflow

AI is a prominent optional accelerator inside the course, not a separate
course path. Keep one lesson sequence and one learner outcome.

- Explain the relevant concept before asking AI to work with it.
- Demonstrate a representative action manually when the learner needs to
  understand the underlying pattern.
- Use Codex where it provides clear leverage, such as completing a demonstrated
  repetition, reviewing code, finding an error, writing a test, documenting a
  decision, or iterating on an asset.
- Show the learner how to inspect, explain, correct, and test AI output before
  accepting it.
- Ask Codex only about files the learner's project actually contains. Their
  project folder holds the Godot project and not the course, so Codex has
  never read a lesson. A prompt asking it to confirm that code matches the
  course invites an answer it has no basis for, and an agent asked to confirm
  usually confirms. Have it describe, and leave the comparing to the learner.
- Remember that the authoring repository is not the learner's project. The
  course files sit beside `project.godot` here and never do there, so a prompt
  that reads lessons will appear to work when validated locally and fail
  silently for everyone else.
- Keep AI-assisted actions small enough that the learner understands what
  changed and where the behavior lives.
- When AI is unavailable, give a brief continuation instruction based on the
  demonstrated method. Do not duplicate the lesson or maintain parallel
  AI and non-AI modules.
- Do not force AI into a lesson when it adds no meaningful learning or
  efficiency.
- Assume the learner may be reading the course as a page or a video rather
  than as files. Anything they need while working through a lesson belongs in
  that lesson; a reference to another lesson is a pointer, not a dependency.
  This matters most in fallback paths, which are used precisely when the
  convenient route is gone.

## Step Boundary

Every project step must be small enough to explain, implement, and verify
without bundling unrelated concepts.

Before proceeding, present:

1. The learning or project outcome.
2. Why this is the next step.
3. The files, Godot scenes, or tools it may affect.
4. The expected visible result.
5. The verification method.

Wait for approval, complete only that step, and stop after reporting the
results and previewing the next proposed step.

## Lesson Lifecycle

### 1. Blueprint

Draft these planning considerations:

- One learner outcome.
- Prerequisites.
- The finished visible result.
- New concepts and why they are needed.
- Exact editor and code actions.
- Inspector customization points.
- Visual needs to revisit during the later visual-support pass.
- Common mistakes to watch for.
- A learner exercise.
- A verification checklist.
- The role of AI in the lesson, if it provides a clear advantage.
- Any relevant Godot or Codex best practice, tip, or shortcut that makes the
  current work clearer, safer, or faster.

The blueprint can change during validation.

Before drafting, confirm the lesson's roadmap outcome, prerequisites, expected
artifacts, and concepts introduced for the first time. Check whether an earlier
lesson already explains, tests, or audits what this one is about to; point to
it rather than repeating it. If the proposed lesson changes the curriculum or
architecture, update the roadmap only after that change is approved.

These are planning considerations, not required learner-facing sections. Place
concepts, reasons, AI guidance, practical tips, and recovery help inside the
build steps where learners need them.

Use this learner-facing lesson structure:

1. **By the end** - combine the outcome, visible result, and one sentence of
   context.
2. **Before you start** - include only real prerequisites.
3. **Build steps** - teach concepts and reasoning beside the relevant actions.
4. **Learner exercise** - a small change to what was just built: predict what
   it will do, try it, and explain the result. Experiment on a copy or a second
   instance where possible, so nothing is left to put back. When an exercise
   must change the project itself, end it with the exact value to restore.
5. **Verification checklist** - the end state the lesson produces and the
   understanding it builds, not a restatement of each build step.
6. **References**.

Format contextual lesson notes consistently:

- Put a new-concept explanation in a blue callout with a light-bulb icon. Use
  plain paragraphs without a title or bullets, and place the callout at the
  clearest point beside the concept's first practical use.
- Put recovery guidance in a gray callout with a warning icon and the heading
  **If something differs** without a colon. Keep it unindented and place it at
  the end of the corresponding lesson part.

Keep explanation proportionate to what the learner needs at that moment:

- Give a callout only to something the learner will use: a concept met for
  the first time, a reason they will act on, or a mistake they are about to
  make. Why the course chose one design over another, and the measurements
  that proved it, belong in the roadmap's Decision Log, not in the lesson.
  Keep a reason in the lesson only when it teaches something the learner will
  reuse, such as "a pit has to be wider than what falls into it".
- Show one way to do each thing. An alternative the learner will not use is a
  detour; mention one only when they will meet it later and need to recognise
  it.
- Before the first run of new code or a new node setup, ask the learner to
  predict what will happen, then run it and compare. One line in the build
  steps, not a separate exercise.
- Treat these as signals to re-read a lesson, not as limits: more than about
  six callouts, callout text longer than the build steps it sits among, a
  callout that has to begin "Step 8 is...", or a checklist that repeats the
  build steps item by item. Modules 0 to 3 average about three callouts, with
  roughly one word of explanation for every two words of instruction.

Write each verification checklist item in the voice that matches what it
verifies:

- State a fact about the project directly, without naming the learner, such as
  "`player.gd` ends with only `extends CharacterBody2D`".
- Use "The learner can ..." or "The learner knows ..." for understanding the
  learner should be able to demonstrate.
- Use "The learner ..." with a past-tense verb for an action the lesson had the
  learner perform, such as "The learner used `return` to send the calculated
  value back to `_ready()`".

Do not write checklist items in the first person. The boxes stay unchecked for
learners to use, but the wording is production-facing and stays consistent
across every lesson.

### 2. Build

- Follow the blueprint in order.
- Explain only the part of Godot, Codex, Git, or Affinity needed for the
  current task.
- Introduce a practical best practice, tip, or shortcut when it directly helps
  the current task. Keep it brief and in context rather than turning it into a
  separate tool tutorial.
- Introduce each concept beside its first practical use, immediately before or
  after the action when that produces the clearest learner flow. Use only the
  detail needed for the current outcome. A callout that has to begin "Step 8
  is..." has drifted from its step; move it to follow step 8.
- Define a concept fully only at its first relevant use. Before drafting or
  revising a lesson, check the concept sequencing ledger and earlier lessons.
  Later lessons may briefly connect the concept to its new use, but must not
  repeat its general definition, analogy, or rationale. This matters more as
  the course goes on, because guidance that helps a beginner becomes extra load
  once they know the idea. Hand over repeated patterns the same way: once a
  technique has been shown in full, a later lesson can state the goal and let
  the learner attempt it before showing the answer.
- Use a single integrated lesson flow when Codex is involved; do not create
  repeated AI and non-AI versions of the same instructions.
- Run the project regularly. End each lesson part with something the learner
  can see or run, so every stretch of steps produces a result they can check.
- Record any undocumented step, unclear explanation, or mismatch between the
  blueprint and actual behavior.
- Perform a roadmap impact check when the implementation changes an earlier
  assumption, dependency, shared interface, or planned lesson boundary.
- Keep AI-generated code and assets provisional until reviewed.
- Distinguish learner tools from internal production tools. A tool used only
  to produce the course is not part of the learner workflow unless the learner
  genuinely needs it.

### 3. Verify

A lesson is verified when:

- Following its steps produces the stated result.
- Replaying the lesson's edit steps from the previous lesson's end state
  reproduces the lesson's own final code listing exactly, with no leftover or
  duplicated lines. Verifying the project's behavior is not a substitute: a
  step that adds a line without removing the one it replaces can leave the
  project working and the written procedure wrong.
- The project has no related parser or runtime errors.
- Existing completed features still work.
- Inspector values are understandable and safe.
- Relevant keyboard and controller checks pass.
- Optional features can be removed without breaking unrelated features.
- Automated tests cover suitable deterministic logic.
- The lesson explains what, how, and why.
- Any AI-assisted result has been inspected, explained, corrected if needed,
  and tested.
- The lesson remains understandable without maintaining a second non-AI
  version of its content.
- The verification checklist tests the shape of the result as well as its
  behavior, so an incorrect script cannot pass every item. When a lesson moves
  or replaces an existing line, include an item of the form "X appears exactly
  once".

### 4. Finalize

- Correct the lesson using the verified implementation.
- Keep the first pass focused on validated written instruction. Identify and
  add required screenshots, diagrams, or short demonstrations during a later
  visual-support pass.
- Associate the lesson with its Git commit and project version.

## Change Management

Expect frequent improvement.

- Prefer the clearest current design over preserving an early assumption.
- When code changes, identify every affected lesson, test, screenshot, and task.
- Revalidate technically affected lessons.
- Pedagogical wording can change without rebuilding the project when behavior
  and instructions remain the same.
- Record important decisions and their reasons so they are not repeatedly
  reconsidered without new evidence.
- Add reusable documentation only after a rule or pattern has demonstrated
  repeated value.

## Modularity Review

For each gameplay feature, confirm:

- It has one focused responsibility.
- Its common behavior is editable in the Inspector.
- It owns or clearly declares its dependencies.
- It does not rely on fragile paths into unrelated scenes.
- It communicates through a small, documented surface.
- It has safe defaults.
- It can be demonstrated and tested independently.
- Its add, remove, and customize steps can be explained briefly.

## Full-Course Validation Gate

Before video or download production:

1. Finish and verify every written lesson.
2. Start again from an empty Godot project.
3. Rebuild the template using only the written course.
4. Record and correct every missing, ambiguous, or outdated instruction.
5. Repeat affected tests and the final modularity exercises.
6. Confirm that every concept is explained beside its first practical use.
7. Audit learner tools and clearly identify any optional paid service.
8. Verify that the final license allows games made with the framework to be
   sold while prohibiting resale of the framework itself.
9. Freeze matching course and template versions.
10. Adapt the verified lessons into recording outlines and production tasks.
