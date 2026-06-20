# Plan: Title Cleanup, Node Label Fitting, and Short Dashes for Slide Decks

This plan details the specific visual and structural adjustments for `slides/balance-signed-graphs.qmd` and `slides/valenced-interactions.qmd` to:
1. Remove "Slide X:" prefixes from all slide titles.
2. Shorten node labels for a perfect fit within circles.
3. Prevent overlapping edges.
4. Replace long dashes (`"dashed"`) with custom short dashes (`"33"`) for negative ties.

---

## Part 1: Slide Title Prefix Removal

To make the presentations look cleaner and more professional, we will remove all "Slide X:" prefixes from slide titles in both files.

### 1. In `slides/balance-signed-graphs.qmd`:
- `## Slide 1: Balance Theory and Signed Graphs` $\implies$ `## Balance Theory and Signed Graphs`
- `## Slide 2: The Anatomy of Sentiment Networks` $\implies$ `## The Anatomy of Sentiment Networks`
- `## Slide 3: Fritz Heider's Dyadic Balance` $\implies$ `## Fritz Heider's Dyadic Balance`
- `## Slide 4: Proximity, Similarity, and Multiplexity` $\implies$ `## Proximity, Similarity, and Multiplexity`
- `## Slide 5: Dyadic Balance and Cognitive Tension` $\implies$ `## Dyadic Balance and Cognitive Tension`
- `## Slide 6: Fritz Heider’s P-O-Q Triad` $\implies$ `## Fritz Heider’s P-O-Q Triad`
- `## Slide 7: The Mathematics of Triadic Balance` $\implies$ `## The Mathematics of Triadic Balance`
- `## Slide 8: Balanced Triads: The 4 Stable Configurations` $\implies$ `## Balanced Triads: The 4 Stable Configurations`
- `## Slide 9: Unbalanced Triads: The 4 Unstable Configurations` $\implies$ `## Unbalanced Triads: The 4 Unstable Configurations`
- `## Slide 10: Tension and Change` $\implies$ `## Tension and Change`
- `## Slide 11: Cross-Pressure` $\implies$ `## Cross-Pressure`
- `## Slide 12: Cross-Pressure in Real-Life: Politics` $\implies$ `## Cross-Pressure in Real-Life: Politics`
- `## Slide 13: Structural Balance at the Network Level` $\implies$ `## Structural Balance at the Network Level`
- `## Slide 14: The Fundamental Theorem of Structural Balance` $\implies$ `## The Fundamental Theorem of Structural Balance`
- `## Slide 15: Signed Matrices & Faction Detection` $\implies$ `## Signed Matrices & Faction Detection`
- `## Slide 16: Cycles and Paths in Balanced Graphs` $\implies$ `## Cycles and Paths in Balanced Graphs`
- `## Slide 17: Empirical Case Study: Political Blogs` $\implies$ `## Empirical Case Study: Political Blogs`
- `## Slide 18: Beyond Two Factions: Davis's Theorem` $\implies$ `## Beyond Two Factions: Davis's Theorem`
- `## Slide 19: The All-Negative Triad Rule` $\implies$ `## The All-Negative Triad Rule`
- `## Slide 20: Summary: Structural Balance vs. Clusterability` $\implies$ `## Summary: Structural Balance vs. Clusterability`

### 2. In `slides/valenced-interactions.qmd`:
- `## Slide 1: Introduction to Valenced Interactions` $\implies$ `## Introduction to Valenced Interactions`
- `## Slide 2: Karma Theory: Core Concept` $\implies$ `## Karma Theory: Core Concept`
- `## Slide 3: Karma Theory: Network-Wide Flow` $\implies$ `## Karma Theory: Network-Wide Flow`
- `## Slide 4: Karma Dynamics: Virtuous vs. Vicious Cycles` $\implies$ `## Karma Dynamics: Virtuous vs. Vicious Cycles`
- `## Slide 5: Status Theory: Introduction` $\implies$ `## Status Theory: Introduction`
- `## Slide 6: Prestige and Deference Alignment` $\implies$ `## Prestige and Deference Alignment`
- `## Slide 7: Status and Outgoing Sentiments` $\implies$ `## Status and Outgoing Sentiments`
- `## Slide 8: Status Dynamics: Centralization and Hierarchy Growth` $\implies$ `## Status Dynamics: Centralization and Hierarchy Growth`
- `## Slide 9: Solidarity Theory: Core Concept` $\implies$ `## Solidarity Theory: Core Concept`
- `## Slide 10: Measuring Shared Position` $\implies$ `## Measuring Shared Position`
- `## Slide 11: Solidarity Dynamics: Stratification and Clique Growth` $\implies$ `## Solidarity Dynamics: Stratification and Clique Growth`
- `## Slide 12: Comparison of Karma, Status, and Solidarity` $\implies$ `## Comparison of Karma, Status, and Solidarity`
- `## Slide 13: Co-Evolution of Valenced Networks: A Combined Model` $\implies$ `## Co-Evolution of Valenced Networks: A Combined Model`

---

## Part 2: Node Label Adjustments for Perfect Sizing

To prevent long labels from spilling out of node points, we will shorten all multi-character labels into clean, natural abbreviations that fit inside standard node sizes (e.g., `size = 20` or `24`) with size `5` or `6` fonts.

### 1. In `slides/balance-signed-graphs.qmd`:
- **Slide 2**: Change `"Alter 1"` to `"A1"`, `"Alter 2"` to `"A2"`.
- **Slide 12**: Change `"Brother"` to `"Bro"`, `"Sister"` to `"Sis"`, and `"Democrats"` to `"Dems"`.

### 2. In `slides/valenced-interactions.qmd`:
- **Slide 1**: Change `"Alter 1"` to `"A1"`, `"Alter 2"` to `"A2"`.
- **Slide 2**: Change `"Friend"` to `"Frnd"`.
- **Slide 4**: Change `"You"` to `"You"`, `"Bully"` to `"Bly"`, `"Friend"` to `"Frnd"`.
- **Slide 6**: Change `"High Status"` to `"High"`, `"Low Status"` to `"Low"`.

---

## Part 3: Short Dashes for Negative Edge Lines

To replace long dashes with high-contrast, short dashes, we will modify `scale_edge_linetype_manual` values in all R chunks to map negative lines to `"33"` or `"dashed"` with a custom pattern, or use the standard short-dashed R layout `"33"` (3 units on, 3 units off).

- We will change all occurrences of `"-" = "dashed"` or `"Negative Tie" = "dashed"` to use the short-dashed format: `"-" = "33"` or `"Negative Tie" = "33"`.

---

## Execution and Quality Control

We will use the `edit` tool to perform precise, exact replacements in both `.qmd` files, and compile them to confirm zero warnings or errors.
