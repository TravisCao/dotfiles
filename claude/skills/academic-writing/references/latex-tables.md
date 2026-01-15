# LaTeX Table Formatting Rules

Standard table structure for IEEE-style academic papers.

## Basic Template

```latex
\begin{table}[htbp]
    \centering
    \begin{threeparttable}
    \caption{Table caption}
    \label{tab:xxx}
    \begin{tabular}{column_format}  % NOT tabular*
        \toprule
        ... headers ...
        \midrule
        ... content ...
        \bottomrule
    \end{tabular}
    \begin{tablenotes}
    \item[] {\footnotesize Footnote content}
    \end{tablenotes}
    \end{threeparttable}
\end{table}
```

## Key Rules

| Item | Use | Avoid |
|------|-----|-------|
| Environment | `tabular` | `tabular*{\columnwidth}` |
| Column width | Auto-fit to content | `@{\extracolsep{\fill}}` |
| Footnotes | `threeparttable` + `tablenotes` | `minipage`, `\\[2mm]` |
| Lines | `booktabs`: `\toprule`/`\midrule`/`\bottomrule` | `\hline` |

## Footnote Formatting

- **No numbering**: `\item[] {\footnotesize content}`
- **With numbering**: Use `\tnote{1}` in table, `\item[1] explanation` in tablenotes

## Required Packages

```latex
\usepackage{booktabs}       % Professional table lines
\usepackage{threeparttable} % Table footnotes
\usepackage{multirow}       % Multi-row cells
```
