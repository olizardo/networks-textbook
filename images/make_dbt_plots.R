library(igraph)
library(ggraph)
library(ggplot2)
library(gridExtra)

# --- Plot 1: Clustered vs. Unclustered Networks ---
# Clustered
g_clust <- graph_from_literal(Ego-Alter1, Ego-Alter2, Ego-Alter3, Alter1-Alter2, Alter2-Alter3, Alter3-Alter1)
set.seed(42)
p_clust <- ggraph(g_clust, layout = 'circle') +
  geom_edge_link(color = "firebrick", width = 2) +
  geom_node_point(color = "firebrick", size = 15) +
  geom_node_text(aes(label = name), color = "white", fontface = "bold", size = 3) +
  labs(title = "Clustered Network\n(Strong, High-Bandwidth Ties)") +
  theme_void() +
  theme(plot.title = element_text(face = "bold", size = 11, hjust = 0.5))

# Unclustered
g_unclust <- graph_from_literal(Ego-Alter1, Ego-Alter2, Ego-Alter3)
p_unclust <- ggraph(g_unclust, layout = 'star') +
  geom_edge_link(color = "steelblue", width = 0.8, linetype = "dashed") +
  geom_node_point(color = "steelblue", size = 15) +
  geom_node_text(aes(label = name), color = "white", fontface = "bold", size = 3) +
  labs(title = "Unclustered Network\n(Weak, Low-Bandwidth Ties)") +
  theme_void() +
  theme(plot.title = element_text(face = "bold", size = 11, hjust = 0.5))

p1_combined <- grid.arrange(p_clust, p_unclust, ncol = 2)
ggsave("images/dbt-clustering-bandwidth.png", p1_combined, width = 7, height = 3.5, dpi = 300)
print("Saved images/dbt-clustering-bandwidth.png")


# --- Plot 2: Diverse Information Pools (Non-Overlapping) ---
g_div <- graph_from_literal(Ego-Alter1, Ego-Alter2, Ego-Alter3)
nodes_div <- data.frame(
  name = c("Ego", "Alter1", "Alter2", "Alter3"),
  label = c("Ego\n(Low BW)", "Alter 1\n[1, 2, 3, 4]", "Alter 2\n[5, 6, 7, 8]", "Alter 3\n[9, 10, 11, 12]"),
  color = c("firebrick", "steelblue", "steelblue", "steelblue")
)
g_div <- graph_from_data_frame(as_data_frame(g_div), vertices = nodes_div, directed = FALSE)

p_div <- ggraph(g_div, layout = 'star') +
  geom_edge_link(color = "gray60", width = 0.8, linetype = "dashed") +
  geom_node_point(aes(color = color), size = 28) +
  geom_node_text(aes(label = label), color = "white", fontface = "bold", size = 3) +
  scale_color_identity() +
  labs(title = "Accessing Diverse Information Pools",
       subtitle = "Disconnected alters have unique, non-overlapping information. Low-bandwidth ties are highly efficient here.") +
  theme_void() +
  theme(plot.title = element_text(face = "bold", size = 12, hjust = 0.5),
        plot.subtitle = element_text(size = 9, hjust = 0.5, margin = margin(b = 10)))

ggsave("images/dbt-diverse-pools.png", p_div, width = 6, height = 5, dpi = 300)
print("Saved images/dbt-diverse-pools.png")


# --- Plot 3: Redundant Information Pools (Overlapping & Connected) ---
g_red <- graph_from_literal(Ego-Alter1, Ego-Alter2, Ego-Alter3, Alter1-Alter2, Alter2-Alter3, Alter3-Alter1)
nodes_red <- data.frame(
  name = c("Ego", "Alter1", "Alter2", "Alter3"),
  label = c("Ego\n(High BW)", "Alter 1\n[1, 2, 3, 4]", "Alter 2\n[1, 2, 3, 4]", "Alter 3\n[1, 2, 3, 4]"),
  color = c("firebrick", "forestgreen", "forestgreen", "forestgreen")
)
g_red <- graph_from_data_frame(as_data_frame(g_red), vertices = nodes_red, directed = FALSE)

p_red <- ggraph(g_red, layout = 'circle') +
  geom_edge_link(color = "gray40", width = 1.2) +
  geom_node_point(aes(color = color), size = 28) +
  geom_node_text(aes(label = label), color = "white", fontface = "bold", size = 3) +
  scale_color_identity() +
  labs(title = "Redundant Information Pools",
       subtitle = "Alters are connected and possess identical information. Strong, high-bandwidth ties are needed to transfer details quickly.") +
  theme_void() +
  theme(plot.title = element_text(face = "bold", size = 12, hjust = 0.5),
        plot.subtitle = element_text(size = 9, hjust = 0.5, margin = margin(b = 10)))

ggsave("images/dbt-redundant-pools.png", p_red, width = 6, height = 5, dpi = 300)
print("Saved images/dbt-redundant-pools.png")


# --- Plot 4: Overlap Spectrum ---
# Create small graphs for No Overlap, Some Overlap, Total Overlap
plot_sub <- function(label1, label2, title, edge_color, line_type) {
  g <- graph_from_literal(Ego-Alter1, Ego-Alter2)
  nodes <- data.frame(
    name = c("Ego", "Alter1", "Alter2"),
    label = c("Ego", label1, label2)
  )
  g <- graph_from_data_frame(as_data_frame(g), vertices = nodes, directed = FALSE)
  
  layout_matrix <- matrix(c(
     0.0,  0.5, # Ego
    -0.8, -0.5, # Alter 1
     0.8, -0.5  # Alter 2
  ), ncol = 2, byrow = TRUE)
  
  ggraph(g, layout = layout_matrix) +
    geom_edge_link(color = edge_color, width = 1.2, linetype = line_type) +
    geom_node_point(color = "steelblue", size = 22) +
    geom_node_text(aes(label = label), color = "white", fontface = "bold", size = 2.8) +
    labs(title = title) +
    theme_void() +
    theme(plot.title = element_text(face = "bold", size = 11, hjust = 0.5, margin = margin(b = 5)))
}

p_no <- plot_sub("Alter 1\n[1, 2, 3, 4]", "Alter 2\n[5, 6, 7, 8]", "No Overlap\n(Low BW ties are good)", "forestgreen", "dashed")
p_some <- plot_sub("Alter 1\n[1, 2, 3, 4]", "Alter 2\n[1, 2, 7, 8]", "Some Overlap\n(Low BW ties less useful)", "orange", "dashed")
p_total <- plot_sub("Alter 1\n[1, 2, 3, 4]", "Alter 2\n[1, 2, 3, 4]", "Total Overlap\n(Low BW ties are worse)", "firebrick", "solid")

p4_combined <- grid.arrange(p_no, p_some, p_total, ncol = 3)
ggsave("images/dbt-overlap-spectrum.png", p4_combined, width = 8, height = 3.5, dpi = 300)
print("Saved images/dbt-overlap-spectrum.png")
