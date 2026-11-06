# Generates images/feld-foci-segregation.png for slides/ego-homogeneity.qmd
# ("Feld's Rule: How Segregated Foci Drive Homogeneity" slide).
# Stylized schematic (not study data). No internal title/subtitle/panel-header
# text — those live in the slide bullets; only focus names and small A/B tags
# stay inside the figure.
library(ggplot2)

node_pt <- function(x, y, grp) data.frame(x, y, grp)

# Panel A: two segregated foci, each a 3-node same-group triangle
a_wp <- rbind(node_pt(0.30, 0.68, "blue"), node_pt(0.18, 0.45, "blue"), node_pt(0.42, 0.45, "blue"))
a_ch <- rbind(node_pt(0.30, 0.68, "orange"), node_pt(0.18, 0.45, "orange"), node_pt(0.42, 0.45, "orange"))
# Panel B: two integrated foci, each a 4-node 50/50 square with one diagonal
b_wp <- rbind(node_pt(0.23, 0.68, "blue"), node_pt(0.37, 0.68, "orange"),
              node_pt(0.23, 0.42, "orange"), node_pt(0.37, 0.42, "blue"))
b_ch <- rbind(node_pt(0.23, 0.68, "orange"), node_pt(0.37, 0.68, "blue"),
              node_pt(0.23, 0.42, "blue"), node_pt(0.37, 0.42, "orange"))

col <- c(blue = "#5B9BD5", orange = "#F39C12", fill_blue = "#5B9BD5",
         fill_orange = "#F39C12")

one_panel <- function(x0, nodes_raw, focus_x, focus_lab, focus_col, tag) {
  nodes <- nodes_raw
  nodes$x <- nodes$x + x0
  list(
    # focus container
    annotate("rect", xmin = x0, xmax = x0 + 0.62, ymin = 0.06, ymax = 0.92,
             fill = "grey96", color = "grey55", linewidth = 0.6, linetype = "22"),
    annotate("text", x = focus_x, y = 0.845, label = focus_lab,
             color = focus_col, fontface = "bold", size = 7.6, lineheight = 1.0),
    # panel tag (only when non-empty)
    if (nzchar(tag)) annotate("label", x = x0 + 0.045, y = 0.965, label = tag,
                              size = 5, fontface = "bold", label.size = 0,
                              fill = "grey93"),
    geom_point(data = nodes, aes(x, y, fill = grp), shape = 21,
               size = 10, color = "grey35", stroke = 0.5),
    # triangle / square edges + diagonal
    geom_segment(data = nodes, aes(x = x, y = y, xend = x, yend = y),
                 alpha = 0)  # placeholder keeps panel order stable
  )
}

# edges drawn manually per panel geometry
seg <- function(x0, pts, pairs, diag = FALSE) {
  do.call(rbind, lapply(pairs, function(p) {
    data.frame(x = x0 + pts$x[p[1]], y = pts$y[p[1]],
               xend = x0 + pts$x[p[2]], yend = pts$y[p[2]])
  }))
}

tri_pairs <- list(c(1, 2), c(1, 3), c(2, 3))
sq_pairs  <- list(c(1, 2), c(1, 3), c(2, 4), c(3, 4), c(1, 4))

edges <- rbind(
  seg(0.00, a_wp, tri_pairs), seg(0.72, a_ch, tri_pairs),
  seg(1.44, b_wp, sq_pairs),  seg(2.16, b_ch, sq_pairs)
)

p <- ggplot() +
  one_panel(0.00, a_wp, 0.31, "Workplace", col[["blue"]], "A") +
  one_panel(0.72, a_ch, 1.03, "Church", col[["orange"]], "") +
  one_panel(1.44, b_wp, 1.75, "Workplace", "grey40", "B") +
  one_panel(1.44 + 0.72, b_ch, 1.44 + 1.03, "Church", "grey40", "") +
  geom_segment(data = edges, aes(x = x, y = y, xend = xend, yend = yend),
               color = "grey55", linewidth = 1.3, lineend = "round") +
  scale_fill_manual(values = c(blue = col[["fill_blue"]],
                               orange = col[["fill_orange"]]), guide = "none") +
  coord_cartesian(xlim = c(-0.02, 2.82), ylim = c(0, 1), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(10, 12, 10, 12))

ggsave("images/feld-foci-segregation.png", p, width = 8.25, height = 2.95,
       dpi = 200, bg = "white")
