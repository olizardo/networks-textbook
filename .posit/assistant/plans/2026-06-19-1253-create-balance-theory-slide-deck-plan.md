# Plan: Complete Slide Deck on Balance Theory and Signed Graphs (GGraph Version)

The user has requested to replace all **Mermaid diagrams** in the slide presentation with programmatic **ggraph** R plots because the Mermaid diagrams render too small and their backgrounds do not match the UCLA theme of the slides.

This updated plan details the R code chunks and `ggraph` plotting configurations for every slide, using a custom transparent theme to ensure perfect blending with the presentation's background and standard node-edge sizing.

---

## Action Plan & Design Principles for GGraph Visuals

1. **Global Configuration & Transparent Backgrounds**:
   We will define a global R helper function `theme_slides()` in the setup block of the presentation. This function will override `ggraph::theme_graph()` to ensure transparent backgrounds:
   ```R
   theme_slides <- function(base_size = 12) {
     theme_graph() +
     theme(
       plot.background = element_rect(fill = "transparent", color = NA),
       panel.background = element_rect(fill = "transparent", color = NA),
       legend.background = element_rect(fill = "transparent", color = NA),
       legend.box.background = element_rect(fill = "transparent", color = NA),
       plot.title = element_text(size = base_size * 1.2, face = "bold", hjust = 0.5, color = "#2c3e50"),
       plot.subtitle = element_text(size = base_size * 1.0, hjust = 0.5, color = "#7f8c8d")
     )
   }
   ```
2. **Standard Color Coding**:
   - **Positive ties ($+$)**: Solid, forestgreen lines (`"forestgreen"` or `#27ae60`).
   - **Negative ties ($-$)**: Dashed, firebrick lines (`"firebrick"` or `#c0392b`).
   - **Nodes**: Colored `tan2` (`#e67e22`) or custom pastel colors with dark borders, labeled in bold white or dark grey depending on background.
3. **Manual Coordinate Layouts**:
   We will use manual coordinate matrices (or `ggraph` layouts like `circle` and `linear`) to keep nodes in precise structural positions (e.g., standard triangles for triads, horizontal layers for status/solidarity, and tight clusters for partitioning).
4. **Resolution & Sizing**:
   We will use knitr options `fig.width=6`, `fig.height=5`, and `dev.args=list(bg="transparent")` on every plotting R chunk to guarantee crisp rendering and proportional size relative to the slide text.

---

## Part 1: Dyadic Balance (Slides 1–5)

### Slide 1: Title & Overview
- **Visual**: A balanced triangle (A, B, C) with $+$, $+$, $-$ signs mapped onto edge lines.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(from = c("A", "B", "C"), to = c("B", "C", "A"), sign = c("+", "+", "-"))
  g <- graph_from_data_frame(edges, directed = FALSE)
  lay <- matrix(c(0, 1, -0.86, -0.5, 0.86, -0.5), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), width = 2, end_cap = circle(8, "mm"), start_cap = circle(8, "mm")) +
    geom_node_point(size = 18, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 6, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 2: The Anatomy of Sentiment Networks
- **Visual**: Ego sending positive tie to Alter 1 and negative tie to Alter 2.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 4
  #| echo: false
  edges <- data.frame(from = c("Ego", "Ego"), to = c("Alter 1", "Alter 2"), sign = c("+", "-"))
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(0, 0, -1, -1, 1, -1), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(4, "mm")), 
                   end_cap = circle(10, "mm"), start_cap = circle(10, "mm"), width = 2) +
    geom_node_point(aes(fill = name), size = 20, color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("Ego" = "#fff", "Alter 1" = "#d4edda", "Alter 2" = "#f8d7da")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 3: Fritz Heider's Dyadic Balance
- **Visual**: Similarity symmetric tie on left, and sentiment asymmetric tie on right.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 3.5
  #| echo: false
  edges <- data.frame(
    from = c("a1", "a2"), 
    to = c("b1", "b2"), 
    type = c("Symmetric Co-membership", "Asymmetric Liking")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(0, 1, 1, 1, 3, 1, 4, 1), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = type, linetype = type), 
                   arrow = list(NULL, arrow(length = unit(3, "mm"))),
                   end_cap = circle(8, "mm"), start_cap = circle(8, "mm"), width = 1.5) +
    geom_node_point(size = 14, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = c("a", "b", "a", "b")), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("Symmetric Co-membership" = "#2980b9", "Asymmetric Liking" = "forestgreen")) +
    scale_edge_linetype_manual(values = c("Symmetric Co-membership" = "solid", "Asymmetric Liking" = "solid")) +
    theme_slides() + theme(legend.position = "bottom", legend.title = element_blank())
  ```

### Slide 4: Proximity, Similarity, and Multiplexity
- **Visual**: Two nodes A and B with multiplex ties (co-workers, liking, and lunch partner).
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 4
  #| echo: false
  edges <- data.frame(
    from = c("A", "A", "B", "A"),
    to   = c("B", "B", "A", "B"),
    type = c("Co-workers", "Liking", "Liking", "Lunch Partner")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  ggraph(g, layout = "linear") +
    geom_edge_fan(aes(color = type, linetype = type), width = 1.8, 
                  arrow = arrow(length = unit(3, "mm")), 
                  end_cap = circle(10, "mm"), start_cap = circle(10, "mm")) +
    geom_node_point(size = 20, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 6, color = "#2c3e50") +
    scale_edge_color_manual(values = c("Co-workers" = "#7f8c8d", "Liking" = "forestgreen", "Lunch Partner" = "#d35400")) +
    theme_slides() + theme(legend.position = "bottom", legend.title = element_blank())
  ```

