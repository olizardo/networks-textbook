# Generates images/ego-bias-baseline.png for slides/ego-homogeneity.qmd
# ("Visualizing Baseline vs. Inbreeding Homophily" slide). Stylized schematic.
# No internal title/subtitle — the slide bullets carry the explanation.
# Layout: three panels STACKED VERTICALLY as horizontal bands
# (population pool row, baseline ego network, inbreeding ego network).
# Run from the repo root: Rscript images/make_ego_bias_baseline.R
library(ggplot2)

blue <- "#5B9BD5"; orange <- "#F39C12"; edge <- "grey75"

# population pool: 8 blue + 2 orange, one row
pool <- data.frame(
  x = seq(1.1, 8.9, length.out = 10),
  y = rep(10.9, 10),
  grp = c("blue", "blue", "blue", "orange", "orange",
          "blue", "blue", "blue", "blue", "blue")
)

# ego networks: diamond ego + alters on a circle
spokes <- function(cx, cy, r, blue_n, orange_n) {
  n <- blue_n + orange_n
  ang <- seq(pi/2, pi/2 + 2*pi*0.999, length.out = n)
  data.frame(x = cx + r * cos(ang), y = cy + r * sin(ang),
             grp = c(rep("blue", blue_n), rep("orange", orange_n)))
}
altU <- spokes(5, 6.05, 1.30, 4, 1)   # baseline: mirrors the 80/20 pool
altB <- spokes(5, 1.70, 1.30, 0, 5)   # inbreeding: all similar alters

mk <- function(cx, cy, alt) do.call(rbind, lapply(seq_len(nrow(alt)), function(i)
  data.frame(x = cx, y = cy, xend = alt$x[i], yend = alt$y[i])))
eU <- mk(5, 6.05, altU); eB <- mk(5, 1.70, altB)

egos <- data.frame(x = c(5, 5), y = c(6.05, 1.70), grp = c("blue", "orange"))

p <- ggplot() +
  # band 1: population pool
  annotate("rect", xmin = 0.2, xmax = 9.8, ymin = 9.0, ymax = 12.7,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("text", x = 5, y = 12.15, label = "Population pool (80/20)",
           fontface = "bold", size = 5.2) +
  # band 2: baseline ego network
  annotate("rect", xmin = 0.2, xmax = 9.8, ymin = 4.55, ymax = 8.55,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("text", x = 5, y = 8.15, label = "Baseline ego network",
           fontface = "bold", size = 5.2) +
  # band 3: inbreeding ego network
  annotate("rect", xmin = 0.2, xmax = 9.8, ymin = 0.1, ymax = 4.1,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("text", x = 5, y = 3.70, label = "Inbreeding ego network",
           fontface = "bold", size = 5.2) +
  geom_segment(data = rbind(eU, eB), aes(x, y, xend = xend, yend = yend),
               color = edge, linewidth = 1.1, lineend = "round") +
  geom_point(data = pool, aes(x, y, fill = grp), shape = 21,
             size = 7.5, color = "grey55", stroke = 0.4) +
  geom_point(data = altU, aes(x, y, fill = grp), shape = 21,
             size = 9, color = "grey35", stroke = 0.5) +
  geom_point(data = altB, aes(x, y, fill = grp), shape = 21,
             size = 9, color = "grey35", stroke = 0.5) +
  geom_point(data = egos, aes(x, y, fill = grp), shape = 23, size = 10,
             color = "grey30", stroke = 0.6) +
  scale_fill_manual(values = c(blue = blue, orange = orange), guide = "none") +
  coord_cartesian(xlim = c(0, 10), ylim = c(0, 13), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(8, 10, 8, 10))

ggsave("images/ego-bias-baseline.png", p, width = 5, height = 6.5,
       dpi = 200, bg = "white")
