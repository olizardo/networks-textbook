# Plan: Refactor Matrix Operation Slides (Math Splits, Node Resizing, and Step-by-Step Dyad/Power Census)

## Goal
Optimize `slides/matrix-operations.qmd` by splitting dense mathematical slides to prevent vertical scrolling, resizing and styling node graphs to avoid horizontal/vertical cropping, retracting directed arrowheads, and formatting the Dyad Census slides (Mutuals, Asymmetrics, and Nulls) and Matrix Powers slides ($\mathbf{P}^2$ and $\mathbf{P}^3$) to show exactly how their cells emerge step-by-step from element-wise and standard arithmetic operations on the input matrices.

## Detailed Steps

### 1. Reduce Node Sizes and Fix Layout Clipping in Network Graphs
- Update the default node size of all 6-node circular network graphs (Parties, Games, Sum, Complement, Hadamard, Transpose, Mutuals, Asymmetrics, Nulls, Squared Matrix, and Cubed Matrix) in R code blocks:
  - Reduce `geom_node_point(size = 20)` to `size = 14`.
  - Reduce `geom_node_text(size = 10)` to `size = 7` to keep labels legible and perfectly centered within the smaller circles.
  - Set explicit coordinate limits `coord_cartesian(xlim = c(-1.3, 1.3), ylim = c(-1.3, 1.3), clip = "off")` on all plots to guarantee that no nodes or edges are clipped horizontally or vertically.

### 2. Retract Directed Arrows on the Matrix Transpose Slide
- For the directed graph `p_adir` in the Transpose slide:
  - Reduce node size to `size = 14` and text size to `size = 7`.
  - Adjust arrowheads to prevent them from slipping under the node circles by setting a smaller arrow tip and a wider padding offset:
    `arrow = arrow(length = unit(3, 'mm')), end_cap = circle(7.5, 'mm')`
  - This retracts the arrows beautifully, stopping them cleanly outside the node boundaries.

### 3. Split Element-Wise Slides into "Setup" and "Calculation" (To Avoid Scrolling)
To prevent excessive vertical scrolling, we will split the following slides into two separate, bite-sized slides:
- **Matrix Addition ($\mathbf{P} + \mathbf{G}$)**:
  - **Slide 1: Setup**: Explains addition conceptually and shows the original matrices $\mathbf{P}$ and $\mathbf{G}$ side-by-side as a LaTeX sum equation.
  - **Slide 2: Calculation**: Shows the cell-by-cell addition step-by-step in LaTeX ($p_{ij} + g_{ij}$) and outputs the final resulting matrix.
- **Subtracting a Number ($\mathbf{1} - \mathbf{P}$)**:
  - **Slide 1: Setup**: Explains graph complement subtraction conceptually and displays the $1 - \mathbf{P}$ LaTeX setup.
  - **Slide 2: Calculation**: Traces the cell-by-cell subtraction step-by-step in LaTeX ($1 - p_{ij}$) and displays the final resulting complement matrix.
- **Hadamard Product ($\mathbf{P} \circ \mathbf{G}$)**:
  - **Slide 1: Setup**: Explains relational intersection and displays the $\mathbf{P} \circ \mathbf{G}$ LaTeX setup.
  - **Slide 2: Calculation**: Traces the cell-by-cell element-wise multiplication in LaTeX ($p_{ij} \times g_{ij}$) and displays the final resulting multiplex intersection matrix.

### 4. Format and Split Dyad Census Slides to Show Step-by-Step Arithmetic Emergence
Just like the other basic arithmetic slides, we will restructure and split each of the Dyad Census slides (Mutuals, Asymmetrics, Nulls) into two distinct, high-pedagogy slides:
- **Mutuals ($\mathbf{M} = \mathbf{A} \circ \mathbf{A}^T$)**:
  - **Slide 1: Setup & Formula**: Shows the formula and how $\mathbf{A} \circ \mathbf{A}^T$ is set up as a matrix product of the directed adjacency matrix and its transpose.
  - **Slide 2: Detailed Calculation**: Shows the cell-by-cell multiplication step-by-step in LaTeX ($a_{ij} \times a^T_{ij}$) to illustrate exactly how the mutuals matrix emerges. Shows the final $\mathbf{M}$ table, counts $N_M$, and displays the mutual ties graph with resized nodes.
- **Asymmetrics ($\mathbf{S} = \mathbf{A} \circ (\mathbf{1} - \mathbf{A}^T)$)**:
  - **Slide 1: Setup & Formula**: Shows the formula and how $\mathbf{A} \circ (\mathbf{1} - \mathbf{A}^T)$ is set up as a matrix product.
  - **Slide 2: Detailed Calculation**: Shows the cell-by-cell multiplication in LaTeX ($a_{ij} \times (1 - a^T_{ij})$) to illustrate exactly how unreciprocated ties emerge. Shows the final $\mathbf{S}$ table, counts $N_A$, and displays the asymmetric ties graph with resized nodes.
- **Nulls ($\mathbf{N} = (\mathbf{1} - \mathbf{A}) \circ (\mathbf{1} - \mathbf{A}^T)$)**:
  - **Slide 1: Setup & Formula**: Shows the formula and how $(\mathbf{1} - \mathbf{A}) \circ (\mathbf{1} - \mathbf{A}^T)$ is set up as a matrix product.
  - **Slide 2: Detailed Calculation**: Shows the cell-by-cell multiplication in LaTeX ($(1 - a_{ij}) \times (1 - a^T_{ij})$) to illustrate exactly how completely disconnected dyads emerge. Shows the final $\mathbf{N}$ table, counts $N_N$, and displays the reference directed graph with resized nodes.

