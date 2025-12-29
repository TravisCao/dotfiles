# Common Writing Style Rules

These rules apply to ALL sections of Travis's papers.

## Critical Rules (ALWAYS Follow)

### 1. Sentence Length Guidelines
- **General sentences**: 18-30 words
- **Technical sentences** (with equations or multiple conditions): 28-40 words acceptable if clear
- **Transition sentences**: 10-18 words
- **When to use longer sentences:**
  - Describing causality with multiple factors
  - Listing conditions or constraints
  - Explaining mathematical relationships
- **Clarity guardrails:**
  - Prefer one main clause; if there are more than two subordinate clauses, split
  - Aim to place the subject and verb in the first 15-18 words
  - Avoid stacking more than three prepositional phrases
  - Use a semicolon at most once per paragraph
  - Definitions, assumptions, or equation lead-ins can be longer, but keep a single main clause
- **Check**: Can you read it aloud in one breath? If not, consider breaking it up.

### 2. Preferred Word Choices
| Avoid | Use Instead |
|-------|-------------|
| utilize | use |
| leverage | use, apply |
| facilitate | enable, allow |
| demonstrate (alone) | show, validate |
| methodology | method |

**Advantageous** is acceptable when you state a specific advantage.

**For verification statements:** Use "validate" not just "show"
- ✅ "Case studies validate the theoretical results"
- ❌ "Case studies show the results"

### 3. Avoid Overclaiming and Value Judgments
**Never use these phrases:**
- ❌ "revolutionary approach"
- ❌ "paradigm-shifting method"
- ❌ "new paradigm"
- ❌ "completely/totally/fundamentally changes"
- ❌ "groundbreaking"
- ❌ "unprecedented"

**Novel** is acceptable when the gap is explicit and specific. Otherwise use "new" or be specific.

**Instead, be specific and measured:**
- ✅ "This method reduces computation time by 40%"
- ✅ "Unlike previous approaches, our method preserves privacy"
- ✅ "This is the first approach to combine quantum circuits with differential privacy for OPF"

### 4. Avoid Hypey Metaphors and Marketing Phrasing
Avoid flowery metaphors or marketing language. Mild, field-standard phrases are acceptable if they do not imply overclaiming.

- ❌ "opens a new era"
- ❌ "sheds light on"
- ❌ "bridges the gap between"
- Use sparingly: "paves the way for" (do not imply a paradigm shift)
- ✅ Be direct: "This approach enables X" or "This method provides Y"

### 5. Abbreviation Consistency
**Critical pattern:**
- First mention: "Optimal Power Flow (OPF)"
- All subsequent uses: "OPF" (never switch back to full form)
- **Common mistake**: Alternating between "Optimal Power Flow" and "OPF" in the same paper

**Before submitting, check:**
- [ ] Every abbreviation has full form on first use
- [ ] No abbreviation alternates between full and short form

## Preferred Style

### Tone
- **Technical but readable** - assume reader is expert in power systems, but may not know quantum computing (or vice versa)
- **Precise** - use exact technical terms, not approximations
- **Modest** - let results speak for themselves
- **Clear** - prioritize clarity over sophistication

### Audience
- **Primary reader**: smart grid PhD-level; broad domain knowledge, subfield details may be unfamiliar
- **Implication**: define specialized subfield terms at first use and add one-sentence context for niche methods

### Structure
- **Logical flow** - each sentence should follow naturally from the previous
- **Topic sentences** - start paragraphs with the main point
- **Transitions** - use explicit connectors when changing topics (but don't overuse)

### Recommended Transition Words
Use appropriately to highlight logic, but avoid overuse:

| Purpose | Words | Usage Note |
|---------|-------|------------|
| Contrast | However, In contrast, Although, While | Use when changing direction |
| Causality | Therefore, Thus, As a result | Use for conclusions |
| Addition | Moreover, Furthermore, Besides | Use sparingly |
| Sequence | First, Then, Finally | For steps/procedures |
| Clarification | Specifically, In particular | For details |

**Caution:** Don't use multiple emphasis transitions in one paragraph.

### Voice (Specific Rules)
- **Active voice for contributions and methods:**
  - "We propose...", "This paper develops...", "We prove that..."
- **Passive voice for definitions and results:**
  - "The curtailment is defined as...", "The existence is proved..."
  - "An algorithm is developed to..."
- **First person acceptable** - "we propose", "our method" is fine
- **Present tense for contributions** - "This paper presents", "We develop"
- **Past tense for experiments** - "We tested", "The results showed"

## Pre-Submission Checklist

Before finalizing ANY section, verify:
- [ ] Avoid sentences >40 words; allow 1-2 sentences >35 words per paragraph if needed and clear
- [ ] No fancy words that could be simpler
- [ ] No overclaiming ("revolutionary", "paradigm", etc.)
- [ ] No hypey metaphors or marketing language
- [ ] Abbreviations consistent (full form first, then abbreviation only)
- [ ] Each paragraph has clear topic sentence
- [ ] Logical flow between sentences
