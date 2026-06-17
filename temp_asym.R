
library(ggraph)
library(tidygraph)

gr_asym <- create_empty(2, directed = TRUE) %>% 
  bind_edges(data.frame(from = c(1, 2), to = c(2, 1), type = c("solid", "dashed"), label = c("", "?"))) %>% 
  mutate(name = toupper(letters[1:2]))

p <- ggraph(gr_asym, layout = 'linear') +
  geom_edge_parallel(aes(linetype = type, color = type, label = label), edge_width = 1.5,
                  arrow = arrow(length = unit(5, 'mm'), type = "closed"),
                  end_cap = circle(8, 'mm'), sep = unit(4, 'mm'),
                  label_colour = "gray40", show.legend = FALSE) +
  scale_edge_color_manual(values = c("solid" = "steelblue", "dashed" = "gray60"), guide = "none") +
  scale_edge_linetype_manual(values = c("solid" = "solid", "dashed" = "dashed"), guide = "none") +
  geom_node_point(size = 25, color = "tan2") +
  geom_node_text(aes(label = name), size = 10, fontface = "bold", color = "white") +
  theme_graph() + coord_cartesian(clip = "off")

ggsave("test_asym.png", p, width = 6, height = 4)
