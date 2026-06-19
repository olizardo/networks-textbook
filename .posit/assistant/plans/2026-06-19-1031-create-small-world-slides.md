# Plan: Create Small World Phenomenon Slide Deck

We will create a brand-new slide deck dedicated to the **Small World Phenomenon** (`slides/small-world.qmd`). This deck will cover the graph-theoretic foundations, the classic empirical studies, and the core computational models, incorporating beautiful `ggraph` visualizations on multiple slides to illustrate these structures cleanly without any cropping.

---

## Slide-by-Slide Outline

### Slide 1: Title Slide
- **Title**: The Small World Phenomenon
- **Subtitle**: Bridges, Hubs, and the Science of Shortcuts
- **Visual**: A clean introductory graphic or subtitle layout.

### Slide 2: Defining the "Small World"
- **Concepts**: Dual structural criteria at the whole-network level:
  1. High local **clustering** (cliquishness of local circles).
  2. Low **average path length** (short distances across the entire network).
- **Visual**: A conceptual schematic showing dense local clusters linked by a single long-range bridge.

### Slide 3: The Graph Theory Basis: Clustering
- **Concepts**: **Clustering Coefficient** ($CC_i$), measuring the fraction of an ego's contacts who are connected to each other:
  $$CC_i = \frac{m}{n(n-1)/2}$$
- **Visual**: A small 3-node ego network illustrating the transition from an open triad ($CC = 0$) to a closed triad ($CC = 1$).

### Slide 4: The Graph Theory Basis: Paths
- **Concepts**: Shortest paths or **geodesics**. Defining path **length** as the number of edges, and average path length as the mean geodesic distance between all pairs.
- **Visual**: A path highlight in a directed/undirected network demonstrating a geodesic of length 3.

### Slide 5: Milgram's Pioneer Experiment (1967)
- **Concepts**: Stanley Milgram's classic letter-forwarding study in Nebraska and Boston.
  - **Six degrees of separation** (average of **5.2 intermediaries** in completed chains).
  - Role of **homophily** (age, gender, class) in forwarding decisions.
- **Visual**: A stylized letter-forwarding path diagram showing a chain traveling from Nebraska to a Boston stockbroker.

### Slide 6: Digital Replication: Dodds-Muhamad-Watts (2003)
- **Concepts**: Global email replication study (98,847 participants, 166 countries).
  - Median reconstructed path length of **5 to 7 steps**.
  - **Social foci** (work, higher education) and professional ties acting as the most effective "bridges" (vs. kin/friends).
- **Visual**: A clean table comparing Milgram's 1967 and DMW's 2003 empirical findings.

### Slide 7: Search Strategies: The Reverse Small World (1979)
- **Concepts**: Killworth and Bernard's "Reverse Small World" experiment.
  - Explored how people navigate using local information.
  - Choice of initial contact reveals that people use **search heuristics** based on geographic proximity and occupational similarity.

### Slide 8: The Watts-Strogatz Model (1998)
- **Concepts**: The mathematical bridge between order and randomness.
  - Starts with a **regular lattice** (high clustering, long paths).
  - Introduces **random rewiring** with probability $p$.
  - Highly non-linear effect: a tiny fraction of **shortcuts** (bridging ties) slashes path length while preserving high local clustering.
- **Visual**: A 3-panel dynamic network plot (Regular lattice $p=0$, Small-world $p=0.1$, and Random network $p=1$) using `igraph::play_smallworld()`.

### Slide 9: Preferential Attachment: The Barabási-Albert Model (1999)
- **Concepts**: Growth model where new nodes connect preferentially to well-connected **hubs** ("the rich get richer").
  - Produces **scale-free** power-law degree distributions.
  - Hubs act as massive shortcuts, shrinking the network's diameter.
  - *Trade-off*: Fails to capture high social **clustering** (clustering coefficient remains low).
- **Visual**: A network plot with nodes sized by their degree centrality (`igraph::play_barabasi_albert()`) to highlight the emerging hubs.

### Slide 10: How We Navigate: Searchability & Social Distance
- **Concepts**: The Watts-Dodds-Newman (2002) model of navigation.
  - Real networks are **searchable** using local information because they are organized into nested communities.
  - People navigate using **social distance heuristics** (similarity on identity dimensions like geography or occupation) or a **hub strategy** (seeking high-degree actors).

---

## Action Plan

1. **Create the New File**: Write `slides/small-world.qmd` with Quarto RevealJS presentation metadata.
2. **Draft Slide Content**: Populate all slides using RevealJS columns, list fragments, and LaTeX math notation.
3. **Embed R Visualizations**:
   - Write the Watts-Strogatz transition plot (Regular vs. Small-world vs. Random) using `ggraph` and `play_smallworld()`.
   - Write the Preferential Attachment plot using `ggraph` and `play_barabasi_albert()`, sizing nodes by degree to visually emphasize hubs.
   - Adjust `xlim`, `ylim`, node caps, and margins to ensure **no cropping or clipping** occurs on the slides.
4. **Link slide deck**: Mention the new slide deck in any main index or verify it builds successfully with `quarto render slides/small-world.qmd`.
