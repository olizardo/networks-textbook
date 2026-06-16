
library(ggraph)
library(tidygraph)
gr <- create_empty(3, directed = TRUE)
l_grid <- ggraph(gr, layout = 'grid')$data
print(l_grid)
