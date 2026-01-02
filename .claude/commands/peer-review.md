# Peer Review Skill

Write a structured peer review for an academic paper.

## Usage
```
/peer-review <pdf_path> [notes]
```

## Arguments
- `pdf_path` (required): Path to the PDF file
- `notes` (optional): Additional observations or concerns to incorporate

## Instructions

1. Read the PDF file provided
2. Analyze the manuscript thoroughly, focusing on:
   - Core contribution and its clarity
   - Technical correctness and rigor
   - Presentation quality
   - Missing references or context
   - Notation and terminology consistency

3. Write a structured review with this format:
   - **Opening**: 1-2 sentences summarizing what the paper does, followed by your main assessment/concern
   - **Numbered comments**: Specific technical issues, each as a direct statement (NO bold keywords or labels before points)
   - **Minor issues section**: Grammar, typos, formatting issues as sub-bullets under a final numbered point

4. Writing style requirements:
   - Be direct and specific, not vague
   - Reference specific sections, equations, figures by number
   - Ask clarifying questions where appropriate (e.g., "What is the relationship between X and Y?")
   - Do NOT use bold keywords/labels before each point (wrong: "**Clarity**: The paper..." / right: "The paper...")
   - Use sub-bullets only within the minor issues section

5. If user provided notes, incorporate those observations into the appropriate sections

6. Save the review to `review-{original_filename}.md` in the same directory as the PDF

## Example Output Format

```
This manuscript introduces [brief summary]. However, [main concern or assessment].

1) [Specific technical issue with section/equation references]
2) [Another issue, asking clarifying questions if needed]
3) [Continue as needed]
N) Minor issues:
   - [Grammar issue with quote]
   - [Typo location]
   - [Formatting inconsistency]
```
