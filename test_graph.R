
library(igraph)
library(tidygraph)
library(ggraph)
edges <- data.frame(
  from = c(1, 2, 2, 3, 3, 4, 7),
  to = c(3, 3, 5, 4, 5, 7, 8)
)
nodes <- data.frame(name = paste0("V", 1:8))
gr_running <- tbl_graph(nodes = nodes, edges = edges, directed = FALSE)
ggraph(gr_running, layout = "fr") +
  geom_edge_link() +
  geom_node_point(size = 10, color = "tan2") +
  geom_node_text(aes(label = name)) +
  theme_graph()
