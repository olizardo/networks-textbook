
library(ggraph)
library(tidygraph)
library(igraph)

nodes <- data.frame(name = 1:6, x = c(0, 1, 2, 0, 1, 2), y = c(1, 1.1, 1, 0, -0.1, 0))
edges <- data.frame(
  from = c(1, 2, 2, 4, 5, 1, 3, 5),
  to   = c(2, 3, 5, 5, 6, 4, 6, 6),
  is_highlight = factor(c("highlight", "normal", "highlight", "normal", "highlight", "normal", "normal", "normal"))
)

g <- tbl_graph(nodes = nodes, edges = edges, directed = FALSE)

p <- ggraph(g, layout = "manual", x = x, y = y) +
  geom_edge_link(aes(color = is_highlight, width = is_highlight), alpha = 0.8) +
  scale_edge_color_manual(values = c("normal" = "#7f8c8d", "highlight" = "#2980b9")) +
  scale_edge_width_manual(values = c("normal" = 0.8, "highlight" = 1.6)) +
  geom_node_point(size = 15, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.5) +
  geom_node_text(aes(label = name), size = 6, fontface = "bold", color = "#2c3e50") +
  theme_graph() +
  theme(legend.position = "none") +
  coord_cartesian(xlim = c(-0.5, 2.5), ylim = c(-0.5, 1.5), clip = "off")

ggsave("scratch/test_chapter_path.png", plot = p, width = 7, height = 5, dpi = 150)
