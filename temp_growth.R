
library(ggraph)
library(tidygraph)
library(patchwork)
library(ggplot2)

# Panel 1: Pre-Marriage
nodes_1 <- data.frame(
  name = c("P1", "You", "Sis", "P2", "Riley", "Bro"),
  x    = c(0, -0.5, 0.5, 3, 2.5, 3.5),
  y    = c(2, 1, 1, 2, 1, 1)
)
edges_1 <- data.frame(
  from = c(1, 1, 2, 4, 4, 5, 2),
  to   = c(2, 3, 3, 5, 6, 6, 5),
  type = c("parent", "parent", "sibling", "parent", "parent", "sibling", "romantic")
)
gr_1 <- tbl_graph(nodes = nodes_1, edges = edges_1, directed = TRUE)

# Panel 2: Post-Marriage + Baby
nodes_2 <- data.frame(
  name = c("P1", "You", "Sis", "P2", "Riley", "Bro", "Baby"),
  x    = c(0, -0.5, 0.5, 3, 2.5, 3.5, 1.5),
  y    = c(2, 1, 1, 2, 1, 1, 0)
)
edges_2 <- data.frame(
  from = c(1, 1, 2, 4, 4, 5, 2, 2, 5, 7), # You - Riley is undirected, so we can represent it
  to   = c(2, 3, 3, 5, 6, 6, 5, 7, 7, 3), # plus baby ties
  type = c("parent", "parent", "sibling", "parent", "parent", "sibling", "marriage", "parent-child", "parent-child", "inlaw")
)
gr_2 <- tbl_graph(nodes = nodes_2, edges = edges_2, directed = TRUE)

print("Graphs created successfully!")
