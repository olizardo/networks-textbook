# Plan: Draft `slides/affiliation-networks.qmd`

## Goal
Create a new Reveal.js slide deck (`slides/affiliation-networks.qmd`, title "Affiliation Networks") pairing with chapter 25 (`25-sna-affiliation-networks.qmd`), combining the chapter's pedagogy with the structure and running example of the user's Google Slides deck (ID `1n0_iD-h0Wnx7B_Mjl9uq7OFajtvLa3hquSaqjeOcpcs`, text extracted to `$PA_SCRATCH_DIR/affiliation_slides.txt`).

## Confirmed decisions
- **Running example**: the Google deck's fixed 6×5 example — people {Gabriela, Parker, Brandon, Marie, Rahul, Minjoo} × groups {Super Smash Bros., Cheese, Nerdfighters, Magic, Fashion}, hardcoded affiliation matrix (no RNG):
  rows: Gabriela 1 0 1 0 1 · Parker 0 1 0 1 0 · Brandon 0 1 0 0 0 · Marie 1 0 1 0 0 · Rahul 0 1 0 0 1 · Minjoo 0 1 0 1 1
  (row sums = 3 2 1 2 2 3; column sums = 2 4 2 2 3; m = 13 edges)
- **Reveal style**: repo standard — `incremental: false` with selective `. . .` builds.
- **Scope**: ~35–40 slides; collapse the Google deck's build-up repetitions, keep all concepts, worked matrix examples, applications, and glossary.

## Deck outline (~38 slides in 6 parts)

**Opening (3)**
1. Title slide
2. One-mode vs. two-mode networks: person-person / org-org / airport-airport vs. persons-groups, actors-movies, scientists-papers (Google deck intro)
3. What gets studied as affiliation networks: corporate boards/interlock, books-buyers, scientists-journals, actors-movies (fold in the chapter's corporate interlock motivation)

**Part 1 — From theory to graph to matrix (2)**
4. The "three-step shuffle": theory concept → graph-theoretic representation → matrix-algebraic measure (Google deck's signature framing; chapter's @sec-affiliation opening)
5. Formal definition of affiliation / membership relation; affiliation networks as special case of two-mode networks (⊆ multi-mode) — from chapter

**Part 2 — Bipartite graphs (~10)**
6. Bipartite graph of the running example (ggraph, two node shapes/colors, U/V sets)
7. Definition: $G_B = (E, V_1, V_2)$; disjoint sets; edges only between sets; |U| ≠ |V| allowed; undirected because membership is symmetric (chapter + deck)
8. Node neighborhoods in bipartite graphs — N(Minjoo), N(Gabriela), their intersection (shared club) and union
9. Neighborhoods of the other mode — N(Cheese), N(Fashion), intersection = {Rahul, Minjoo}
10. Node degree in bipartite graphs: per-person |N| list and per-group list
11. Graph metrics double up: two degree sequences (sorted)
12. …two kmax/kmin, two degree ranges
13. …but only ONE sum of degrees: Σk(U) = Σk(V) = m = 13
14. …and two average degrees (13/6 vs 13/5)

**Part 3 — The affiliation matrix (~5)**
15. Bipartite graph → affiliation matrix: rectangular R×C, fill cell-by-cell (Gabriela's row worked first, like the Google deck), then the full matrix table
16. Rectangular not square — |V₁| ≠ |V₂| allowed (contrast with adjacency matrix)
17. Row sums = number of memberships (person degree centrality, $C_P^{DEG} = \sum_j a_{ij}$)
18. Column sums = group size (group degree centrality, $C_G^{DEG} = \sum_i a_{ij}$) — direct echo of the new row/column-sums slides in matrix-operations
19. Interpretation: joining activity vs. group popularity (chapter's Gabriela/Minjoo framing adapted to this example)

**Part 4 — Transpose & multiplication setup (~5)**
20. The affiliation matrix transpose Aᵀ (5×6): same information, rows/columns swapped (side-by-side tables)
21. Matrix multiplication recap: conformability, inner/outer dimensions (A₄ₓ₂ ✕ B₂ₓ₃ vs A₄ₓ₃ ✕ B₂ₓ₃ diagrams as in Google deck)
22. Outer dimensions give product shape: $A_{m\times n} \times B_{q\times p} = C_{m\times p}$ iff n = q
23. Key fact: A × Aᵀ and Aᵀ × A are ALWAYS conformable; products are R×R and C×C
24. Why we care: two new matrices hiding in the affiliation matrix (chapter's motivation)

**Part 5 — Overlap matrices (~8)**
25. Co-membership matrix $O^P = A \times A^T$: setup slide (which row × which column)
26–27. Worked computation cell-by-cell, color-coded like matrix-multiplication deck: (Gabriela, Brandon) = 3, (Gabriela, Parker) = 0, then the full 6×6 result
28. Properties: off-diagonal = shared memberships; diagonal = total memberships (= row sums of A!); weighted, symmetric, undirected
29. Group overlap matrix $O^G = A^T \times A$: full 5×5 result (not commutative!)
30. Properties: off-diagonal = shared members; diagonal = group size (= column sums of A!)
31. Connecting overlap back to neighborhoods: cell = |N(i) ∩ N(j)| (chapter's "Overlapping Node Neighborhoods" section, using Gabriela/Minjoo from deck example)

**Part 6 — Projections, duality, applications (~7)**
32. From co-membership matrix back to a graph: weighted one-mode person-person projection (ggraph, edge width = weight)
33. From group overlap matrix back to a graph: group-group projection
34. The duality of persons and groups (Breiger 1974; Bonacich 1991): people connected via groups, groups connected via people; peripheral people ↔ peripheral groups
35. Application 1 — collaboration networks: scientists × papers → co-authorship; predicting future collaborations (Google deck's Scientist 7 / Paper 6 teaser)
36. Application 2 — product choice: people × movies → genre overlap networks → recommendation systems
37. Summary/glossary: affiliation network, bipartite graph, affiliation matrix, transpose, co-membership matrix, group overlap matrix, duality

## Technical conventions (from existing matrix decks)
- YAML identical to `matrix-operations.qmd` (revealjs, ucla-theme.css, 1280×720, scrollable: true, min-scale 0.2)
- Setup chunk: ggraph, tidygraph, igraph, dplyr, kableExtra; build the bipartite graph from the fixed edge list and `as_incidence_matrix`
- Bipartite layout: two-column manual layout (people left, groups right) matching the Google deck; node shapes/colors distinguishing modes
- Tables via `kbl()` + `column_spec(1, bold = TRUE)` + `font_size = 18`; worked cells color-coded with `\color{red}{...}` in display math
- All figures generated with ggraph (square fig-width/fig-height); no external images needed
- No arrows anywhere (affiliation is undirected) — the parallel-edges rule doesn't bite
- Bibliography: cite breiger74, bonacich91, faust97, mizruchi83 where the deck names the ideas (networks.bib already has these keys — verify before use)

## Verification
1. `quarto render slides/affiliation-networks.qmd` — no errors, no `Div unclosed` warnings
2. Overflow QA with the cached headless-Chrome setup in `$PA_SCRATCH_DIR/qa` (measure.mjs pattern): 0 scrolling slides at 1280×720; split/shrink per the established fix hierarchy if needed
3. Cross-check every computed table/vector against R (rowSums, colSums, `%*%`) before finalizing
4. Update project memory AGENTS.md slide inventory table with the new deck

## Files touched
- `slides/affiliation-networks.qmd` (new)
- `AGENTS.md` (memory: add deck to slide inventory)
- Nothing else; `_quarto.yml` and CI need no changes (CI globs `slides/*.qmd`)
