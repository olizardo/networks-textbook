    require(ggraph)
    require(tidygraph)
    require(igraph)

# Define the edges based on the adjacency matrix in the slides
edges_19 <- c(
  "a","b", "a","d", "a","f",
  "b","d", "b","e", "b","g",
  "c","f", "c","h",
  "d","e", "d","f", "d","g",
  "e","g",
  "f","g",
  "g","h",
  "h","i", "h","r",
  "i","j", "i","n", "i","p",
  "j","k", "j","l", "j","m", "j","n", "j","o", "j","p",
  "k","l", "k","p",
  "l","m",
  "m","q",
  "n","o",
  "q","s"
)

# Create and plot the graph
g19 <- make_graph(edges_19, directed = FALSE)
plot(g19, main="19-Node Undirected Graph (Degree/Closeness)", 
     vertex.color="lightblue", vertex.size=20)

d <- degree(g19)
d <- d[order(names(d))]
d

g <- distances(g19)["i", ]
g <- g[order(names(g))]
g

c <- round(closeness(g19, normalize = TRUE), 2)
c <- c[order(names(c))]
c

b <- round(betweenness(g19), 2)
b <- b[order(names(b))]
b

all_shortest_paths(g19, "h", "a")