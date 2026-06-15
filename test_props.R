
library(igraph)
library(tidygraph)
library(ggraph)

gr <- create_empty(4, directed = FALSE) |>
  bind_edges(data.frame(from = 1:2, to = 2:3)) |>
  mutate(name = c("A", "B", "C", "D"))

ggraph(gr, layout = 'kk') +
  geom_edge_link(color = "steelblue", edge_width = 1.5) +
  geom_node_point(size = 20, color = "tan2") +
  geom_node_text(aes(label = name), size = 8, color = "white") +
  theme_graph()
