# Course Development Workflow

## Goal

Create the written training material and the Godot template together. The
written material is the build plan; the working template proves that the plan
is accurate. Videos and learner downloads are a later production phase.

The course assumes no Godot or programming experience. Learners should have
basic computer and file-management skills.

## Roadmap and Continuity

`.docs/course_roadmap.md` is the canonical source for the course scope,
curriculum sequence, architectural direction, progress, and next lesson.
Individual lesson files remain authoritative for learner-facing instructions,
and the Godot project is the evidence for what has actually been implemented.
Notion mirrors validated material only.

Before planning or changing a lesson:

1. Read the roadmap and the affected completed and upcoming lessons.
2. Inspect the relevant Godot artifacts and `git status`.
3. Compare the observed state with the roadmap.
4. Report discrepancies before proceeding.
5. Review which prerequisites and concepts have already been taught so the
   lesson neither assumes unexplained knowledge nor repeats a full introduction.

Track the lesson lifecycle separately from publication:

- **Planned** - the lesson exists only in the approved provisional roadmap.
- **Blueprint drafted** - learner instructions exist but are not yet approved.
- **Blueprint approved** - the written build plan is approved for implementation.
- **Implemented** - the lesson result exists in the Godot project but has not
  passed the complete lesson verification.
- **Validated** - the written procedure and resulting project behavior have
  passed the lesson verification.

Track Notion independently as **Not published**, **Current**, or **Out of
sync**. Learner verification checkboxes stay unchecked so learners can use
them; production validation belongs in the lesson status and roadmap.

Update the roadmap after an approved change to scope, sequence, dependencies,
architecture, lifecycle, validation, Notion publication, or Git association.
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
- Any relevant Godot, Codex, or Notion best practice, tip, or shortcut that
  makes the current work clearer, safer, or faster.

The blueprint can change during validation.

Before drafting, confirm the lesson's roadmap outcome, prerequisites, expected
artifacts, and concepts introduced for the first time. If the proposed lesson
changes the curriculum or architecture, update the roadmap only after that
change is approved.

These are planning considerations, not required learner-facing sections. Place
concepts, reasons, AI guidance, practical tips, and recovery help inside the
build steps where learners need them.

Use this learner-facing lesson structure:

1. **By the end** - combine the outcome, visible result, and one sentence of
   context.
2. **Before you start** - include only real prerequisites.
3. **Build steps** - teach concepts and reasoning beside the relevant actions.
4. **Learner exercise**.
5. **Verification checklist**.
6. **References**.

Format contextual lesson notes consistently:

- Put a new-concept explanation in a blue callout with a light-bulb icon. Use
  plain paragraphs without a title or bullets, and place the callout at the
  clearest point beside the concept's first practical use.
- Put recovery guidance in a gray callout with a warning icon and the heading
  **If something differs** without a colon. Keep it unindented and place it at
  the end of the corresponding lesson part.

### 2. Build

- Follow the blueprint in order.
- Explain only the part of Godot, Codex, Notion, Git, or Affinity needed for
  the current task.
- Introduce a practical best practice, tip, or shortcut when it directly helps
  the current task. Keep it brief and in context rather than turning it into a
  separate tool tutorial.
- Introduce each concept beside its first practical use, immediately before or
  after the action when that produces the clearest learner flow. Use only the
  detail needed for the current outcome.
- Use a single integrated lesson flow when Codex is involved; do not create
  repeated AI and non-AI versions of the same instructions.
- Run the project regularly.
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
- Keep the first pass focused on validated written instruction. Identify and
  add required screenshots, diagrams, or short demonstrations during a later
  visual-support pass.
- Associate the lesson with its Git commit and project version.
- Present the proposed Notion entry.
- Ask for permission before writing the lesson or updating its tasks in
  Notion.
- When approved, create the lesson page inside its parent Module page under
  the course page. Use a plain lesson title without a page or header icon.

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
6. Confirm that every concept is explained beside its first practical use.
7. Audit learner tools and clearly identify any optional paid service.
8. Verify that the final license allows games made with the framework to be
   sold while prohibiting resale of the framework itself.
9. Freeze matching course and template versions.
10. Adapt the verified lessons into recording outlines and production tasks.
