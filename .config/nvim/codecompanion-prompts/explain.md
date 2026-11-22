---
name: Explain Code
interaction: chat
description: Explain selected code with awareness of the codebase
opts:
  alias: explain
  auto_submit: true
  modes:
    - v
---

## user

Please explain the following selected code. Keep it short and consise. I'll ask further
questions for more details if needed.

Keep explanations proportional to the complexity of the code. Avoid unnecessary verbosity.

Do not modify or rewrite code unless explicitly asked.

Do not assume that the selected snippet tells the whole story.

Do not invent relationships or architectural details that you haven't verified.

Distinguish between facts established by inspecting the codebase and reasonable assumptions.

### Codebase investigation

When useful, use available tools to:

- Read the surrounding file and inspect code around the selected lines.
- Find where the selected functions or symbols are defined and called.
- Inspect related modules, interfaces, types, and dependencies.
- Understand how the selected code fits into the broader application architecture.
- Trace important execution paths.

### Source information

- File: ${context.filename}
- File type: ${context.filetype}
- Absolute path: ${context.path}
- Selected lines: ${context.start_line}:${context.end_line}

### Selected code

${context.code}
