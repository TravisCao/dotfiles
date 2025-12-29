# Introduction Writing

## Workflow

Follow this sequence when writing introductions:

1. **Literature research** (if needed)
2. **Draft outline** (storyline and logical structure)
3. **Write sections** (background → literature review → gap → contribution)
4. **Cross-check gap-literature alignment**
5. **Apply style rules** (from common-style-rules.md)

## Literature Review Workflow

### Critical Rule: NO FABRICATION
**Never invent citation details.** If you don't have real information, use web_search.

### Research Process

When Travis asks for literature review:

1. **Use web_search** to find relevant papers
   - Search terms: "quantum computing power systems", "OPF privacy", "differential privacy optimization"
   - Look for recent papers (2020+) from IEEE, arXiv, journal databases

2. **Use web_fetch** to read key papers
   - Get actual paper content, not just abstracts
   - Extract specific contributions, not general descriptions

3. **Document each paper with:**
   - ✅ Title (exact)
   - ✅ Authors (full names)
   - ✅ Year
   - ✅ Venue (conference/journal name)
   - ✅ Specific contribution (what did they do?)
   - ✅ Limitations (what gaps exist?)
   - ✅ Citation format for bibliography

4. **Store findings systematically**
   - Create a list of papers with metadata
   - Group by topic/approach
   - Note relationships between papers

### Commenting on Literature

**Problem: 点评文献问题表述不够精准**

❌ **TOO VAGUE:**
"Several researchers have explored quantum approaches for power systems optimization."

✅ **PRECISE:**
"Smith et al. [15] applied quantum annealing to unit commitment, achieving 30% speedup for 50-bus systems. However, their approach did not address privacy concerns in data sharing."

**Rules for literature commentary:**
- Cite specific results/equations, not general claims
- Quote exact performance numbers when available
- State the exact problem each paper addresses
- Identify concrete limitations (not vague weaknesses)

## Introduction Structure

### Standard Flow
1. **Background/Motivation** (1-2 paragraphs)
   - Why is this problem important?
   - What is the broader context?
   
2. **Literature Review** (2-3 paragraphs)
   - What have others done?
   - **Group by approach/methodology**
   - Be specific about contributions
   - Compare and contrast different approaches

**Literature Review Template (Categorized):**
```
The existing work can be divided into [N] categories according to [criterion].

\textbf{Category 1: [Name].} This category follows... [cite1,cite2].
[Brief description of approach]. [Limitation].

\textbf{Category 2: [Name].} This category employs... [cite3,cite4].
[Brief description]. [How it differs from Category 1].

\textbf{Category 3: [Name].} Unlike the above, this category... [cite5].
[Description]. [Remaining gap].
```

**Example:**
> "The existing work can be divided into three categories according to the game-theoretic framework.
>
> \textbf{Stackelberg Game based Sharing.} This category follows a leader-follower structure \cite{liu2017energy,cui2017distributed}. The operator acts as leader setting prices, while prosumers respond as followers. However, prosumers have limited autonomy.
>
> \textbf{Generalized Nash Game based Sharing.} This category treats all participants as equal players \cite{chen2020energy}. It allows more flexibility but equilibrium analysis becomes complex.
>
> \textbf{Coalition Game based Sharing.} Unlike the above noncooperative frameworks, this category employs cooperative game theory \cite{long2019game}."

3. **Research Gap** (1 paragraph)
   - What specific limitation exists?
   - **CRITICAL**: Gap must directly follow from literature
   
4. **Our Contribution** (1 paragraph)
   - Use **bold headers** for each contribution
   - List 2-3 specific contributions
   - Be specific, avoid overclaiming

**Contribution Format Template:**
```latex
\textbf{Contribution 1: [Short Title].} We propose...

\textbf{Contribution 2: [Short Title].} We prove that...

\textbf{Contribution 3: [Short Title].} We develop...
```

**Example from supervisor's paper:**
> \textbf{Mechanism Design.} We propose an energy sharing mechanism considering network constraints and fairness.
>
> \textbf{Theoretical Analysis.} We prove that the market equilibrium exists and is unique under price regulation.
>
> \textbf{Algorithm Development.} A practical bidding algorithm with convergence guarantee is developed.

### Gap Writing (Critical)

**Problem: Gap与前面点评文献的时候逻辑不符**

The gap must be a DIRECT consequence of limitations identified in literature review.

❌ **MISALIGNED:**
Literature review: "Smith [10] used quantum circuits for OPF. Jones [11] applied differential privacy to power systems."
Gap: "However, no one has addressed scalability in large networks."
*Problem: Scalability was never mentioned as a limitation!*

✅ **ALIGNED:**
Literature review: "Smith [10] used quantum circuits for OPF but tested only on 33-bus systems. Jones [11] applied differential privacy to power systems but did not consider quantum approaches."
Gap: "However, existing quantum methods have not been validated on larger networks, and privacy-preserving approaches have not leveraged quantum computation."

**Template for gap writing:**
```
Literature shows: [specific limitations from reviewed papers]
↓
Gap: These limitations mean that [specific capability] is missing
↓
Our contribution: We address this by [specific approach]
```

### Logical Flow Checklist

Before finalizing introduction, verify:
- [ ] Each literature comment cites specific contributions (not vague summaries)
- [ ] Gap statement explicitly references limitations mentioned in literature review
- [ ] Gap uses words/concepts that appeared in the literature review
- [ ] Contribution directly addresses the stated gap
- [ ] No "surprise gaps" that weren't foreshadowed in literature review

## Common Pitfalls (Travis-Specific)

### 1. Literature Without Sources
❌ "Recent work has explored quantum optimization"
✅ Use web_search to find actual papers, get real citations

### 2. Imprecise Commentary  
❌ "They proposed an interesting approach"
✅ "They formulated OPF as a QUBO problem and solved it using quantum annealing [15]"

### 3. Weak Gap Transitions
❌ "However, challenges remain." (What challenges? From where?)
✅ "However, Smith's approach [10] requires exponential classical preprocessing, limiting scalability."

### 4. Overclaiming Contribution
❌ "We propose a revolutionary framework that fundamentally changes..."
✅ "We develop a quantum-enhanced OPF framework that integrates differential privacy, reducing computation time by 40% while preserving privacy guarantees."

## Examples (To Be Added)

*As Travis writes more papers, add examples of:*
- Well-aligned gap statements
- Precise literature commentary
- Good logical flow from background → gap → contribution
