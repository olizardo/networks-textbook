# Plan: Refactor Structural Holes Slide Deck (Live Plots, Gould & Fernandez Typologies, and Obstfeld Process Matrix)

## Goal
Optimize `slides/structural-holes.qmd` by converting static diagrams into beautifully styled, live-rendered R `ggraph` network plots (with exact node/text scaling and coordinate boundaries to prevent horizontal/vertical cropping), and expanding the deck with detailed, step-by-step slides covering the **Gould & Fernandez Brokerage Roles** and **Obstfeld's Process Orientations**, incorporating the $2 \times 3$ decoupling matrix from his 2014 paper, with all key concepts bolded.

## Detailed Steps

### 1. Define Live R Graph Renderings (To Prevent Cropping)
We will add a Quarto setup chunk at the top of `slides/structural-holes.qmd` to load libraries (`ggraph`, `tidygraph`, `igraph`, `ggplot2`, `dplyr`) and define manual layouts with precise coordinate boundaries:
*   **Structural Hole Visual**:
    - Group A (cohesive on the left, blue nodes), Group B (cohesive on the right, green nodes), and the Broker (bridging them in the middle, red node).
    - Scaled to `size = 14`, text `size = 7`, and explicit coordinate bounds `coord_cartesian(xlim = c(-2.5, 2.5), ylim = c(-1.0, 1.0), clip = "off")` to prevent any cropping.
*   **Gould & Fernandez Brokerage Roles**:
    - Define a modular R plotting function `plot_brokerage(node_groups, title)` that draws a uniform directed V-shape: $A \rightarrow B \rightarrow C$, where $B$ is the Broker.
    - Node size set to `size = 14`, text to `size = 7`.
    - Retract directed arrowheads using `arrow = arrow(length = unit(3, 'mm')), end_cap = circle(7.5, 'mm')` to prevent overlapping with the node boundaries.
*   **Obstfeld Process Diagrams**:
    - Draw R-rendered directed triads illustrating:
      - **Conduit**: $A \xrightarrow{\text{info}} B \xrightarrow{\text{info}} C$ (direct transmission flow, no $A-C$ tie).
      - **Tertius Gaudens**: $A \leftarrow B \rightarrow C$ (Ego separates or exploits, no $A-C$ tie).
      - **Tertius Iungens**: A closed triad $A-B-C$ with a newly forged direct tie $A-C$ highlighted in red to represent the joining action.

### 2. Expand Gould & Fernandez Section Step-by-Step (Across 6 Slides)
We will split the current single slide into 6 distinct, high-pedagogy slides:
- **Gould & Fernandez: Typology of Brokerage Roles (Intro)**: Bolds key concepts like **membership partitioning**, **directed transaction networks**, and **structures of mediation**.
- **1. Coordinator (Within-Group)**: Bolds key concepts like **internal coordination** and **local integration** (all 3 nodes in Group 1; live R plot of a Coordinator triangle).
- **2. Itinerant Broker / Consultant (Within-Group)**: Bolds key concepts like **external consulting** and **impartial intermediation** (Source/Target in Group 1, Broker is outsider in Group 2; live R plot).
- **3. Gatekeeper (Between-Group)**: Bolds key concepts like **resource gatekeeping** and **inward boundary spanning** (Source in Group 1, Broker/Target in Group 2; Broker controls inward flow).
- **4. Representative (Between-Group)**: Bolds key concepts like **external representation** and **outward boundary spanning** (Source/Broker in Group 1, Target in Group 2; Broker acts as spokesperson).
- **5. Liaison (Between-Group)**: Bolds key concepts like **cross-boundary mediation** and **unaffiliated intermediation** (Source, Broker, Target all in three completely different groups; live R plot).

### 3. Expand Obstfeld's Brokerage Process Section Step-by-Step (Across 5 Slides)
We will split the current single slide into 5 highly detailed slides with key concepts bolded:
- **Brokerage as a Process: Action vs. Structure**: Introduces Obstfeld, Borgatti, and Davis's (2014) action-oriented view, explaining that structural holes are merely **opportunities** requiring **motivation and social action**. Bolds concepts like **action-structure decoupling**.
- **1. The Conduit Process**: Discusses transferring information to solve problems through synthesis, even without a structural hole. Shows live R diagram.
- **2. The Tertius Gaudens Orientation**: Discusses the "third who benefits/enjoys" (Simmel), where the broker actively maintains gaps, separates alters, or cultivates competition/conflict ("divide and rule") to exploit information asymmetry. Shows live R diagram.
- **3. The Tertius Iungens Orientation**: Discusses the "third who joins" (Obstfeld 2005), where the broker actively connects disconnected alters, closing structural holes to forge trust, closure, and direct collaboration. Shows live R diagram.
- **4. Decoupling Action from Structure: The Obstfeld Matrix**: Introduces the $2 \times 3$ decoupling matrix from Obstfeld et al. (2014) as a beautifully formatted Markdown table, bolding key concepts for each cell:
  - *Conduit/Open*: **Information Transfer**.
  - *Conduit/Closed*: **Facilitated Synthesis**.
  - *Gaudens/Open*: **Arbitrage & Separation**.
  - *Gaudens/Closed*: **Divide et Impera (Divide & Rule)**.
  - *Iungens/Open*: **Introducing Alters**.
  - *Iungens/Closed*: **Coordinated Collaboration**.

## Verification Plans
- Run standalone Quarto render (`quarto render slides/structural-holes.qmd` with `_quarto.yml` temporarily renamed to prevent book project errors) to ensure:
  - The document renders with `Exit code: 0`.
  - All LaTeX equations, R code chunks, and HTML kable tables compile cleanly with no formatting or parsing warnings.
