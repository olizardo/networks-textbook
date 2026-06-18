# Plan - Fix Graph Efficiency Slides

Fix the newly added slides on graph efficiency in the slide deck `slides/graph-connectivity.qmd` so that the figures are the correct size, do not feature disconnected graphs, and the tree graph maximum efficiency has a detailed numerical demonstration.

## Proposed Changes

### 1. Slides File: `slides/graph-connectivity.qmd`

- **Ensure Connected Graphs**: Write a helper function `connected_gnm(n, m)` in the R setup chunk of `slides/graph-connectivity.qmd` that runs `play_gnm()` in a `repeat` loop until `is_connected()` is `TRUE`. This mathematically guarantees that no disconnected graphs are ever drawn or compared on the slides.
- **Detailed Numerical Proof for Trees**: Add a comprehensive step-by-step mathematical demonstration on "The Graph Efficiency" slide showing how a tree graph ($m = n - 1$) always yields $F(G) = 1.0$:
  1. Tree edges condition: $m = n - 1$.
  2. Substituting $m$ in $(m - n + 1)$ gives $(n - 1) - n + 1 = 0$.
  3. Substituting $0$ in the numerator gives $\frac{2(0)}{(n-1)(n-2)} = 0$.
  4. $F(G) = 1 - 0 = 1.0$.
- **Figure Sizing & Labeling**: Adjust layout figures `fig-width: 8`, `fig-height: 4.5`, and label scaling in the side-by-side R chunks (`p1 + p2`) to ensure that they are sized correctly for a 16:9 Reveal.js layout without overlaps.

## Verification Plan

1. Render the `slides/graph-connectivity.qmd` slide deck using `quarto render`.
2. Verify that it compiles with zero warnings or errors.