### Slide 5: Dyadic Balance and Cognitive Tension
- **Visual**: Nodes a and b with co-membership and asymmetric dislike.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 4
  #| echo: false
  edges <- data.frame(from = c("a", "a"), to = c("b", "b"), type = c("Similarity S", "Dislike D"))
  g <- graph_from_data_frame(edges, directed = TRUE)
  ggraph(g, layout = "linear") +
    geom_edge_fan(aes(color = type, linetype = type), width = 1.8,
                  arrow = list(NULL, arrow(length = unit(4, "mm"))),
                  end_cap = circle(12, "mm"), start_cap = circle(12, "mm")) +
    geom_node_point(size = 22, fill = "#fdfd96", color = "#f8e71c", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 6, color = "#2c3e50") +
    scale_edge_color_manual(values = c("Similarity S" = "#3498db", "Dislike D" = "firebrick")) +
    scale_edge_linetype_manual(values = c("Similarity S" = "solid", "Dislike D" = "dashed")) +
    theme_slides() + theme(legend.position = "bottom", legend.title = element_blank())
  ```

---

## Part 2: Triadic Balance (Slides 6–12)

### Slide 6: Fritz Heider’s P-O-Q Triad
- **Visual**: Standard P-O-Q triangle representing signed edges.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(from = c("P", "P", "O"), to = c("O", "Q", "Q"), type = c("sentiment", "sentiment", "sentiment"))
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(0, 1, -0.86, -0.5, 0.86, -0.5), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(arrow = arrow(length = unit(4, "mm")), width = 1.5, 
                   color = "#7f8c8d", end_cap = circle(10, "mm"), start_cap = circle(10, "mm")) +
    geom_node_point(aes(fill = name), size = 22, color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 6, color = "#2c3e50") +
    scale_fill_manual(values = c("P" = "#d4edda", "O" = "#ecf0f1", "Q" = "#f8d7da")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 8: Balanced Triads: The 4 Stable Configurations
- **Visual**: Side-by-side balanced triads (Friend of Friend & Enemy of Enemy).
- **R Code**:
  ```R
  #| fig.width: 8
  #| fig.height: 4
  #| echo: false
  edges <- data.frame(
    from = c("P1", "O1", "P1", "P2", "O2", "P2"),
    to   = c("O1", "Q1", "Q1", "O2", "Q2", "Q2"),
    sign = c("+", "+", "+", "-", "-", "+")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(
    -1.5, 1, -2.2, -0.2, -0.8, -0.2, # Triad 1
     1.5, 1,  0.8, -0.2,  2.2, -0.2  # Triad 2
  ), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(3, "mm")), 
                   width = 1.8, end_cap = circle(8, "mm"), start_cap = circle(8, "mm")) +
    geom_node_point(size = 15, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.2) +
    geom_node_text(aes(label = c("P", "O", "Q", "P", "O", "Q")), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 9: Unbalanced Triads: The 4 Unstable Configurations
- **Visual**: Side-by-side unbalanced triads (Friend of My Friend is Enemy & All Enemies).
- **R Code**:
  ```R
  #| fig.width: 8
  #| fig.height: 4
  #| echo: false
  edges <- data.frame(
    from = c("P3", "O3", "P3", "P4", "O4", "P4"),
    to   = c("O3", "Q3", "Q3", "O4", "Q4", "Q4"),
    sign = c("+", "+", "-", "-", "-", "-")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(
    -1.5, 1, -2.2, -0.2, -0.8, -0.2, # Triad 3
     1.5, 1,  0.8, -0.2,  2.2, -0.2  # Triad 4
  ), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(3, "mm")), 
                   width = 1.8, end_cap = circle(8, "mm"), start_cap = circle(8, "mm")) +
    geom_node_point(size = 15, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.2) +
    geom_node_text(aes(label = c("P", "O", "Q", "P", "O", "Q")), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 10: Tension and Change
- **Visual**: Transition flow showing left unbalanced triad converting to right balanced triad.
- **R Code**:
  ```R
  #| fig.width: 8
  #| fig.height: 4
  #| echo: false
  edges <- data.frame(
    from = c("P_unb", "O_unb", "P_unb", "P_bal", "O_bal", "P_bal"),
    to   = c("O_unb", "Q_unb", "Q_unb", "O_bal", "Q_bal", "Q_bal"),
    sign = c("+", "+", "-", "+", "+", "+")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(
    -1.5, 1, -2.2, -0.2, -0.8, -0.2, # Unbalanced
     1.5, 1,  0.8, -0.2,  2.2, -0.2  # Balanced
  ), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(3, "mm")), 
                   width = 1.8, end_cap = circle(8, "mm"), start_cap = circle(8, "mm")) +
    geom_node_point(size = 15, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.2) +
    geom_node_text(aes(label = c("P", "O", "Q", "P", "O", "Q")), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    annotate("text", x = 0, y = 0.4, label = "Restores Balance\n=======>\nChanges '-' to '+'", fontface="bold", color="#7f8c8d", size=4) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 11: Cross-Pressure
- **Visual**: P caught in cross-pressure between O1 and O2 towards Q.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(
    from = c("P", "P", "O1", "O2", "P"),
    to   = c("O1", "O2", "Q", "Q", "Q"),
    sign = c("+", "+", "+", "-", "?")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(0, 1, -1, 0, 1, 0, 0, -1), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(4, "mm")), 
                   width = 1.8, end_cap = circle(10, "mm"), start_cap = circle(10, "mm")) +
    geom_node_point(size = 18, fill = "#fdfd96", color = "#f8e71c", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick", "?" = "goldenrod")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed", "?" = "dotted")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 12: Cross-Pressure in Real-Life: Politics
