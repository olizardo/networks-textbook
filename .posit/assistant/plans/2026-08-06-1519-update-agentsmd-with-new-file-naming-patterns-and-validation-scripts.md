# Plan: Create lesson-theory-balance-directed.qmd and Integrate into Book

This plan details the creation of the new chapter `lesson-theory-balance-directed.qmd` focusing on Directed Structural Balance, drawing on `WandF.txt` and `lesson-theory-balance-struct-adv.qmd`.

## Chapter Outline

1. **Title and Introduction**:
   - Title: `Directed Structural Balance`
   - Introduction: Sentiment relations are typically directed. Extend structural balance from undirected graphs (Cartwright-Harary) to signed directed graphs (digraphs).

2. **Core Concepts (Wasserman & Faust Section 6.1.2)**:
   - **Directed Paths & Cycles**: Why they are too restrictive (we can feel psychological tension even if arrows don't form a directed cycle).
   - **Semipaths & Semicycles**: Definitions of semipaths and semicycles (ignoring arrow directions, caring only about edge existence).
   - **Definition of Directed Balance**: A signed digraph is balanced if and only if all of its semicycles are balanced (product of signs is positive / even number of negative signs).

3. **Graphical Examples (R/ggraph/igraph)**:
   - **Figure 1**: Unbalanced Signed Digraph (Wasserman & Faust Figure 6.4, showing tension).
     - Nodes: $A, B, C$
     - Arcs: $A \rightarrow C$ (+), $A \rightarrow B$ (+), $C \rightarrow B$ (-)
   - **Figure 2**: Balanced Signed Digraph.
     - Nodes: $A, B, C$
     - Arcs: $A \rightarrow B$ (+), $C \rightarrow B$ (-), $A \rightarrow C$ (-)

4. **Checking for Balance in Signed Digraphs**:
   - Describe the matrix algebraic method using the valency matrix approach of Harary, Norman, and Cartwright (1965).

5. **Ranked Clusterability**:
   - Briefly summarize how directed balance connects to Davis and Leinhardt's ranked clusterability and status hierarchies.

## Steps to Execute

1. **Create `lesson-theory-balance-directed.qmd`**:
   - Write the complete contents including the R code blocks to generate the required figures.

2. **Integrate into `_quarto.yml`**:
   - Add `lesson-theory-balance-directed.qmd` in the `chapters` section under `part: "Network Theory: Balance and Hierarchy"`.
   - Place it right after `lesson-theory-balance-struct.qmd` and before `lesson-theory-balance-struct-adv.qmd`.

3. **Run Validation Checks**:
   - Run `python3 check_book_refs.py` and `python3 check_book_citations.py` to ensure all cross-references and citations are valid.
