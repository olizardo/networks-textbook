# Plan: Create Dunbar's Theory Slide Deck and Visuals

This plan outlines the steps to create a new Quarto slide deck introducing students to Dunbar's theory of social circles and the social brain, generate a beautiful concentric circles visualization of Dunbar's circles, and integrate this visualization into the textbook chapter.

## Proposed Changes

### 1. Create a Concentric Circles Visualization (`images/dunbar-circles.png`)
We will write and execute an R script to generate a high-quality visualization of Dunbar's circles centered on an Ego. 
- **Concentric Circles**: Four concentric boundary circles corresponding to the four primary Dunbar layers:
  1. Support Clique (radius 1, limit ~5)
  2. Sympathy Group (radius 2, limit ~15)
  3. Affinity Group (radius 3, limit ~50)
  4. Active Network (radius 4, limit ~150)
- **Visual Elements**:
  - Central **Ego** node.
  - Simulated nodes (dots) randomly distributed within each layer:
    - Inner circle: ~5 dense, warm-colored nodes (high intimacy/strong ties).
    - Second ring: ~10 nodes.
    - Third ring: ~35 nodes.
    - Fourth ring: ~100 smaller, lighter nodes (low intimacy/weak ties).
  - Clear label annotations for each layer (Name, size, role) placed cleanly on the diagram.
  - A beautiful, clean color palette matching the UCLA theme or textbook style (clean background, minimalist, sans-serif typography).
- **Save Path**: `images/dunbar-circles.png`

### 2. Create the Quarto RevealJS Slide Deck (`slides/dunbar-theory.qmd`)
A professional slide deck following the template of other textbook slides.
- **Title**: Dunbar's Theory of the Social Brain and Social Circles
- **Subtitle**: Cognitive Limits and the Layered Structure of Ego Networks
- **Content Outline**:
  - **Slide 1**: Title slide (using UCLA CSS themes).
  - **Slide 2**: Introduction to the Social Brain Hypothesis (brain size evolution, primate group size correlation, neocortex constraints).
  - **Slide 3**: The Concept of Ego Network Layers (concentric organization, cognitive/emotional/time maintenance costs).
  - **Slide 4**: Visualizing Dunbar Circles (incorporating the new visual).
  - **Slide 5**: The Support Clique (~5 people) and Sympathy Group (~15 people) - Inner layers, strong ties, high intimacy, emergency support.
  - **Slide 6**: The Affinity Group (~50 people) and Active Network (~150 people) - Outer layers, weak ties, low maintenance, face/name recognition.
  - **Slide 7**: Tie Strength and Network Structure (relationship between Dunbar layers and Granovetter's Weak Tie Theory, g-transitivity in inner layers, bridging in outer layers).
  - **Slide 8**: Implications and Modern Challenges (social media, cognitive bandwidth, summary of core takeaways).

### 3. Update the Textbook Chapter (`lesson-theory-dunbar.qmd`)
- Insert the new concentric circles visual (`images/dunbar-circles.png`) inside the section `## Layered Structure of Ego Networks (Dunbar Circles)` as a Quarto figure with label `@fig-dunbar-circles`.
- Reference `@fig-dunbar-circles` in the text to guide students.
- Refine existing text to ensure seamless reading flow with the new figure.

## Verification Plan

### Automated Checks
- Run R script to generate and save `images/dunbar-circles.png`.
- Inspect the saved image using `getPlot` or checking file details.
- Render the slide deck and textbook chapter using Quarto CLI (via `executeCode` or `bash`) to verify that there are no syntax or formatting errors.

### Visual Checks
- Verify node density and placement in the concentric circles.
- Verify text alignment and legibility in the PNG file.