- **Visual**: You, Brother, Sister, Democrats with opposing links.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(
    from = c("You", "You", "Brother", "Sister", "You"),
    to   = c("Brother", "Sister", "Democrats", "Democrats", "Democrats"),
    sign = c("+", "+", "+", "-", "?")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(0, 1, -1, 0, 1, 0, 0, -1), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(4, "mm")), 
                   width = 1.8, end_cap = circle(12, "mm"), start_cap = circle(12, "mm")) +
    geom_node_point(size = 20, fill = "#fdfd96", color = "#f8e71c", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 4.5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick", "?" = "goldenrod")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed", "?" = "dotted")) +
    theme_slides() + theme(legend.position = "none")
  ```

---

## Part 3: Structural Balance (Slides 13–17)

### Slide 13: Structural Balance at the Network Level
- **Visual**: A complete signed graph with 5 nodes.
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 5
  #| echo: false
  g <- play_erdos_renyi(n = 5, p = 1, directed = FALSE)
  E(g)$sign <- c("+", "-", "+", "+", "-", "+", "-", "+", "-", "+")
  ggraph(g, layout = "circle") +
    geom_edge_link(aes(color = sign, linetype = sign), width = 1.8) +
    geom_node_point(size = 16, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = 1:5), fontface = "bold", size = 5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 14: The Fundamental Theorem of Structural Balance
- **Visual**: Polarized Faction 1 (Blue) and Faction 2 (Purple) with positive internal links and negative external links.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 5
  #| echo: false
  nodes <- data.frame(name = LETTERS[1:6], faction = c(rep("1", 3), rep("2", 3)))
  edges <- expand.grid(from = LETTERS[1:6], to = LETTERS[1:6], stringsAsFactors = FALSE) %>%
    filter(from < to) %>%
    mutate(
      f_from = nodes$faction[match(from, nodes$name)],
      f_to = nodes$faction[match(to, nodes$name)],
      sign = ifelse(f_from == f_to, "+", "-")
    )
  g <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)
  lay <- matrix(c(-1.5, 0.8, -1.5, -0.8, -2.5, 0, 1.5, 0.8, 1.5, -0.8, 2.5, 0), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), width = 1.8, alpha = 0.8) +
    geom_node_point(aes(fill = faction), size = 22, color = "white", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 6, color = "white") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("1" = "steelblue", "2" = "darkorchid")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 16: Cycles and Paths in Balanced Graphs
- **Visual**: Start & End nodes spanning across Group 1 & Group 2 with crossing boundaries.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(
    from = c("Start", "Node B", "Node C", "End"),
    to   = c("Node B", "Node C", "End", "Start"),
    sign = c("+", "-", "+", "-")
  )
  g <- graph_from_data_frame(edges, directed = FALSE)
  lay <- matrix(c(-1.5, 0.8, -1.5, -0.8, 1.5, -0.8, 1.5, 0.8), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), width = 2) +
    geom_node_point(aes(fill = name %in% c("Start", "Node B")), size = 20, color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 4.5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("TRUE" = "#93c5fd", "FALSE" = "#c084fc")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 17: Empirical Case Study: Political Blogs
- **Visual**: High density Factions with sparse external links representing polarization.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 5
  #| echo: false
  set.seed(422)
  g1 <- play_erdos_renyi(n = 6, p = 0.8, directed = FALSE)
  g2 <- play_erdos_renyi(n = 6, p = 0.8, directed = FALSE)
  g <- union(g1, g2)
  V(g)$faction <- c(rep("Liberal", 6), rep("Conservative", 6))
  # Add negative crossing links
  g <- add_edges(g, c(1,7, 3,9, 5,11))
  E(g)$sign <- c(rep("+", ecount(g)-3), rep("-", 3))
  ggraph(g, layout = "kk") +
    geom_edge_link(aes(color = sign, linetype = sign), width = 1.5) +
    geom_node_point(aes(fill = faction), size = 15, color = "white", shape = 21, stroke = 1.2) +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("Liberal" = "#3b82f6", "Conservative" = "#ef4444")) +
    theme_slides() + theme(legend.position = "none")
  ```

