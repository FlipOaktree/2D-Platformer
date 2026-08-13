# Project Instructions

## Purpose

Build and validate a beginner-friendly course that teaches how to create a
modular Godot 2D platformer template. The template must be produced by following
the same written course material that learners will later use.

## Work One Step at a Time

- Before changing the project, describe the next bounded step, why it comes
  next, what it will affect, and how it will be verified.
- Wait for explicit user approval before starting that step.
- Do not begin the following step automatically after finishing the current one.
- After each step, report the result, tests, discoveries, and possible
  improvements, then preview the next proposed step.
- Treat the roadmap as changeable. Update affected instructions, tests, and
  lessons when the implementation improves.

## Course-First Workflow

- Read `.docs/course_workflow.md` before planning, implementing, testing, or
  documenting a course lesson.
- Draft the lesson blueprint before implementing its feature.
- Build the feature by following the blueprint in order.
- Test the result and revise the blueprint using what actually happened.
- Do not create videos or learner downloads until the complete written course
  has been rebuilt from an empty project and validated.
- Explain concepts with short beginner-friendly language covering what, how,
  and why. Introduce tools only when they are needed.
- Teach relevant Godot, Codex, and Notion best practices, tips, and shortcuts
  in context when they make the current task clearer, safer, or faster. Keep
  them brief; do not turn them into separate tool tours.
- Assume no Godot or programming experience, while expecting basic computer
  and file-management skills.

## Course Continuity

- Treat `.docs/course_roadmap.md` as the canonical source for the course scope,
  curriculum sequence, architectural direction, progress, and next lesson.
- At the start of every course-related task, read `.docs/course_workflow.md`,
  `.docs/course_roadmap.md`, and the affected completed and upcoming lessons.
- Inspect the relevant Godot artifacts and `git status`, then compare the
  observed state with the roadmap before proposing work.
- Report discrepancies between the roadmap, lesson files, Godot project, Git,
  and Notion before changing anything. Do not silently choose one version.
- Follow the roadmap's next planned lesson unless an approved curriculum change
  updates the roadmap first.
- Update the roadmap after an approved change to course scope, lesson sequence,
  architecture, lifecycle status, validation status, Notion publication, or
  Git association.
- Keep local repository files authoritative. Notion is the published mirror of
  validated course material, not the source for unfinished curriculum state.

## Integrated AI Workflow

- Treat Codex as a prominent optional accelerator within the same lessons, not
  as a separate course path.
- Establish understanding before acceleration. Demonstrate a representative
  pattern manually when needed, then use Codex for useful repetition, review,
  debugging, testing, documentation, or asset iteration.
- Require learners to inspect, explain, correct, and test AI output before
  accepting it.
- Do not duplicate modules or full instruction sequences for AI and non-AI
  learners. When needed, a short manual continuation note is enough.
- Do not force AI into a task when it provides no clear learning or efficiency
  benefit.
- Keep internal production tools, including ShareX, out of learner requirements
  unless the learner genuinely needs them.

## Notion Permission

- Never create or update course material or tasks in Notion without explicit
  permission.
- After a lesson is implemented and verified, present the proposed final entry
  and ask whether it should be logged in Notion.
- When approved to log a lesson, create it inside its parent Module page under
  the course page. Use a plain lesson title without a page or header icon.
- Keep unfinished drafts local or in the conversation until permission is
  granted.

## Godot Development Rules

- Use typed GDScript and Godot's built-in features when they keep the result
  clear and maintainable.
- Prefer small, self-contained scenes and composition over deep inheritance.
- Expose common customization through exported Inspector properties or focused
  configuration resources with safe defaults and helpful tooltips.
- Use signals for communication from a reusable child feature to its owner.
- Avoid hard-coded references to unrelated scenes and avoid global services
  unless data genuinely needs to survive across scenes.
- Design optional features so they can be added or removed without editing
  unrelated modules.
- Avoid repeated code, premature abstractions, and advanced patterns that do
  not solve a demonstrated problem.
- Use consistent names for files, nodes, variables, functions, and signals.
- Apply DRY when repetition creates a real maintenance problem, without hiding
  simple behavior behind premature abstraction.

## Verification

- Run the relevant scene or project after meaningful changes.
- Check parser errors, runtime errors, and unexplained warnings.
- Test affected keyboard and controller behavior.
- Add focused automated tests when logic is deterministic and benefits from
  regression coverage.
- For optional modules, verify customization and removal as well as normal use.
- Preserve unrelated user changes and never rewrite files merely to match a
  preferred style.


