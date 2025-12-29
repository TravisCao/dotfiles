# Case Study and Results Writing

## Purpose

Present experimental setup and results systematically and reproducibly.

## Structure

### Case Study Section
1. **System Description**
   - Test case details (e.g., IEEE 33-bus system)
   - Network topology
   - Data sources

2. **Parameter Settings**
   - Algorithm parameters
   - Quantum circuit configuration
   - Privacy parameters (ε, δ)
   
3. **Baseline Comparison**
   - What are we comparing against?
   - Why these baselines?
   
4. **Evaluation Metrics**
   - What are we measuring?
   - Why these metrics?

### Results Section
1. **Main Results**
   - Present key findings
   - Use tables and figures
   
2. **Analysis**
   - Interpret results
   - Compare to baselines
   
3. **Ablation Studies** (if applicable)
   - Component-wise analysis
   - Sensitivity to parameters

## Travis's Approach: "Narratively but also let tables/figures speak"

**Balance narrative with data:**

❌ **TOO SPARSE:**
"Results are shown in Table 1."

❌ **TOO NARRATIVE (drowning the data):**
"The results demonstrate that our method achieves superior performance, with the quantum approach showing remarkable efficiency gains of 42.3% compared to the classical baseline, while simultaneously maintaining privacy guarantees that exceed those of traditional differential privacy approaches by a factor of 1.8, which is particularly noteworthy given the computational constraints inherent in quantum systems."

✅ **BALANCED:**
"Table 1 shows the performance comparison. Our quantum approach reduces computation time by 42% compared to the classical baseline while maintaining privacy guarantees (ε=0.1). The speedup is consistent across different network sizes."

**Guideline:**
- **Figures/tables**: Should be self-explanatory with good captions
- **Text**: Highlights key takeaways, patterns, or surprises
- **Don't repeat**: If it's obvious from the figure, don't re-state in words
- **Do interpret**: Explain non-obvious patterns or implications

## Writing Style

### Voice and Tense
- **Past tense for experiments**: "We tested on three networks. The results showed..."
- **Present tense for observations**: "Figure 3 shows that performance degrades..."
- **Both active and passive acceptable**: Use what flows

### Organizing Results

**By experiment type:**
- Main results first
- Ablation studies next
- Sensitivity analysis last

**By research question:**
- RQ1: Does it work? → Main results
- RQ2: How does privacy affect performance? → Privacy analysis
- RQ3: Does it scale? → Scalability results

Choose organization that serves the paper's narrative.

## Tables and Figures

### Table Guidelines
- Clear captions that explain what's being compared
- Bold best results
- Include standard deviations if stochastic
- Keep tables simple - move detailed data to appendix

### Figure Guidelines
- Large, readable fonts
- Clear axis labels with units
- Legend positioned appropriately
- Color-blind friendly colors
- Referenced in text before appearance

## Common Pitfalls

### 1. Parameter Dumps
❌ "We set α=0.1, β=0.05, γ=2.3, δ=10^-6, ε=0.1, λ=0.8..."
✅ Use a table for parameter settings, or mention only the critical ones in text

### 2. Cherry-picking
- Show representative results, not just best case
- Acknowledge when methods fail or have limitations
- Include error bars or confidence intervals

### 3. Weak Interpretation
❌ "Figure 2 shows the results."
✅ "Figure 2 shows that computation time scales linearly with network size, indicating good scalability."

## To Develop Through Iteration

*As Travis writes results sections, add:*
- Preferred table formatting styles
- Examples of good figure captions
- Patterns for presenting privacy-utility trade-offs
- Standard performance metrics for power systems papers

## Apply Common Rules

From `common-style-rules.md`:
- Short, clear sentences
- No overclaiming ("dramatically outperforms")
- Specific numbers, not vague claims
- No flowery language