---

## Part 4: Clusterability and Multi-Group Partitioning (Slides 18–20)

### Slide 18: Beyond Two Factions: Davis's Theorem
- **Visual**: Three clusters (Steelblue, Purple, Yellow) with internal positive and external negative links.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 5
  #| echo: false
  nodes <- data.frame(name = LETTERS[1:9], faction = c(rep("1", 3), rep("2", 3), rep("3", 3)))
  edges <- expand.grid(from = LETTERS[1:9], to = LETTERS[1:9], stringsAsFactors = FALSE) %>%
    filter(from < to) %>%
    mutate(
      f_from = nodes$faction[match(from, nodes$name)],
      f_to = nodes$faction[match(to, nodes$name)],
      sign = ifelse(f_from == f_to, "+", "-")
    )
  g <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)
  lay <- matrix(c(
    -0.35, 2.0, -0.65, 1.5, 0, 1.5,  # Cluster 1
    -1.0, 0.5, -1, 0, -0.65, -0.2,   # Cluster 2
    0.5, -0.5, 0, -0.5, 0.5, 0       # Cluster 3
  ), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), width = 1.5, alpha = 0.7) +
    geom_node_point(aes(fill = faction), size = 18, color = "white", shape = 21, stroke = 1.2) +
    geom_node_text(aes(label = name), fontface = "bold", size = 5, color = "white") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("1" = "steelblue", "2" = "darkorchid", "3" = "goldenrod")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 19: The All-Negative Triad Rule
