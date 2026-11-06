# Generates images/feld-social-foci.png for slides/ego-homogeneity.qmd
# ("Dimensions of Social Foci and Structural Effects" slide).
# Stylized schematic (not study data). No internal title/subtitle — those
# live in the slide text; only the focus labels stay inside the figure.
library(tidygraph)
library(ggraph)
library(ggplot2)

nodes <- data.frame(
  name = c("Ego",
           "Colleague 1", "Colleague 2", "Colleague 3", "Colleague 4", "Colleague 5",
           "Runner 1", "Runner 2", "Runner 3", "Runner 4", "Runner 5"),
  x = c(0.50,
        0.27, 0.13, 0.20, 0.30, 0.36,
        0.73, 0.86, 0.80, 0.66, 0.64),
  y = c(0.50,
        0.68, 0.62, 0.35, 0.20, 0.52,
        0.68, 0.62, 0.38, 0.20, 0.52),
  grp = c("ego", rep("colleague", 5), rep("runner", 5)),
  lab = c("", paste0("Colleague ", 1:5), paste0("Runner ", 1:5))
)

edges <- data.frame(from = c(  # intra = 1: light intra-focus tie; 2: ego's heavy cross-cutting tie

  # intra-focus ties (light)
  "Colleague 1", "Colleague 1", "Colleague 1", "Colleague 2", "Colleague 2", "Colleague 3", "Colleague 3",
  "Runner 1", "Runner 1", "Runner 1", "Runner 2", "Runner 2", "Runner 3", "Runner 3",
  # ego's cross-cutting ties (heavy, dark)
  "Ego", "Ego", "Ego", "Ego", "Ego", "Ego"
),
intra = c(rep("1", 14), rep("2", 6)),
to = c(
  "Colleague 2", "Colleague 3", "Colleague 5",
  "Colleague 3", "Colleague 4", "Colleague 4", "Colleague 5",
  "Runner 2", "Runner 3", "Runner 5",
  "Runner 3", "Runner 5", "Runner 4", "Runner 5",
  "Colleague 1", "Colleague 2", "Colleague 3", "Runner 1", "Runner 2", "Runner 3"
))

gr <- tidygraph::tbl_graph(nodes, edges, directed = FALSE)

p <- ggraph(gr, layout = "manual", x = nodes$x, y = nodes$y) +
  # focus containers
  annotate("rect", xmin = 0.03, xmax = 0.44, ymin = 0.06, ymax = 0.94,
           fill = "#EAF3FB", color = "#5B9BD5", linewidth = 0.6, linetype = "22") +
  annotate("rect", xmin = 0.56, xmax = 0.97, ymin = 0.06, ymax = 0.94,
           fill = "#EDF6EC", color = "#4C9A4C", linewidth = 0.6, linetype = "22") +
  annotate("text", x = 0.235, y = 0.90, label = "Focus A:\nWorkplace",
           color = "#2E6DA4", fontface = "bold", size = 5.2, lineheight = 1.05) +
  annotate("text", x = 0.765, y = 0.90, label = "Focus B:\nRunning Club",
           color = "#3B7A3B", fontface = "bold", size = 5.2, lineheight = 1.05) +
  geom_edge_link0(aes(edge_colour = intra, edge_width = intra), lineend = "round") +
  scale_edge_colour_manual(values = c("1" = "#BFBFBF", "2" = "#4D4D4D"), guide = "none") +
  scale_edge_width_manual(values = c("1" = 0.9, "2" = 2.4), guide = "none") +
  geom_node_point(aes(shape = grp, fill = grp, color = grp), size = 9, stroke = 0.4) +
  scale_shape_manual(values = c("ego" = 23, "colleague" = 21, "runner" = 21), guide = "none") +
  scale_fill_manual(values = c("ego" = "#F39C12", "colleague" = "#5B9BD5", "runner" = "#2E9B4E"), guide = "none") +
  scale_color_manual(values = c("ego" = "#B35C00", "colleague" = "#2E6DA4", "runner" = "#1E6B33"), guide = "none") +
  geom_node_text(aes(label = lab), size = 4.6, fontface = "bold",
                 nudge_y = 0.055, family = "sans") +
  annotate("text", x = 0.555, y = 0.44, label = "Ego", size = 4.6,
           fontface = "bold", hjust = 0) +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 1), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(10, 14, 10, 14))

ggsave("images/feld-social-foci.png", p, width = 6.75, height = 4.125,
       dpi = 200, bg = "white")
