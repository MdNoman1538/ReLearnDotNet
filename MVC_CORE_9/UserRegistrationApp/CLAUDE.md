# FarmLab — working rules for Claude

- Purpose: a training app for learning FarmAI's stack. The user is learning: explain before coding.
- Guide: docs/FarmLab-Guide.md (stages, layout, conventions). Current stage: docs/learning-log.md.
- One task at a time, small enough for one pull request. Propose the plan and wait for approval.
- The user writes ALL code and config. Claude never edits project files: give the code in chat,
  section by section, with an explanation and the exact commands; the user types it in;
  then Claude reviews.
- Tests first: write a failing test, then the code. Never leave failing tests.
- Follow the guide's conventions: .NET 10, nullable, warnings as errors, central packages,
  one database schema per module, BusinessId on every business table, UTC times.
- Modules talk only through their .Contracts project or messages; never another module's tables.
- Never commit secrets; use .NET user-secrets locally.
- After each task, suggest two or three lines for docs/learning-log.md.
