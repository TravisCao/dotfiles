# Common Writing Style Rules

These rules apply to ALL sections of Travis's papers.

## Critical Rules (ALWAYS Follow)

### 1. Sentence Length Guidelines
- **General sentences**: 15-25 words
- **Technical sentences** (with equations or multiple conditions): 25-35 words acceptable
- **Transition sentences**: 10-15 words
- **When to use longer sentences:**
  - Describing causality with multiple factors
  - Listing conditions or constraints
  - Explaining mathematical relationships
- **Check**: Can you read it aloud in one breath? If not, consider breaking it up.

### 2. Preferred Word Choices
| Avoid | Use Instead |
|-------|-------------|
| utilize | use |
| leverage | use, apply |
| facilitate | enable, allow |
| demonstrate (alone) | show, validate |
| methodology | method |
| advantageous | beneficial |

**For verification statements:** Use "validate" not just "show"
- ✅ "Case studies validate the theoretical results"
- ❌ "Case studies show the results"

### 3. Avoid Overclaiming and Value Judgments
**Never use these phrases:**
- ❌ "revolutionary approach"
- ❌ "paradigm-shifting method"
- ❌ "completely/totally/fundamentally changes"
- ❌ "groundbreaking"
- ❌ "unprecedented"
- ❌ "novel" (unless you can prove no one has done it before)

**Instead, be specific and measured:**
- ✅ "This method reduces computation time by 40%"
- ✅ "Unlike previous approaches, our method preserves privacy"
- ✅ "This is the first approach to combine quantum circuits with differential privacy for OPF"

### 4. Avoid Metaphors and Flowery Language
- ❌ "This approach opens new doors"
- ❌ "paves the way for"
- ❌ "sheds light on"
- ❌ "bridges the gap between"
- ❌ "stem from" / "stems from"
- ✅ Be direct: "This approach enables X" or "This method shows Y"
- ✅ Instead of "stem from": use "result from", "arise from", "are caused by"

### 5. Punctuation Rules
- **No em-dashes (—)** in formal academic writing
  - ❌ "The method — which is novel — improves accuracy"
  - ✅ Use commas: "The method, which is novel, improves accuracy"
  - ✅ Use parentheses: "The method (which is novel) improves accuracy"
  - ✅ Split into two sentences if the aside is long

### 6. Abbreviation Consistency
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
- [ ] No sentences >25 words (or if needed, they're crystal clear)
- [ ] No fancy words that could be simpler
- [ ] No overclaiming ("revolutionary", "paradigm", etc.)
- [ ] No metaphors
- [ ] No em-dashes (use commas or parentheses)
- [ ] Abbreviations consistent (full form first, then abbreviation only)
- [ ] Each paragraph has clear topic sentence
- [ ] Logical flow between sentences
