
library(ggraph)
library(tidygraph)
library(igraph)

# Perfect 4-node coordinates (diamond layout)
nodes_mult <- data.frame(
  name = c("A", "B", "C", "D"),
  x = c(1, 0, 2, 1),
  y = c(2, 1, 1, 0)
)

edges_mult <- data.frame(
  from = c(1, 1, 2,  1,  3,  2, 3, 2,  2, 4,  4,  3, 4,  1, 4, 4),
  to   = c(2, 2, 1,  3,  1,  3, 2, 3,  4, 2,  3,  4, 3,  4, 1, 1),
  type = c(
    "Supervisor-of", "Friendship", "Friendship", # A-B
    "Supervisor-of", "Advice",                    # A-C
    "Coworker", "Coworker", "Advice",             # B-C
    "Friendship", "Friendship",                   # B-D
    "Supervisor-of", "Coworker", "Coworker",      # C-D
    "Coworker", "Coworker", "Advice"              # A-D
  )
)

gr_mult <- tbl_graph(nodes = nodes_mult, edges = edges_mult, directed = TRUE)

p <- ggraph(gr_mult, layout = "manual", x = x, y = y) +
  geom_edge_parallel(aes(color = type, linetype = type),
                     arrow = arrow(length = unit(3.0, 'mm'), type = "closed"),
                     start_cap = circle(8, 'mm'), end_cap = circle(8, 'mm'),
                     sep = unit(3.5, 'mm'), edge_width = 1.0) +
  scale_edge_color_manual(values = c(
    "Coworker" = "#7f8c8d",
    "Supervisor-of" = "#c0392b",
    "Friendship" = "#27ae60",
    "Advice" = "#8e44ad"
  )) +
  scale_edge_linetype_manual(values = c(
    "Coworker" = "dotted",
    "Supervisor-of" = "solid",
    "Friendship" = "dotdash",
    "Advice" = "dashed"
  )) +
  geom_node_point(size = 18, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
  geom_node_text(aes(label = name), size = 8, fontface = "bold", color = "#2c3e50") +
  theme_graph() + 
  coord_cartesian(xlim = c(-0.5, 2.5), ylim = c(-0.5, 2.5), clip = "off")

ggsave("scratch/test_multiplex.png", plot = p, width = 6.5, height = 5.5, dpi = 150)
