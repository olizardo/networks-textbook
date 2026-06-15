library(ggraph)
library(tidygraph)

set.seed(3489)
fr <- c("A", "A", "B", "A", "A", "B", "C", "C", "D", "D", "E", "E", "F", "G", "G", "B")
to <- c("B", "F", "A", "G", "D", "D", "B", "E", "B", "G", "C", "D", "A", "F", "D", "E")
w <- c(17, 19, 20, 15, 3, 20, 10, 11, 2, 12, 13, 25, 13, 18, 19, 15)

edge.dat <- data.frame(from = fr, to = to, weight = w)
node.dat <- data.frame(name = union(fr, to))
gr <- tbl_graph(edges = edge.dat, nodes = node.dat)

# Test 5: Constant label_pos = 0.38 passed as parameter
tryCatch({
  p5 <- ggraph(gr, layout = 'mds') +
    geom_edge_parallel(aes(label = weight),
                        angle_calc = 'along', label_size = 5,
                        label_pos = 0.38, # constant position to stagger opposite-direction edges
                        label_dodge = unit(2.5, 'mm'),
                        label_colour = "black",
                        color = "steelblue", edge_width = 1.25,
                        arrow = arrow(length = unit(5, 'mm')),
                        end_cap = circle(10, 'mm'), 
                        sep = unit(7, 'mm')) +
    geom_node_point(aes(x = x, y = y), size = 20, color = "tan2") +
    geom_node_text(aes(label = name), size = 8, color = "white") +
    theme_graph()
  
  ggsave("scratch/test_plot_5.png", plot = p5, width = 8, height = 8)
  print("Test 5 succeeded!")
}, error = function(e) {
  print(paste("Test 5 failed:", e$message))
})
