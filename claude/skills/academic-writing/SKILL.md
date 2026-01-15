---
name: academic-writing
description: Academic writing assistant for power systems and quantum computing research papers. Helps write IEEE-style papers, including abstract, introduction (with literature review), methodology, case studies, results, and conclusions. Addresses specific writing issues like verbose sentences, overclaiming, inconsistent abbreviations, and gap-literature logic mismatches.
---

# Academic Writing Assistant

This skill helps write academic papers for power systems and quantum computing research.

## How to Use This Skill

**For different sections, read the appropriate reference file:**

- **Abstract writing** → Read `~/.claude/skills/academic-writing/references/abstract-writing.md`
- **Introduction writing** → Read `~/.claude/skills/academic-writing/references/introduction-writing.md` (includes literature review workflow)
- **Methodology writing** → Read `~/.claude/skills/academic-writing/references/methodology-writing.md`
- **Case study/results** → Read `~/.claude/skills/academic-writing/references/case-study-writing.md`
- **Conclusion** → Read `~/.claude/skills/academic-writing/references/conclusion-writing.md`
- **LaTeX tables** → Read `~/.claude/skills/academic-writing/references/latex-tables.md`

**Always apply:**
- Read `~/.claude/skills/academic-rules/common-style-rules.md` for universal writing guidelines
- Read `~/.claude/skills/academic-rules/ai-writing-mistakes-to-avoid.md` for AI writing patterns to avoid

## Critical Reminders

1. **Abbreviations**: First use MUST be "Full Term (ABBR)", then use "ABBR" consistently
2. **No literature fabrication**: Use web_search for citations, never invent authors/years/venues
3. **Gap-literature alignment**: Gap statements must directly follow from specific literature limitations
4. **Style check**: Before finalizing, verify against common-style-rules.md

## After Writing

**Recommend using `/academic-review`** to check for issues that self-review tends to miss:
- Style violations (AI patterns, sentence length)
- Logic issues (gap-literature mismatch, overclaiming)
- Format problems (abbreviation consistency, citations)
