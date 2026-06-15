
library(igraph)
library(tidygraph)
library(ggraph)

# Create a non-simple graph
gr_non_simple <- create_empty(3, directed = FALSE) |>
  bind_edges(data.frame(from = c(1, 1, 2, 3), to = c(2, 2, 3, 3))) |>
  mutate(name = c("A", "B", "C"))

p <- ggraph(gr_non_simple, layout = 'circle') +
  geom_edge_link(color = "steelblue", edge_width = 1.5,
                 aes(edge_alpha = after_stat(index)), show.legend = FALSE) +
  geom_edge_loop(color = "tomato", edge_width = 1.5) +
  geom_node_point(size = 25, color = "tan2") +
  geom_node_text(aes(label = name), size = 12, color = "white") +
  theme_graph() +
  coord_cartesian(clip = "off") +
  labs(title = "A Non-Simple Graph", subtitle = "Notice the multiple edges between A and B,
and the loop on C.")
p
