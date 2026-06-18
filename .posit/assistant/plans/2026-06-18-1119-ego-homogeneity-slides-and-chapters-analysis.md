# Plan: Add Intuitive Visualizations for Ego Network Bias & Feld's Foci Segregation

This plan outlines the design and implementation of two new conceptual visualizations to make Blau's population distributions and Feld's segregated foci theories visually intuitive, mimicking the pedagogical style of classic textbook figures.

---

## 1. Design of Visualizations

### Visual A: Population Distribution vs. Ego Network Bias (`images/ego-bias-baseline.png`)
This figure will explain **McPherson's Baseline Homophily vs. Inbreeding Homophily** and **Blau's opportunity constraints** using a highly intuitive layout (drawing "people" or distinct circular markers representing group members):
* **Left Panel: Population Distribution**
  * Displays a population pool of 10 people: 8 Blue (80% Majority) and 2 Orange (20% Minority).
* **Middle Panel: Unbiased Ego Network (Baseline / Opportunity)**
  * Shows a Minority Ego (Orange). Under neutral preferences (random mixing), their ego network is dictated by opportunity.
  * They have 5 friends: 4 Blue and 1 Orange (exactly mirroring the 80%/20% population ratio). This represents **zero preference bias**.
* **Right Panel: Biased Ego Network (Inbreeding Homophily)**
  * Shows the same Minority Ego (Orange), but now they have 5 friends who are **all Orange**.
  * This highlights how choice, local sorting, or systemic bias overrides population opportunity, resulting in an **extremely biased ego network**.

### Visual B: Segregated vs. Integrated Foci (`images/feld-foci-segregation.png`)
This figure will demonstrate **Feld's core rule** that network segregation can be driven entirely by how contexts (foci) are organized, independent of individual choice:
* **Panel A: Segregated Foci (Biased Networks)**
  * Focus A (Workplace) is 100% Blue. Focus B (Church) is 100% Orange.
  * An Ego in Focus A has a 100% Blue ego network; an Ego in Focus B has a 100% Orange ego network.
  * **Result**: Highly segregated ego networks, even if individual preferences are completely neutral.
* **Panel B: Integrated Foci (Diverse Networks)**
  * Focus A and Focus B are both diverse (each has 50% Blue and 50% Orange members).
  * An Ego in either focus forms a highly diverse ego network.
  * **Result**: Diverse ego networks, with the exact same neutral preferences.

---

## 2. Implementation Steps

### Step 1: Generate Visuals in R
We will write a robust R script to render both figures using `ggplot2` and `patchwork`. The figures will use clean, friendly colors, bold shapes (circles and squares/labels), and clear annotation arrows.

### Step 2: Update Slide Deck (`slides/ego-homogeneity.qmd`)
* Add a slide titled **"Ego Network Bias vs. Population Opportunity"** featuring `images/ego-bias-baseline.png` to explain baseline vs. inbreeding homophily.
* Add a slide titled **"Feld's Rule: How Segregated Foci Drive Homogeneity"** featuring `images/feld-foci-segregation.png` to explain context-induced segregation.

### Step 3: Compile and Verify
* Run the R script to generate and save `images/ego-bias-baseline.png` and `images/feld-foci-segregation.png`.
* Render the Quarto slide deck and inspect the layout for clean alignment and visual flow.
