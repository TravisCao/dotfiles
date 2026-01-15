---
name: academic-review
description: Multi-agent academic paper reviewer. Uses parallel agents (Style, Logic, Format checkers) to overcome LLM self-preference bias. Call after writing with academic-writing skill.
---

# Academic Review Agent

Multi-agent review system to catch issues that single-agent review misses due to self-preference bias.

## Architecture

```
             Orchestrator (this skill)
                      |
       +--------------+--------------+
       |              |              |
   Style          Logic          Format
   Checker        Checker        Checker
```

## Usage

### Commands
- `/academic-review section` - Review a single section (+ context for coherence)
- `/academic-review full` - Review entire paper

### Input
User provides either:
- LaTeX file path (e.g., `introduction.tex`)
- Pasted text directly

## Orchestrator Workflow

### Step 1: Gather Input

Ask user:
1. Review type: `section` or `full`
2. Content source: file path or pasted text

If file path provided:
- For **section review**: Read the target file + adjacent sections for coherence check
- For **full review**: Read main.tex, parse `\input{}` order, read all sections

### Step 2: Dispatch Parallel Checkers

**CRITICAL**: Launch all 3 checkers in ONE message using Task tool.

Each Task prompt MUST explicitly include:
1. Instruction to read its agent definition file (absolute path)
2. The full text to review
3. For section review: adjacent section content for coherence

**Example prompts:**

```
Task(prompt="You are a Style Checker.
1. Read ~/.claude/skills/academic-review/agents/style-checker.md for your rules
2. Also read ~/.claude/skills/academic-rules/common-style-rules.md and ~/.claude/skills/academic-rules/ai-writing-mistakes-to-avoid.md
3. Review this text and output findings in the format specified:

[PASTE CONTENT HERE]", subagent_type="general-purpose")
```

```
Task(prompt="You are a Logic Checker.
1. Read ~/.claude/skills/academic-review/agents/logic-checker.md for your rules
2. Review this text for logical consistency:

[PASTE CONTENT HERE]

Adjacent sections for coherence check:
[PREVIOUS SECTION]
[NEXT SECTION]", subagent_type="general-purpose")
```

```
Task(prompt="You are a Format Checker.
1. Read ~/.claude/skills/academic-review/agents/format-checker.md for your rules
2. Review this text for formatting issues:

[PASTE CONTENT HERE]", subagent_type="general-purpose")
```

### Step 3: Aggregate Results

Combine all checker outputs into unified report:

```markdown
# Academic Review Report

**Date**: YYYY-MM-DD HH:MM
**File**: [filename or "pasted text"]
**Type**: section | full

## Summary
- Critical Issues: X
- Minor Issues: Y

## Critical Issues
[Combined from all checkers, sorted by severity]

## Minor Issues
[Combined from all checkers]

## Passed Checks
[What passed from each checker]

## Action Items
- [ ] Issue 1 description (Source: Style/Logic/Format)
- [ ] Issue 2 description
...
```

### Step 4: Save Report

Save to: `docs/reviews/YYYY-MM-DD-HH-MM-<filename>-review.md`

If `docs/reviews/` doesn't exist, create it.

## Handling Multi-file Papers

For papers with multiple .tex files:

1. Read `main.tex` to find `\input{}` order
2. Build section sequence: intro.tex → method.tex → results.tex → ...
3. For section review of `method.tex`:
   - Also read `intro.tex` (previous) and `results.tex` (next)
   - Pass adjacent content to checkers for coherence checking

## Handling Single-file Papers

For single .tex files:

1. Parse `\section{}` markers to identify boundaries
2. For section review:
   - Extract target section
   - Extract previous and next sections
   - Pass all three to checkers

## Reference Files

- `~/.claude/skills/academic-review/agents/style-checker.md` - Style checking rules
- `~/.claude/skills/academic-review/agents/logic-checker.md` - Logic checking rules
- `~/.claude/skills/academic-review/agents/format-checker.md` - Format checking rules
- `~/.claude/skills/academic-review/references/checklist.md` - Complete checklist for manual reference
- `~/.claude/skills/academic-rules/common-style-rules.md` - Shared style rules
- `~/.claude/skills/academic-rules/ai-writing-mistakes-to-avoid.md` - AI patterns to avoid
