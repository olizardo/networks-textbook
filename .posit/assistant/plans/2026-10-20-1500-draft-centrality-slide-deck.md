# Plan: Draft `slides/centrality.qmd`

## Goal
Create a Reveal.js deck "Centrality in Networks" pairing with chapters 18–21 (`18-sna-degree-centrality`, `19-sna-closeness`, `20-sna-betweenness`, `21-sna-bigthree`), merging the book chapters with the structure and worked examples of the user's `Centrality.pptx` (117 incremental slides; text extracted to `$PA_SCRATCH_DIR/cent/slides_text.txt`). Intended to replace the Google Drive deck linked on Canvas (item 8300729, "Slides: Centrality in Networks", Week 3 module 1938343).

## Confirmed decisions
- **Anchor examples**: reconstruct the pptx's exact graphs in R from its printed adjacency matrices and verify every printed number:
  - 19-node undirected graph (a–s): degrees `3 4 2 5 3 4 5 4 4 7 3 3 3 3 2 3 2 1 1`; closeness row-sums `74 62 54 60 63 61 49 42 41 44 59 57 56 50 60 50 71 59 88` (C = 18/rowsum → i = 0.44 top, s = 0.20 bottom); betweenness ranking h 88.1, i 81.5, j 66.5, g 53, m 32, q 17, f 10.2, c 9, d 5.2, n 5, p 5, b 3.8, l 1.5, a 0.6, k 0.5, e/o/r/s 0.
  - 8-node digraph (v1–v8): outdegree `2 2 2 3 1 2 1 1`, indegree `2 1 2 3 3 1 1 1`; closeness row-sums `14 16 13 12 18 16 19 17` → v4 top (0.58); weakly-connected variant (edges removed so v2/v7 unreachable, v5 reaches nobody) → harmonic row-sums `2.33 4.08 3.83 2.50 0 2.50 2.92 2.00` → v2 top (0.58), v5 = 0.
  - If any pptx number fails verification, use the R-computed value and flag it (the affiliation deck already caught one pptx error).
- **Stress centrality**: include (2–3 slides) as the stepping stone to betweenness, per chapter 20 (Shimbel 1953), computed on the 19-node graph with `sna::stresscent`.
- **Length**: ~45–55 slides, repo-style `incremental: false` with selective `. . .` builds, inline author-year citations (no quarto `[@]`, matching deck convention).

## Deck outline (~50 slides, 6 parts)

**Part 1 — What is centrality? (~4)**
1. Levels of analysis orientation (individual highlighted; "the first part of the course follows this organization")
2. Sociological concepts behind centrality: status, popularity, influence, brokerage, power — and the three-step-shuffle caution that concepts ≠ metrics (ch 21)
3. The three sources of "network goods": incident edges; geodesic lengths as end node; proportion of geodesics as inner node (Borgatti & Everett 2006) + the **more/more principle** (Freeman 1979)
4. A centrality metric = summary index → full ranking of nodes; "network goods vs. bads" note (Borgatti 2005)

**Part 2 — Degree centrality (~10)**
5. Definition $C_i^{DEG} = \sum_j a_{ij}$; = cardinality of neighbor set (ch 18)
6. The 19-node example graph (ggraph)
7. Its adjacency matrix (19×19 kbl, small font)
8. Row sums = degrees; highlight node j (k = 7) as the most central
9. Full degree ranking
10. Normalized degree $C/(N-1)$ (Freeman 1979) + the chapter's high-school example (20 friends in a 1,000-student vs. 100-student school)
11. Directed: outdegree $C_i^{OUT}$ (rows) and indegree $C_j^{IN}$ (columns) definitions
12. The 8-node digraph + adjacency matrix
13. Outdegree and indegree vectors (row sums / column sums)
14. Two separate rankings; sociability vs. status interpretation (ch 18); normalized versions

