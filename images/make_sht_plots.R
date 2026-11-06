library(igraph)
library(ggraph)
library(ggplot2)
library(gridExtra)

# --- Plot 1: Spanning a Structural Hole ---
nodes <- data.frame(
  name = c("Broker", "A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4"),
  role = c("Broker", rep("Group A", 4), rep("Group B", 4))
)

edges_A <- subset(expand.grid(from = paste0("A", 1:4), to = paste0("A", 1:4)), from != to)
edges_A$type <- "Internal Tie"
edges_B <- subset(expand.grid(from = paste0("B", 1:4), to = paste0("B", 1:4)), from != to)
edges_B$type <- "Internal Tie"
edges_bridge <- data.frame(
  from = c("Broker", "Broker"),
  to   = c("A1", "B1"),
  type = rep("Bridging Tie", 2)
)

edges <- rbind(edges_A, edges_B, edges_bridge)
g <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)
g <- simplify(g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = "first")

set.seed(42)
p1 <- ggraph(g, layout = 'fr') + 
  geom_edge_link(aes(color = type, edge_width = type), alpha = 0.8) +
  geom_node_point(aes(color = role, size = role)) +
  geom_node_text(aes(label = name), vjust = 0.5, hjust = 0.5, 
                 color = "white", fontface = "bold", size = 3.5) +
  scale_edge_color_manual(values = c("Bridging Tie" = "firebrick", "Internal Tie" = "steelblue")) +
  scale_edge_width_manual(values = c("Bridging Tie" = 1.2, "Internal Tie" = 1.2)) +
  scale_color_manual(values = c("Broker" = "firebrick", "Group A" = "steelblue", "Group B" = "forestgreen")) +
  scale_size_manual(values = c("Broker" = 16, "Group A" = 11, "Group B" = 11)) +
  labs(title = "Spanning a Structural Hole",
       subtitle = "The Broker acts as the sole conduit of information between Group A and Group B.",
       color = "Actor Role", 
       size = "Actor Role", 
       edge_color = "Tie Type", 
       edge_width = "Tie Type") +
  theme_void() +
  theme(plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
        plot.subtitle = element_text(size = 9, hjust = 0.5, margin = margin(b = 10)),
        legend.position = "bottom",
        legend.box = "vertical")

ggsave("images/sht-spanning-hole.png", p1, width = 6, height = 6, dpi = 300)
print("Saved images/sht-spanning-hole.png")

# --- Plot 2: Gould & Fernandez Brokerage Roles ---
plot_brokerage <- function(node_groups, title) {
  edges <- data.frame(
    from = c("A", "B"),
    to   = c("B", "C")
  )
  
  nodes <- data.frame(
    name = c("A", "B", "C"),
    group = node_groups
  )
  
  g <- graph_from_data_frame(edges, directed = TRUE, vertices = nodes)
  
  layout_matrix <- matrix(c(
    -1.0,   0.0,  # A
     0.0,   0.8,  # B
     1.0,   0.0   # C
  ), ncol = 2, byrow = TRUE)
  
  ggraph(g, layout = layout_matrix) +
    geom_edge_link(arrow = arrow(length = unit(3, 'mm'), type = "closed"),
                   end_cap = circle(10, 'mm'),
                   start_cap = circle(8, 'mm'),
                   width = 1.5, 
                   color = "steelblue") +
    geom_node_point(aes(color = group), size = 20) +
    geom_node_text(aes(label = name), size = 8, fontface = "bold", color = "white") +
    scale_color_manual(values = c("Group 1" = "tan2", 
                                  "Group 2" = "firebrick", 
                                  "Group 3" = "forestgreen")) +
    labs(title = title) +
    theme_graph() + 
    coord_cartesian(clip = "off") +
    theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 12, margin = margin(b = 5)),
          legend.position = "none")
}

# 1. Representative
p_rep <- plot_brokerage(c("Group 1", "Group 1", "Group 2"), 
                        "1. Representative\n(A & B in Grp 1 -> C in Grp 2)")

# 2. Gatekeeper
p_gate <- plot_brokerage(c("Group 1", "Group 2", "Group 2"), 
                         "2. Gatekeeper\n(A in Grp 1 -> B & C in Grp 2)")

# 3. Itinerant / Consultant
p_itin <- plot_brokerage(c("Group 1", "Group 2", "Group 1"), 
                         "3. Itinerant (Consultant)\n(A & C in Grp 1, B in Grp 2)")

# 4. Liaison
p_liai <- plot_brokerage(c("Group 1", "Group 2", "Group 3"), 
                         "4. Liaison\n(All actors in different groups)")

# Combined plot in a 2x2 grid
p_combined <- grid.arrange(p_rep, p_gate, p_itin, p_liai, ncol = 2)

ggsave("images/sht-gould-fernandez.png", p_combined, width = 8, height = 8, dpi = 300)
print("Saved images/sht-gould-fernandez.png")
