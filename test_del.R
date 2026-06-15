
library(igraph)
library(ggraph)
library(tidygraph)
set.seed(367)
gr <- play_gnm(n = 10, m = 20, directed = FALSE, loops = FALSE) |> 
  mutate(name = LETTERS[1:10])

# check if we can delete using -
tryCatch({
    gr_del <- gr - c("F", "G", "H", "I", "J")
    print(V(gr_del)$name)
}, error=function(e) print(e))
