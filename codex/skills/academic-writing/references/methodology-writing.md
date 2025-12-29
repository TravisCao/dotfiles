# Methodology Writing

## Purpose

Describe the technical approach clearly enough for reproduction.

## Structure

1. **Problem Formulation**
   - Mathematical notation
   - Define variables, constraints, objectives
   
2. **Proposed Approach**
   - Overview of method
   - Algorithm/procedure
   - Key innovations
   
3. **Implementation Details**
   - How it works in practice
   - Computational considerations
   
4. **Complexity/Guarantees** (if applicable)
   - Theoretical properties
   - Convergence, optimality, privacy guarantees

## Style Differences from Introduction

- **More technical precision** - exact mathematical formulations
- **Less narrative** - focus on "what" and "how", not "why"
- **Equations are primary** - text supports equations, not vice versa
- **Reproducibility focus** - enough detail for someone to implement
- **Both active and passive voice acceptable** - use what flows naturally

## Key Principles

### Mathematical Notation
- Define all variables before first use
- Use standard notation for power systems (P, Q, V, θ)
- Be consistent with notation from introduction
- Number important equations for reference

### Equation Presentation Pattern

**Three-step pattern:**
1. **Introductory sentence** (before equation)
2. **Equation with label**
3. **Variable explanation** (after equation)

**Template:**
```latex
The [problem/model/constraint] is formulated as:
\begin{equation}
\label{eq:name}
[equation]
\end{equation}
where $x$ is [meaning], $y$ represents [meaning], and $z$ denotes [meaning].
```

**Example from supervisor's paper:**
> "The robust generation dispatch model considering preparatory curtailment is given below:"
> [Equation]
> "where $\xi_{jt}$ is the curtailment of renewable generator $j$ at time $t$, and $W(\xi)$ is the decision-dependent uncertainty set."

### Algorithm Description
**Flexible approach - choose what fits:**
- Prose description (for simple methods)
- Pseudocode (for complex algorithms)
- Flowchart + prose (for multi-stage procedures)

**Travis's flexibility**: Sometimes algorithms need full pseudocode, sometimes prose is enough. Choose based on complexity.

### Technical Depth
- Assume reader knows power systems basics (OPF formulation, AC power flow)
- Explain quantum computing concepts when needed (many power systems researchers won't know)
- Balance rigor with readability - derivations in appendix if too long

## Common Patterns for Power Systems + Quantum

1. **Start with classical formulation**
   ```
   Standard OPF formulation:
   minimize f(x)
   subject to: g(x) = 0, h(x) ≤ 0
   ```

2. **Introduce quantum/privacy modification**
   - What changes from classical approach?
   - How are quantum circuits structured?
   - Where does privacy mechanism enter?

3. **Maintain notation consistency**
   - If you use P_i for power in intro, use P_i in methodology
   - Don't switch between symbols mid-paper

## To Develop Through Iteration

*As Travis writes methodology sections, add:*
- Preferred equation formatting style
- Examples of good algorithm descriptions
- Common quantum computing explanations for power systems audiences
- Patterns for describing privacy mechanisms

## Apply Common Rules

Don't forget to apply `common-style-rules.md`:
- No overclaiming ("revolutionary quantum method")
- Shorter sentences where possible
- Precise technical language, not fancy words
