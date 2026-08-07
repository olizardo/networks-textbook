# Plan: Implement Suggested Additions to Structural Balance Lesson

We will enhance the chapter `lesson-theory-balance-struct.qmd` to make it more mathematically complete and consistent with Wasserman and Faust (1994) Chapter 6. 

This will be accomplished by:
1. Moving the chapter beyond the limitation of "complete" signed graphs to cover general (incomplete) signed graphs.
2. Integrating a section on **Checking for Balance with Matrix Powers** including executable R code showing how to inspect the diagonal of $\mathbf{X}^p$.
3. Adding a section on **Measuring Partial Balance** using the *Cycle Index* and *Line Index* of balance.
4. Enhancing the **Clusterability** section to explicitly state Davis's general cycle-based theorem (no cycle has exactly one negative edge) and distinguish between complete and incomplete graphs.
5. Integrating **Directed Structural Balance** using Cartwright and Harary's concepts of *semipaths* and *semicycles*, including a beautiful `ggraph` visualization of directed balanced/unbalanced triads (reused from the deleted chapter).
6. Integrating **Ranked Clusterability** (Davis & Leinhardt) to serve as a conceptual bridge between horizontal balance and vertical status hierarchies.

---

## Detailed Implementation Plan

### 1. Generalizing to Incomplete Graphs
- **Where:** Insert as a new subsection/clarification inside the "Fundamental Theorem" section.
- **Content:** Clarify that Cartwright and Harary's (1956) Structure Theorem holds for *all* signed graphs (complete or incomplete). A signed graph is balanced if and only if it can be partitioned into two factions with only positive ties within and only negative ties between.

### 2. Checking for Balance with Matrix Powers
- **Where:** Insert as a new section `## Checking for Balance with Matrix Powers` right after "Paths in a Balanced Signed Graph".
- **Content:**
  - Explain the mathematical property that in a balanced graph, the diagonals of $\mathbf{X}^p$ (for $p = 1, \dots, g$) must be non-negative.
  - Provide an executable R code block demonstrating how to represent a signed adjacency matrix and loop through its powers to check the diagonal entries.

### 3. Measuring Partial Balance
- **Where:** Insert as a new section `## Measuring Partial Balance: Indices of Balance` right after the Matrix Powers section.
- **Content:**
  - Introduce the **Cycle Index of Balance** ($PC / TC$) and explain its range ($0$ to $1$).
  - Introduce the **Line Index of Balance** (the minimum number of edge signs that must be changed or edges removed to achieve complete balance).

### 4. Enhancing Clusterability with General Theorems
- **Where:** Edit the existing `## From Balance to Clustering` section.
- **Content:**
  - State Davis's (1967) Theorem 6.1 for general (incomplete) signed graphs: a signed graph has a clustering iff it contains no cycles of any length with exactly one negative edge.
  - Contrast this with Davis's Theorem 6.2 for complete signed graphs: where a unique clustering is guaranteed and can be verified by checking only cycles of length 3 (triads).

### 5. Integrating Directed Structural Balance & Semicycles
- **Where:** Insert as a new section `## Directed Structural Balance and Semicycles` after the Clusterability section.
- **Content:**
  - Explain why standard directed cycles are too restrictive for structural balance theory.
  - Define Cartwright and Harary's concepts of **semipaths** and **semicycles** (ignoring arc directions).
  - State the definition: a signed digraph is balanced iff all of its semicycles are positive.
  - Add an executable R block plotting a balanced and unbalanced directed triad side-by-side or stacked using `ggraph` (reusing the high-quality visualization code from the deleted `lesson-theory-balance-directed.qmd` file).

### 6. Integrating Ranked Clusterability
- **Where:** Insert as a new section `## Ranked Clusterability: Bridging Balance and Hierarchy` after the Directed Balance section.
- **Content:**
  - Explain how Davis and Leinhardt (1972) extended clusterability to directed networks to represent hierarchical social structures.
  - Define ranked clusterability: positive ties point within clusters or point "up" the status hierarchy, while negative or null ties point down or across unranked groups.
