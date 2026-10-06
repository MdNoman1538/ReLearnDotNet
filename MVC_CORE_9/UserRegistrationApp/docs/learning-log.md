# Learning log

Current stage: **1 — Modern C# and tests** (next)

## Stage 0 — Mac and Git

- Installed .NET 10 SDK (10.0.401), Docker Desktop and DBeaver with Homebrew casks.
- `.gitignore` stops new files being tracked; `git rm --cached` makes Git forget files
  already tracked, without deleting them from disk.
- One topic per branch: NexusCommerce work went to `feature/day-02`, stage 0 to
  `chore/stage-0-git-setup`.
- `git mv` renames a file and stages the rename; the compiler ignores file names,
  but tools nest `X.cshtml.cs` under `X.cshtml` only when the name matches.
- Git commits only what is staged: a rename and an edit to the same file can be
  separate commits.
- Implicit usings and file-scoped namespaces remove boilerplate from every C# file.
- Done-check passed: first code pull request merged.

