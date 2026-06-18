# Plan: Create Strength of Weak Ties Slide Deck and Visuals

This plan outlines the steps to create a new Quarto slide deck introducing students to Granovetter's Theory of the Strength of Weak Ties (SWT), generate beautiful and educational network visualizations demonstrating g-transitivity and local bridges, and compile the results.

## Proposed Changes

### 1. Create Network Visualizations
We will write and execute an R script using `ggplot2`, `ggraph`, and `tidygraph` (or base R/igraph if preferred) to generate three high-quality network visuals:
- **`images/swt-transitivity-strong.png`**: A triad representing Granovetter's g-transitivity (Rule 2). Node B has strong ties (thick lines) to both A and C, resulting in a dashed/dotted "likely tie" between A and C.
- **`images/swt-transitivity-weak.png`**: A triad representing the weak tie principle. Node B has a weak tie (thin line) to A and a strong tie (thick line) to C, resulting in a high probability of "no tie" between A and C.
- **`images/swt-bridge.png`**: A network of two distinct, dense social clusters connected only by a single weak tie (the local bridge or broker), illustrating how weak ties span structural holes.

### 2. Create Quarto RevealJS Slide Deck (`slides/strength-weak-ties.qmd`)
We will create a structured presentation following the ucla-theme RevealJS style:
- **Slide 1**: Title (The Strength of Weak Ties: Form, Transitivity, and Bridging)
- **Slide 2**: Form vs. Content in Social Ties (definitions and the distinction)
- **Slide 3**: Defining Tie Strength (Granovetter's 4 pillars + Marsden & Campbell's indicator/predictor model)
- **Slide 4**: The Stage Model of Tie Strengthening (Friedkin's 3-stage model)
- **Slide 5**: The Concept of g-Transitivity (Rule 1 & Rule 2, with g-transitivity visual side-by-side)
- **Slide 6**: The Weak Tie Principle (violations of transitivity, with weak tie visual side-by-side)
- **Slide 7**: Weak Ties as Bridges (local bridges and structural brokerage, with bridge visual side-by-side)
- **Slide 8**: Applications: Finding a Job & Social Mobility
- **Slide 9**: System-Level Consequences: Diffusion & Social Cohesion (the global effects of weak ties)
- **Slide 10**: The Diversity-Bandwidth Tradeoff Theory (Aral & Van Alstyne revision)
- **Slide 11**: Summary of Key Takeaways

## Verification Plan
- Run R script to generate and save the three PNG files.
- Render the slide deck to HTML using `quarto render slides/strength-weak-ties.qmd` via `bash` to verify compilation.
- Inspect the generated plots in Positron to verify high quality and visual alignment.