- **Visual**: Three nodes with all-negative ties (clusterable and stable).
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 4.5
  #| echo: false
  edges <- data.frame(from = c("A", "B", "C"), to = c("B", "C", "A"), sign = c("-", "-", "-"))
  g <- graph_from_data_frame(edges, directed = FALSE)
  lay <- matrix(c(0, 1, -0.86, -0.5, 0.86, -0.5), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), width = 2, end_cap = circle(8, "mm"), start_cap = circle(8, "mm")) +
    geom_node_point(size = 18, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 6, color = "#2c3e50") +
    scale_edge_color_manual(values = c("-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("-" = "dashed")) +
    theme_slides() + theme(legend.position = "none")
  ```

---

## Part 5: Theoretical Extensions (Slides 21–24)

### Slide 21: Karma Theory
- **Visual**: Two separate spheres with a positive spreader and negative spreader.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(
    from = c("Pos Spreader", "Pos Spreader", "Pos Sender", "Neg Spreader", "Neg Spreader", "Neg Sender"),
    to   = c("Pos Target", "Pos Target 2", "Pos Spreader", "Neg Target", "Neg Target 2", "Neg Spreader"),
    sign = c("+", "+", "+", "-", "-", "-")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(
    -1.5, 1, -2.5, 1.8, -2.5, 0.2, -0.5, 1,   # Pos Sphere
     1.5, -1, 2.5, -1.8, 2.5, -0.2, 0.5, -1   # Neg Sphere
  ), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(3, "mm")), 
                   width = 1.8, end_cap = circle(8, "mm"), start_cap = circle(8, "mm")) +
    geom_node_point(aes(fill = name %in% c("Pos Spreader", "Neg Spreader")), size = 16, color = "white", shape = 21, stroke = 1.2) +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("TRUE" = "darkorange", "FALSE" = "dodgerblue")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 22: Status Theory
- **Visual**: High Status (deference flowing up) and Low Status (dominance flowing down).
- **R Code**:
  ```R
  #| fig.width: 5
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(
    from = c("Ego", "Ego"), 
    to = c("High Status", "Low Status"), 
    sign = c("+", "-")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(0, 0, 1.5, 1.5, -1.5, -1.5), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = sign, linetype = sign), arrow = arrow(length = unit(4, "mm")), 
                   width = 2, end_cap = circle(12, "mm"), start_cap = circle(12, "mm")) +
    geom_node_point(aes(fill = name), size = 22, color = "#2c3e50", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = name), fontface = "bold", size = 4.5, color = "#2c3e50") +
    scale_edge_color_manual(values = c("+" = "forestgreen", "-" = "firebrick")) +
    scale_edge_linetype_manual(values = c("+" = "solid", "-" = "dashed")) +
    scale_fill_manual(values = c("Ego" = "#fff", "High Status" = "#fdfd96", "Low Status" = "#ecf0f1")) +
    theme_slides() + theme(legend.position = "none")
  ```

### Slide 23: Solidarity Theory
- **Visual**: Elite Tier (mutual positive solidarity) and Subordinate Tier, with deference up and dominance down.
- **R Code**:
  ```R
  #| fig.width: 6
  #| fig.height: 5
  #| echo: false
  edges <- data.frame(
    from = c("Elite A", "Elite B", "Sub C", "Sub D", "Sub C", "Elite A"),
    to   = c("Elite B", "Elite A", "Sub D", "Sub C", "Elite A", "Sub C"),
    type = c("Solidarity", "Solidarity", "Solidarity", "Solidarity", "Deference", "Dominance")
  )
  g <- graph_from_data_frame(edges, directed = TRUE)
  lay <- matrix(c(-1.5, 1.5, 1.5, 1.5, -1.5, -1.5, 1.5, -1.5), ncol = 2, byrow = TRUE)
  ggraph(g, layout = lay) +
    geom_edge_link(aes(color = type, linetype = type), arrow = arrow(length = unit(3, "mm")), 
                   width = 1.8, end_cap = circle(10, "mm"), start_cap = circle(10, "mm")) +
    geom_node_point(aes(fill = name), size = 18, color = "white", shape = 21, stroke = 1.5) +
    geom_node_text(aes(label = c("A", "B", "C", "D")), fontface = "bold", size = 6, color = "white") +
    scale_edge_color_manual(values = c("Solidarity" = "#3498db", "Deference" = "forestgreen", "Dominance" = "firebrick")) +
    scale_edge_linetype_manual(values = c("Solidarity" = "solid", "Deference" = "solid", "Dominance" = "dashed")) +
    scale_fill_manual(values = c("Elite A" = "gold", "Elite B" = "gold", "Sub C" = "dodgerblue", "Sub D" = "dodgerblue")) +
    theme_slides() + theme(legend.position = "bottom", legend.title = element_blank())
  ```

---

## Deliverable Execution Details

To implement this, we will write R code directly inside R code chunks in `slides/balance-signed-graphs.qmd`. Since Quarto handles native code blocks through Knitr, this will dynamically generate crisp, high-resolution SVG/PNG assets that perfectly match the presentation theme, size, and layout properties.
