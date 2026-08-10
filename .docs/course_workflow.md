# Course Development Workflow

## Goal

Create the written training material and the Godot template together. The
written material is the build plan; the working template proves that the plan
is accurate. Videos and learner downloads are a later production phase.

The course assumes no Godot or programming experience. Learners should have
basic computer and file-management skills.

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
- Keep AI-assisted actions small enough that the learner understands what
  changed and where the behavior lives.
- When AI is unavailable, give a brief continuation instruction based on the
  demonstrated method. Do not duplicate the lesson or maintain parallel
  AI and non-AI modules.
- Do not force AI into a lesson when it adds no meaningful learning or
  efficiency.

## Step Boundary

Every project step must be small enough to explain, implement, and verify
without bundling unrelated concepts.

Before proceeding, present:

1. The learning or project outcome.
2. Why this is the next step.
3. The files, Godot scenes, tools, or Notion records it may affect.
4. The expected visible result.
5. The verification method.

Wait for approval, complete only that step, and stop after reporting the
results and previewing the next proposed step.

## Lesson Lifecycle

### 1. Blueprint

Draft:

- One learner outcome.
- Prerequisites.
- The finished visible result.
- New concepts and why they are needed.
- Exact editor and code actions.
- Inspector customization points.
- Suggested visual support.
- Common mistakes to watch for.
- A learner exercise.
- Acceptance checks.
- The role of AI in the lesson, if it provides a clear advantage.

The blueprint can change during validation.

### 2. Build

- Follow the blueprint in order.
- Explain only the part of Godot, Codex, Notion, Git, or Affinity needed for
  the current task.
- Introduce each concept before its first practical use, using only the detail
  needed for the current outcome.
- Use a single integrated lesson flow when Codex is involved; do not create
  repeated AI and non-AI versions of the same instructions.
- Run the project regularly.
- Record any undocumented step, unclear explanation, or mismatch between the
  blueprint and actual behavior.
- Keep AI-generated code and assets provisional until reviewed.
- Distinguish learner tools from internal production tools. A tool used to
  produce the course, such as ShareX, is not part of the learner workflow unless
  the learner genuinely needs it.

### 3. Verify

A lesson is verified when:

- Following its steps produces the stated result.
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

### 4. Finalize

- Correct the lesson using the verified implementation.
- Identify required screenshots, diagrams, or short demonstrations.
- Associate the lesson with its Git commit and project version.
- Present the proposed Notion entry.
- Ask for permission before writing the lesson or updating its tasks in
  Notion.

## Notion Task Workflow

Use a simple task flow:

`Backlog -> Next -> In Progress -> Blocked or Done`

- Create tasks from an approved module or lesson blueprint.
- Keep tasks outcome-based and link them to the relevant lesson.
- Include acceptance criteria rather than vague activity descriptions.
- Separate curriculum, code, test, visual, and documentation work only when
  doing so makes progress clearer.
- Do not create recording or learner-download tasks until the entire written
  course passes its end-to-end validation.
- Ask permission before creating a task group or updating completed lesson
  records in Notion.

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
6. Confirm that every concept is explained before its first use.
7. Audit learner tools and clearly identify any optional paid service.
8. Verify that the final license allows games made with the framework to be
   sold while prohibiting resale of the framework itself.
9. Freeze matching course and template versions.
10. Adapt the verified lessons into recording outlines and production tasks.
