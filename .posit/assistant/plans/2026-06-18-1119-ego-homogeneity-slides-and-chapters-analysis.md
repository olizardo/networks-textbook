# Plan: Create Ego Network Homogeneity and Diversity Slide Deck and Visuals

This plan outlines the steps to find and analyze existing PPT slides and textbook chapters concerning homophily and theories about the structural sources of ego network homogeneity and diversity (Blau, Feld, Marsden, and others), and develop a comprehensive Quarto slide deck along with high-quality network visualizations explaining each core concept.

## 1. File Discovery & Content Mapping

### Identified Textbook Chapters
- **`lesson-theory-ego-homo.qmd`**: "Theories of Ego Network Homogeneity and Diversity"
  - Covers Blau's Macrostructural Theory (nominal vs. graduated parameters, Rule 1, Rule 2, Rule 3, Multiform Heterogeneity, types of correlations across parameters).
  - Covers Feld's Theory of Social Foci (definition of "foci", mechanisms of tie formation, constraint vs. size, cross-cutting circles, Feld's Rule on segregated networks, tie maintenance).
  - Covers Marsden's Theory of Ego Network Diversity (core discussion networks, GSS name generators, network size/diversity/clustering trade-offs, kin proportion, Hofstra et al. 2017 co-ethnic friendships in online networks).
- **`lesson-sna-ego-networks.qmd`**: "Ego Network Metrics"
  - Covers simple ego graphs vs. ego networks (Ego and Alters, ego-to-alter ties, alter-to-alter ties, Clyde Mitchell's reticulum).
  - Covers mathematical formulations and calculations for:
    - **Ego Network Size**: $S(Ego) = |N(Ego)| = |E_{ea}|$
    - **EI Homophily Index**: $EI = \frac{External - Internal}{External + Internal}$
    - **Blau's Heterogeneity Index (H)**: $H = 1 - \sum_k p_k^2$, with maximum value $H_{max} = 1 - \frac{1}{k}$
    - **Clustering Coefficient (CC)**: $CC_i = \frac{2m}{n(n-1)}$

### Identified PowerPoint Slide Decks
- **`ppt_slides/Network Theories/ENT/Theories of Ego Network Homogeneity and Diversity.pptx`** (Primary deck)
- **`ppt_slides/Network Theories/ENT/Network Theory_ Macrostructure, Foci, and Opportunity Structures.pptx`**
- **`ppt_slides/Network Theories/ENT/Network Theory_ Homophily and Relationship Formation Mechanisms.pptx`**
- **`ppt_slides/Network Theories/ENT/Network Research_ Effects of Contexts and Opportunity Structures on Ego Networks.pptx`**
- **`ppt_slides/Network Theories/ENT/Homophily.pptx`**
- **`ppt_slides/Network Theories/ENT/Core Discussion Networks.pptx`**

---

## 2. Proposed Changes

### Step A: Generate Custom Visual Aids
We will write and execute an R script to produce five educational and aesthetically aligned visualizations using `ggplot2`, `ggraph`, and `tidygraph` in the `images/` directory:
1. **`images/blau-group-size.png`**: Side-by-side or dual panel network showing group size effects on outgroup vs. ingroup ties.
   - Panel A: Minority group member (small group size) having mostly outgroup connections due to statistical probability (Rule 1).
   - Panel B: Majority group member (large group size) having exclusively ingroup connections (Rule 2).
2. **`images/feld-social-foci.png`**: Network highlighting social foci. Nodes are clustered into distinct "foci" (e.g., workplace, club), demonstrating how ties form around shared activities and how overlapping memberships ("cross-cutting circles") lead to bridge-building.
3. **`images/marsden-size-diversity.png`**: Dual-panel showing Marsden's size-diversity rule.
   - Panel A: Small, highly clustered, homogeneous ego network (high kin proportion, strong ties).
   - Panel B: Large, open, diverse, unconstrained ego network (weak ties, low clustering, high diversity).
4. **`images/ego-metrics-ei.png`**: Visualizing an ego network with color-coded nodes (e.g., gender categories) illustrating how to calculate the E-I Homophily Index and Blau's Heterogeneity Index (H) step-by-step.

### Step B: Create Quarto Slide Deck (`slides/ego-homogeneity.qmd`)
We will create a comprehensive, beautifully structured slide deck following the presentation style of other textbook slides.

#### Slide Outline:
- **Slide 1**: Title (Theories of Ego Network Homogeneity and Diversity)
- **Slide 2**: The Puzzle of Homogeneity & Diversity (Defining Homophily: "birds of a feather", selection vs. constraint)
- **Slide 3**: Blau's Macrostructural Theory: Social Structure and Parameters (Defining nominal vs. graduated parameters, heterogeneity, and inequality)
- **Slide 4**: Blau's Group Size Effects (Rule 1: Smaller groups & outgroup ties; Rule 2: Larger groups & ingroup ties; with `blau-group-size.png` visual)
- **Slide 5**: Blau's Multiform Heterogeneity (Rule 3: Correlated dimensions of association, propagating biases, types of correlations across parameters: categorical-categorical, categorical-continuous, continuous-continuous)
- **Slide 6**: Feld's Theory of Social Foci: Contexts of Association (Defining a social focus, "from circle to relation" and "from common activity to relation")
- **Slide 7**: Dimensions of Social Foci (Size and constraint, and their effects on tie formation and maintenance)
- **Slide 8**: Cross-Cutting Circles and Feld's Rule (Intersection of multiple foci, Feld's Rule on structural contexts driving segregation, with `feld-social-foci.png` visual)
- **Slide 9**: Marsden's Theory of Ego Network Diversity (The 1985 GSS core discussion networks, name generators, size-diversity-clustering relationships)
- **Slide 10**: Marsden's Rule & The Minority Paradox (Marsden's size-diversity rule, Hofstra et al. 2017 co-ethnic online friendships, running out of ingroup alters, with `marsden-size-diversity.png` visual)
- **Slide 11**: Key Ego Network Metrics: Size and Homogeneity (Ego network size, E-I Homophily Index formula, and step-by-step interpretation with `ego-metrics-ei.png` visual)
- **Slide 12**: Key Ego Network Metrics: Diversity and Clustering (Blau's Heterogeneity Index H, $H_{max}$, and Ego Clustering Coefficient CC formula and calculation)
- **Slide 13**: Summary and Synthesis (Comparing Blau, Feld, and Marsden on structural sources of ego network composition)

---

## 3. Verification Plan
- Run R scripts in console to generate the PNG files.
- Verify that each plot displays correctly and is saved to the `images/` directory.
- Render the slide deck locally: `quarto render slides/ego-homogeneity.qmd`.
- Ensure no compilation or LaTeX errors, and inspect the final slides for layout, text, and visual clarity.
