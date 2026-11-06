# Generates images/marsden-size-diversity.png for slides/ego-homogeneity.qmd
# ("Marsden's Rule, Tie Strength, and Kinship" slide). Stylized schematic.
# Two panels: small closed ego network vs. large open ego network.
# No internal main title/subtitle — the slide caption carries the takeaway.
# Run from the repo root: Rscript images/make_marsden_size_diversity.R
library(ggplot2)

ego_col <- "darkorange2"
cols <- c(purple = "darkorchid", green = "forestgreen",
          yellow = "gold", blue = "steelblue3")

# --- Small, closed ego network: 3 alters, complete graph, CC = 1.0, H = 0 ---
sm_alt <- data.frame(
  x = c(-0.55, 0.55, 0) + 0,
  y = c(0.45, 0.45, -0.75),
  grp = rep("purple", 3)
)
sm_ego <- data.frame(x = 0, y = -0.1, grp = "ego")
sm_nodes <- rbind(sm_alt, sm_ego)
sm_rown <- c(1, 2, 3, 0)  # alter ids 1-3, ego 0
sm_nodes$id <- sm_rown
sm_edge_list <- list()
for (i in 1:3) for (j in setdiff(0:3, i))
  sm_edge_list[[length(sm_edge_list) + 1]] <-
    data.frame(x = sm_nodes$x[sm_nodes$id == i], y = sm_nodes$y[sm_nodes$id == i],
               xend = sm_nodes$x[sm_nodes$id == j], yend = sm_nodes$y[sm_nodes$id == j])
sm_edges <- do.call(rbind, sm_edge_list)

# --- Large, open ego network: 8 alters, star + one alter-alter tie, CC = 2/56 ---
n_alt <- 8
ang <- seq(pi/2, pi/2 + 2*pi*(n_alt - 1)/n_alt, length.out = n_alt)
lg_alt <- data.frame(x = 0 + 0.72 * cos(ang), y = 0 + 0.72 * sin(ang),
                     grp = c("green", "green", "blue", "blue", "purple", "purple", "yellow", "yellow"))
lg_ego <- data.frame(x = 0, y = 0, grp = "ego")
lg_nodes <- rbind(lg_alt, lg_ego)
lg_nodes$id <- 1:9
lg_edges <- do.call(rbind, lapply(1:8, function(i)
  data.frame(x = 0, y = 0, xend = lg_alt$x[i], yend = lg_alt$y[i])))
# the only alter-alter tie: the two yellow alters (adjacent, ids 7-8)
lg_edges <- rbind(lg_edges, data.frame(x = lg_alt$x[7], y = lg_alt$y[7],
                                       xend = lg_alt$x[8], yend = lg_alt$y[8]))

panel <- function(nodes, edges, title, stats, ego_x, ego_y) {
  ggplot() +
    geom_segment(data = edges, aes(x, y, xend = xend, yend = yend),
                 color = "grey65", linewidth = 1.4, lineend = "round") +
    geom_point(data = nodes[nodes$grp != "ego", ], aes(x, y, fill = grp),
               shape = 21, size = 9, color = "grey35", stroke = 0.5) +
    geom_point(data = nodes[nodes$grp == "ego", ], aes(x, y, fill = grp),
               shape = 23, size = 10, color = "grey30", stroke = 0.6) +
    scale_fill_manual(values = c(cols, ego = ego_col), guide = "none") +
    annotate("text", x = 0, y = 1.68, label = title, fontface = "bold", size = 5.0) +
    annotate("text", x = 0, y = 1.18, label = stats, size = 4.1, lineheight = 0.95) +
    coord_cartesian(xlim = c(-1.05, 1.05), ylim = c(-1.1, 1.85), clip = "off") +
    theme_void() +
    theme(plot.margin = margin(6, 8, 6, 8))
}

p_small <- panel(sm_nodes, sm_edges,
                 "Small, Closed Ego Network",
                 "Size = 3\nDiversity (H) = 0.0\nClustering (CC) = 1.0 (high constraint)",
                 0, -0.1)
p_large <- panel(lg_nodes, lg_edges,
                 "Large, Open Ego Network",
                 "Size = 8\nDiversity (H) = 0.75 (high)\nClustering (CC) = 0.04 (low constraint)",
                 0, 0)

library(patchwork)
p <- p_small + p_large
ggsave("images/marsden-size-diversity.png", p, width = 5.9, height = 3.4,
       dpi = 200, bg = "white")
