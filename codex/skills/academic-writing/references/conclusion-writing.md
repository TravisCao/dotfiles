# Conclusion Writing

## Purpose

Summarize contributions and point toward future work without overclaiming.

## Structure

Two acceptable formats:

### Format A: Numbered List (for multiple distinct findings)
```
In this paper, [method] is proposed. [Algorithm] was developed to [purpose]. Our main findings are:
1. We prove theoretically that...
2. The proposed algorithm can reduce... by X%...
3. Compared with [baseline]...
```

### Format B: Paragraph Style (for coherent narrative)
```
[Background need]. This paper comes up with [method].
[Properties proved]. [Algorithm developed].
Future research may [direction].
```

### Components:
1. **Background Restatement** (1 sentence)
   - Restate the need/motivation briefly

2. **Summary of Contributions** (2-3 sentences)
   - What did we propose?
   - What did we prove?

3. **Key Findings** (1-3 items)
   - Can include specific numbers (unlike abstract)
   - Example: "reduce computational time by 95%"

4. **Future Work** (1-2 sentences, optional)
   - Keep it short and specific
   - Example: "Future research may use more accurate power flow models."

## Style

### Tone
- **Confident but not arrogant**
- **Precise** - use specific claims, not vague success
- **Forward-looking** - what's next?

### What to Avoid in Conclusions

❌ **Overclaiming**
- "This revolutionary work fundamentally transforms..."
- "We have completely solved the problem of..."
- "This paradigm-shifting approach..."

❌ **Vague summaries**
- "We presented a method for power systems."
- "Results show our approach works well."

❌ **Introducing new content**
- Don't mention results not discussed earlier
- Don't introduce new citations (rare exceptions exist)

✅ **Good conclusion style**
- "We developed a quantum-enhanced OPF framework integrating differential privacy."
- "Experiments on IEEE test systems show 40% computation time reduction while maintaining privacy (ε=0.1)."
- "Future work will extend this to AC power flow and larger networks."

## Template Structure

```
This paper presented [specific contribution]. 

We showed that [key finding with specific numbers/results].

[Optional: However, the current approach is limited to [specific limitation].]

Future work will [specific next steps].
```

## Examples from Supervisor's Papers

### Example A: Numbered List Style
> "In this paper, a novel RGD model considering preparatory schedule of renewable power curtailment is proposed. An adaptive C&CG algorithm was developed to solve the problem efficiently. Our main findings are:
> 1. We prove theoretically that the proposed algorithm can generate the robust optimal solution in a finite number of iterations.
> 2. The proposed algorithm can reduce the computational time by 95% compared with the nested C&CG algorithm.
> 3. Compared with the traditional model, the proposed model can avoid significant wind curtailments in the re-dispatch stage."

### Example B: Paragraph Style
> "With the mushrooming of distributed renewable energy at the demand side, new energy management schemes with explicit characterization on flexibility are in great need. This paper proposes an energy sharing mechanism that encourages energy exchange among end-users. We prove that the generalized Nash equilibrium achieves social optimum. Future research may use more accurate power flow models and consider multiple periods."

## Common Pitfalls

### 1. Repeating the Abstract
- Conclusion should feel like closure, not repetition
- Can be similar but should reflect what the paper showed

### 2. Underselling
- Don't be too modest - you did something, state it clearly
- But stay within bounds of what you actually showed

### 3. Overselling Future Work
❌ "In future work, we will revolutionize the entire energy sector"
✅ "Future work will test this approach on real utility data and explore extensions to multi-period OPF"

## Apply Common Rules

From `common-style-rules.md`:
- No overclaiming phrases
- Short, clear sentences
- Specific claims with evidence
- No flowery language

## To Develop Through Iteration

*As Travis writes conclusions, add:*
- Examples of well-balanced conclusions
- Patterns for framing limitations productively
- Preferred structure for future work sections
