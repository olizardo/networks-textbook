# Plan: Align Matrix Operation Slides with Google Presentation and Add Dyad Census

## Goal
Update the matrix operations slides in `slides/matrix-operations.qmd` to align with the provided Google Slides presentation (https://docs.google.com/presentation/d/10ufRREn6h46pCGBTLbySf05U8o0D475iZeUwSEgVRuc/edit?usp=sharing).
This involves:
1. Updating Part 1 (Element-wise operations) of `slides/matrix-operations.qmd` to use the exact 6x6 symmetric matrices for "Parties With" ($P$) and "Plays Games With" ($G$) from the Google Slides.
2. Replacing the absolute subtraction $|H-C|$ example with a "Subtracting a Number from a Matrix" ($1-P$) example representing the Graph Complement ("Does Not Party With"), matching Slide 16-19.
3. Adding a new section on Matrix Transpose ($A^T$) with the 6x6 directed adjacency matrix $A$ from Slide 21-22.
4. Adding a new section on the **Dyad Census of a Directed Graph** using matrix operations and the Hadamard product:
   - Defining Mutual ($M$), Asymmetric ($S$), and Null ($N$) dyads using MAN terminology.
   - Detailing the step-by-step equations and matrices:
     - Mutual: $M = A \circ A^T$ (and $N_M = \sum M_{ij} / 2$)
     - Asymmetric: $S = A \circ (1 - A^T)$ (and $N_S = \sum S_{ij}$)
     - Null: $N = (1-A) \circ (1-A^T)$ (and $N_N = \sum N_{ij} / 2$)
   - Showing the identity check: $N_M + N_S + N_N = \frac{n(n-1)}{2}$ (which equals 15 for $n=6$) and $M + S + N = \mathbf{J} - \mathbf{I}$.
5. Incorporating Graph Reciprocity ($R = \frac{N_M}{N_M + N_S}$) on the same 6x6 example (resulting in $R = 0.20$), while **excluding Graph Connectedness or Graph Hierarchy** as they already exist in other slides (like `slides/matrix-advanced.qmd`).
6. Aligning the Matrix Powers ($A^2$ and $A^3$) examples in standard multiplication to use the exact 5-node undirected house/kite graph from Slides 109-122.

## Step-by-Step Implementation Details

### Step 1: Update R Setup Chunk in `slides/matrix-operations.qmd`
*   Create the 6x6 adjacency matrices $P$ ("Parties With") and $G$ ("Plays Games With") as defined in Slide 10:
    ```r
    P <- matrix(c(
      0, 1, 1, 0, 1, 0,
      1, 0, 1, 1, 0, 0,
      1, 1, 0, 1, 1, 1,
      0, 1, 1, 0, 1, 0,
      1, 0, 1, 1, 0, 1,
      0, 0, 1, 0, 1, 0
    ), nrow=6, byrow=TRUE, dimnames=list(LETTERS[1:6], LETTERS[1:6]))

    G <- matrix(c(
      0, 1, 0, 0, 1, 1,
      1, 0, 1, 0, 0, 0,
      0, 1, 0, 1, 0, 0,
      0, 0, 1, 0, 1, 1,
      1, 0, 0, 1, 0, 1,
      1, 0, 0, 1, 1, 0
    ), nrow=6, byrow=TRUE, dimnames=list(LETTERS[1:6], LETTERS[1:6]))
    ```
*   Create the 6x6 directed adjacency matrix $A$ for the Transpose and Dyad Census from Slide 21:
    ```r
    A_dir <- matrix(c(
      0, 0, 1, 0, 1, 0,
      1, 0, 1, 1, 0, 0,
      1, 0, 0, 1, 1, 0,
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 1, 0, 1,
      0, 0, 0, 1, 1, 0
    ), nrow=6, byrow=TRUE, dimnames=list(LETTERS[1:6], LETTERS[1:6]))
    ```
*   Create the 5-node undirected graph for matrix powers $A^2, A^3$ from Slide 109:
    ```r
    A_undir_5 <- matrix(c(
      0, 1, 0, 0, 0,
      1, 0, 1, 0, 0,
      0, 1, 0, 1, 1,
      0, 0, 1, 0, 1,
      0, 0, 1, 1, 0
    ), nrow=5, byrow=TRUE, dimnames=list(letters[1:5], letters[1:5]))
    ```
*   Generate layouts and plots using `ggraph` and `tidygraph` for:
    - Parties With ($P$)
    - Plays Games With ($G$)
    - Directed Graph ($A\_dir$) and its transpose
    - 5-node undirected graph

### Step 2: Refactor Part 1 (Element-wise Operations)
*   **Combining Social Relations**: Introduction slide.
*   **Adjacency Matrices: $P$ and $G$**: Display $P$ and $G$ with their respective network plots side-by-side using `kableExtra` and `patchwork`.
*   **Matrix Addition ($P + G$)**: Show the step-by-step element-wise math and display the result. Explain that 1 = uniplex and 2 = multiplex.
*   **Visualizing Addition**: Side-by-side table of $P+G$ and plot (weighted graph with uniplex/multiplex edge colors).
*   **Subtracting from a Matrix ($1 - P$)**: Explain how subtracting from 1 flips 1s and 0s (Graph Complement, "Does Not Party With"). Show the step-by-step math, resulting table, and plot.
*   **Element-wise Multiplication ($P \circ G$)**: Explain Hadamard product as extracting multiplex ties. Show step-by-step math, resulting table, and plot.

### Step 3: Insert Matrix Transpose Section
*   **The Matrix Transpose ($A^T$)**: Explain flipping rows and columns.
*   **Visualizing Transpose**: Display the directed adjacency matrix $A$ and its transpose $A^T$ side-by-side, highlighting how Row $i$ becomes Column $i$. Show the directed graph and its transposed counterpart.

### Step 4: Add Dyads and Dyad Census Section
*   **Types of Dyads in Directed Graphs**: Explain the three dyad types with the **MAN** mnemonic:
    - **M**utual: both directed edges present ($i \leftrightarrow j$).
    - **A**symmetric: only one directed edge present ($i \rightarrow j$ or $j \rightarrow i$).
    - **N**ull: neither edge present.
*   **Using Matrix Operations for the Dyad Census**: Introduce the dyad census concept.
*   **Mutual Dyads Matrix ($M = A \circ A^T$)**: Detail how multiplying $A$ by $A^T$ element-wise extracts only mutual dyads. Show the result matrix and formula for total count: $N_M = \frac{\sum M_{ij}}{2} = 2$.
*   **Asymmetric Dyads Matrix ($S = A \circ (1 - A^T)$)**: Detail how multiplying $A$ by $1-A^T$ element-wise extracts unreciprocated ties. Show the result matrix and formula for total count: $N_S = \sum S_{ij} = 8$.
*   **Null Dyads Matrix ($N = (1-A) \circ (1-A^T)$)**: Detail how multiplying $1-A$ by $1-A^T$ element-wise extracts disconnected dyads. Show the result matrix and formula for total count: $N_N = \frac{\sum N_{ij}}{2} = 5$.
*   **The Dyad Census Identity Check**:
    - Show that $N_M + N_S + N_N = 2 + 8 + 5 = 15$, which is exactly $\frac{n(n-1)}{2}$ for $n=6$.
    - Show that $M + S + N$ sums to the all-ones matrix minus the diagonal ($\mathbf{J} - \mathbf{I}$).
*   **Graph Reciprocity**:
    - Define graph reciprocity as $R = \frac{N_M}{N_M + N_S}$.
    - Show the calculation: $R = \frac{2}{2+8} = 0.20$ (20% of connected dyads are reciprocal).

### Step 5: Update Standard Multiplication & Matrix Powers
*   Keep the standard matrix multiplication and conformability rules sections.
*   Refactor the Matrix Powers section to use the 5-node undirected house/kite graph.
*   **Walks of Length 2 ($A^2$)**: Show how $A^2$ counts walks of length 2 (common neighbors) and how the diagonal equals the node degrees: $(1, 2, 3, 2, 2)$. Show the resulting matrix $A^2$.
*   **Walks of Length 3 ($A^3$)**: Show how $A^3$ counts walks of length 3, and how the diagonal divided by 2 counts triangles: $\text{Triangles}(i) = \frac{a^3_{ii}}{2}$. Show the resulting matrix $A^3$.

## Verification Plans
1. Check that the `.qmd` file compiles successfully without syntax or code errors.
2. Verify that all R chunks execute correctly and generate the exact networks shown in the Google Slides.
3. Validate that Graph Connectedness and Graph Hierarchy are NOT included in the file, keeping the focus on Reciprocity and Dyad Census.
