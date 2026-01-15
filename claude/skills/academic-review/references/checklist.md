# Academic Review Checklist

Complete checklist for manual reference. Used by all three checker agents.

---

## Style Checks

### Sentence Length
- [ ] General sentences: 15-25 words
- [ ] Technical sentences: max 35 words
- [ ] No sentence exceeds 35 words without good reason

### Word Choice
- [ ] No "delve", "utilize", "leverage", "facilitate"
- [ ] No "stem from", "circumvent"
- [ ] No "crucial", "pivotal", "key" (overused)
- [ ] No "showcase", "landscape", "tapestry", "interplay"
- [ ] No "methodology" (use "method")
- [ ] "demonstrate" → "show" or "validate"

### Sentence Patterns
- [ ] No "stands as a testament to"
- [ ] No "plays a vital/crucial role"
- [ ] No "not only X but also Y"
- [ ] No "serves as" / "stands as" (use "is")
- [ ] No superficial "-ing" analyses
- [ ] No rule of three ("fast, efficient, and reliable")
- [ ] No vague attributions ("Experts argue...")

### Punctuation
- [ ] No em-dashes (—)
- [ ] No curly quotes
- [ ] Colons used sparingly

### Voice & Hedging
- [ ] Active voice for contributions
- [ ] Passive voice appropriate for definitions/results
- [ ] Hedging (may/might/could) not overused

### Metaphors
- [ ] No "opens new doors"
- [ ] No "paves the way"
- [ ] No "sheds light on"
- [ ] No "bridges the gap"

---

## Logic Checks

### Alignment
- [ ] Gap follows from literature review
- [ ] Each contribution addresses stated gap
- [ ] No orphan contributions (no matching gap)
- [ ] No orphan gaps (no matching contribution)

### Claims & Evidence
- [ ] Every claim has supporting evidence
- [ ] Evidence actually supports the claim
- [ ] Citations provided for factual claims

### Overclaiming
- [ ] No "revolutionary", "paradigm-shifting"
- [ ] No "unprecedented", "groundbreaking"
- [ ] No unverified "novel" or "first to"
- [ ] No unsupported superlatives

### Consistency
- [ ] Numbers consistent throughout
- [ ] Definitions consistent
- [ ] Abstract matches conclusion
- [ ] Methodology matches results

### Coherence
- [ ] Sections flow logically
- [ ] No logical jumps
- [ ] Transitions present where needed

---

## Format Checks

### Abbreviations
- [ ] First use: "Full Term (ABBR)"
- [ ] Subsequent uses: "ABBR" only
- [ ] No abbreviation before definition
- [ ] No re-definitions

### Citations
- [ ] All `\cite{}` keys exist in references
- [ ] Citations placed appropriately
- [ ] Claims requiring citation have one

### LaTeX
- [ ] Math mode correct
- [ ] Special characters escaped
- [ ] Required packages declared

### Figures & Tables
- [ ] All `\ref{}` have matching `\label{}`
- [ ] All figures/tables referenced in text
- [ ] Numbering consistent

### Structure
- [ ] Abstract present
- [ ] Introduction present
- [ ] Methodology present
- [ ] Results present
- [ ] Conclusion present
- [ ] References present

### Formatting
- [ ] Heading capitalization consistent (sentence case for IEEE)
- [ ] No orphan headings
- [ ] List formatting consistent
- [ ] Straight quotes, not curly

---

## Quick Pre-Submission Checklist

Before submitting, verify:

1. [ ] Ran `/academic-review full`
2. [ ] All Critical issues fixed
3. [ ] Most Minor issues addressed
4. [ ] Abbreviations checked manually
5. [ ] Citations verified with citation-management skill
6. [ ] Final read-through for flow
