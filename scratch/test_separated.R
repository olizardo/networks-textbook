
library(ggraph)
library(tidygraph)
library(igraph)
library(patchwork)

x_triad <- c(0, 2, 1)
y_triad <- c(0, 0, 1.2)
gr_c <- create_empty(3, directed = TRUE)

plot_tr <- function(edges, title) {
  g <- gr_c %>% mutate(name = toupper(letters[1:3]))
  if (nrow(edges) > 0) {
    g <- g %>% bind_edges(edges)
  }
  p <- ggraph(g, layout = "manual", x = x_triad, y = y_triad) +
    geom_edge_link(color = "#2c3e50", edge_width = 1.1,
                   arrow = arrow(length = unit(3, 'mm'), type = "closed"),
                   end_cap = circle(6, 'mm'), start_cap = circle(6, 'mm')) +
    geom_node_point(size = 12, fill = "#ecf0f1", color = "#2c3e50", shape = 21, stroke = 1.25) +
    geom_node_text(aes(label = name), size = 5, fontface = "bold", color = "#2c3e50") +
    theme_graph() + ggtitle(title) + 
    coord_cartesian(xlim = c(-0.5, 2.5), ylim = c(-0.2, 1.4), clip = "off") +
    theme(
      plot.title = element_text(size = 10, face="bold", hjust=0.5, color = "#2c3e50"),
      plot.margin = margin(5, 5, 5, 5)
    )
  return(p)
}

p1 <- plot_tr(data.frame(), "1. 003")
p2 <- plot_tr(data.frame(from=1, to=2), "2. 012")
p3 <- plot_tr(data.frame(from=c(1,2), to=c(2,3)), "3. 021C")
p4 <- plot_tr(data.frame(from=c(1,1), to=c(2,3)), "4. 021D")

p_combined <- p1 + p2 + p3 + p4 + plot_layout(nrow = 1)
ggsave("scratch/test_separated_triads.png", plot = p_combined, width = 11, height = 5.5, dpi = 150)