### 5. Format and Split Matrix Powers Slides using the 6-Node Reference Graph P
To keep the presentation highly cohesive and pedagogically effective, we will reconfigure the Matrix Powers slides to use the same step-by-step arithmetic formatting using the **6-node reference graph $\mathbf{P}$ ("Parties With")**:
- **Reference Adjacency Matrix ($\mathbf{P}$)**:
  $$\mathbf{P} = \begin{pmatrix} 0 & 1 & 1 & 0 & 1 & 0 \\ 1 & 0 & 1 & 1 & 0 & 0 \\ 1 & 1 & 0 & 1 & 1 & 1 \\ 0 & 1 & 1 & 0 & 1 & 0 \\ 1 & 0 & 1 & 1 & 0 & 1 \\ 0 & 0 & 1 & 0 & 1 & 0 \end{pmatrix}$$
- **Walks of Length 2 ($\mathbf{P}^2 = \mathbf{P} \times \mathbf{P}$)**:
  - **Slide 1: Setup & Connection**: Explains the connection between walks of length 2 and transpose multiplication for symmetric graphs ($\mathbf{P} \times \mathbf{P} = \mathbf{P} \times \mathbf{P}^T$). Shows the full multiplication setup as a LaTeX product.
  - **Slide 2: Tracing Cell $p^2_{\text{A, C}}$ (Common Neighbors)**: Shows the explicit row-by-column multiplication step-by-step in LaTeX to illustrate how $p^2_{\text{A, C}} = 2$ walks of length 2 emerge from Node A and Node C's row and column combinations.
    - Row 1 of $\mathbf{P}$: $\{0, 1, 1, 0, 1, 0\}$
    - Column 3 of $\mathbf{P}$: $\{1, 1, 0, 1, 1, 1\}$
    - $$p^2_{\text{A, C}} = (0 \times 1) + (1 \times 1) + (1 \times 0) + (0 \times 1) + (1 \times 1) + (0 \times 1) = 0 + 1 + 0 + 0 + 1 + 0 = \mathbf{2}$$
    - Details the 2 walks: $A \rightarrow \mathbf{B} \rightarrow C$ and $A \rightarrow \mathbf{E} \rightarrow C$.
  - **Slide 3: Tracing Cell $p^2_{\text{C, C}}$ (Node Degree)**: Shows the explicit row-by-column multiplication step-by-step in LaTeX to illustrate how diagonal elements represent the node degree ($p^2_{\text{C, C}} = 5$).
    - Row 3 of $\mathbf{P}$: $\{1, 1, 0, 1, 1, 1\}$
    - Column 3 of $\mathbf{P}$: $\{1, 1, 0, 1, 1, 1\}$
    - $$p^2_{\text{C, C}} = (1 \times 1) + (1 \times 1) + (0 \times 0) + (1 \times 1) + (1 \times 1) + (1 \times 1) = 1 + 1 + 0 + 1 + 1 + 1 = \mathbf{5}$$
  - **Slide 4: Resulting $\mathbf{P}^2$ Matrix**: Shows the completed squared matrix as a kable table side-by-side with the 6-node network graph (resized to `size = 14`).
- **Walks of Length 3 ($\mathbf{P}^3 = \mathbf{P}^2 \times \mathbf{P}$)**:
  - **Slide 1: Setup**: Explains walks of length 3 and diagonal elements counting triangles. Displays the full multiplication setup as a LaTeX product of $\mathbf{P}^2$ and $\mathbf{P}$.
  - **Slide 2: Tracing Diagonal Cell $p^3_{\text{C, C}}$ (Triangles)**: Shows the explicit row-by-column multiplication step-by-step in LaTeX to illustrate how the value of $10$ emerges, and how dividing by 2 yields exactly 5 triangles containing Node C:
    - Row 3 of $\mathbf{P}^2$: $\{2, 2, 5, 2, 3, 1\}$
    - Column 3 of $\mathbf{P}$: $\{1, 1, 0, 1, 1, 1\}$
    - $$p^3_{\text{C, C}} = (2 \times 1) + (2 \times 1) + (5 \times 0) + (2 \times 1) + (3 \times 1) + (1 \times 1) = 2 + 2 + 0 + 2 + 3 + 1 = \mathbf{10}$$
    - Triangles Containing C: $\text{Triangles}(C) = p^3_{C, C} / 2 = 10 / 2 = \mathbf{5}$ triangles.
    - Explicitly lists the 5 triangles: $\{C,A,B\}$, $\{C,A,E\}$, $\{C,B,D\}$, $\{C,D,E\}$, and $\{E,F,C\}$.
  - **Slide 3: Resulting $\mathbf{P}^3$ Matrix**: Shows the completed cubed matrix as a kable table side-by-side with the 6-node network graph.
  - **Slide 4: Weighted Graph Representation**: Displays the dense subgroups using thicker edges representing the weights of $\mathbf{P}^3$ to visualize cliques and subgroups.

## Verification Plans
- Run standalone Quarto render (`quarto render slides/matrix-operations.qmd` with `_quarto.yml` temporarily renamed to prevent book project errors) to ensure:
  - The document renders with `Exit code: 0`.
  - All LaTeX equations, R code chunks, and HTML kable tables compile cleanly with no formatting or parsing warnings.