**Part 3 — Closeness centrality (~12)**
15. Idea: reach all others via short geodesics (Bavelas 1950; Sabidussi 1966); highlight max-closeness node i in the 19-node graph
16. Worked example: build SP(i–x) list across two slides (partial → complete, 18 distances)
17. $C^{CLOS}(i) = (N-1)/\sum_j d_{ij} = 18/41 = 0.44$
18. Geodesic distance matrix (19×19, small font, one slide)
19. Row sums = **farness** (74…88); node s farthest
20. Reverse + normalize: divide N−1 by each row sum → closeness column
21. Full closeness ranking; **punchline**: i wins closeness without having the highest degree — the three centralities disagree
22. Sociological application (ch 19): seed an innovation with the high-closeness node — or a disease (network bads)
23. Directed, strongly connected: same v1–v8 digraph; asymmetric distance matrix; row sums; normalized; ranking (v4 = 0.58 top)
24. Directed, weakly connected: distance matrix has Inf cells; row sums blow up to Inf; closeness undefined
25. **Harmonic centrality** (Beauchamp 1965; Boldi & Vigna 2014): sum of inverse distances, $1/\infty = 0$; inverse matrix, row sums, normalized, ranking (v2 = 0.58, v5 = 0)

**Part 4 — Stress and betweenness (~9)**
26. Inner nodes and gatekeeping (Marsden 1983; Gould & Fernandez 1989); highlight max-betweenness node h; h sits on SPs g–i, p–c, k–r (pptx walkthrough, one slide)
27. **Stress centrality** $C^{STRESS}_k = \sum\sum n_{i(k)j}$ (Shimbel 1953): counts raw inner-node appearances; computed table for the 19-node graph
28. Stress vs. betweenness: counting vs. proportion (ch 20's motivation)
29. **Relative (pairwise) betweenness**: worked example — d relative to (h, a): list the 4 SPs h→a, d on 1 → $p_{h(d)a} = 1/4 = 0.25$ (pair dependency, Freeman 1980)
30. Definition $C_k^{BET} = \sum_{i\neq k}\sum_{j\neq k} g_{i(k)j}/g_{ij}$ (Freeman 1977; Anthonisse 1971)
31. Full betweenness ranking for the 19-node graph (h, i on top); zero-betweenness nodes (e, o, r, s) stand on no SPs
32. Closeness vs. betweenness pick different winners — analytically distinct (ch 20)

**Part 5 — Star graph and centralization (~5)**
33. The star graph (order 7, ch 21 fig)
34. All three big centralities maximized at the center: degree $n-1$; closeness via length-1 paths; betweenness on every length-2 SP (Freeman 1979) + the centralities table (ch 21)
35. **Graph centralization**: compare the observed network to the star of the same order (Freeman 1979)
36. Worked: 5-node observed graph (degrees 3,4,3,3,3) vs. star: Σ(max − k) = 4 vs. 12; centralization = 4/12 ≈ 0.33; normalize by $(n-1)(n-2)$
37. Closing thought: centralization as a graph-level summary of the centrality distribution

**Part 6 — Wrap (~2)**
38. Glossary: centrality metric, degree/indegree/outdegree centrality, normalization, geodesic distance, closeness, farness, harmonic centrality, stress centrality, pair dependency, betweenness, star graph, graph centralization
39. Summary: big three, more/more principle, they disagree, star graph unifies them

## Technical conventions
- YAML/format identical to other decks (ucla-theme.css, 1280×720, scrollable, incremental: false)
- Setup chunk builds both graphs from hardcoded adjacency matrices (from the pptx), plus the weak variant edge list; compute all vectors in R (rowSums/colSums/`distances()`/`betweenness()`/`stresscent()`) so tables can't drift
- 19×19 matrices: kbl at reduced font (~11) on their own slides; verify no overflow in QA (this is the main overflow risk)
- ggraph figures with square fig dims; node labels; highlighted node in red (following ch figure style)
- No arrows except the directed-graph figures (which use `geom_edge_parallel` per repo rule)

## Verification & delivery
1. R verification script: every number quoted above vs. computed values
2. `quarto render slides/centrality.qmd` — clean, no pandoc warnings
3. Fragment-aware overflow QA (chrome cached in `$PA_SCRATCH_DIR/qa`): 0 scrolling slides
4. Update AGENTS.md slide inventory
5. Commit + push to main; wait for Pages deploy; verify the URL 200s
6. Swap Canvas item 8300729 "Slides: Centrality in Networks" → `https://olizardo.github.io/networks-textbook/slides/centrality` (same pattern as the affiliation swap)

## Files touched
- `slides/centrality.qmd` (new)
- `AGENTS.md` (inventory row)
- Canvas module item 8300729 (external_url)
