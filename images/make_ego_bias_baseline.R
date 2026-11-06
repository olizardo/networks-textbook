# Generates images/ego-bias-baseline.png for slides/ego-homogeneity.qmd
# ("Visualizing Baseline vs. Inbreeding Homophily" slide). Stylized schematic.
# No internal title/subtitle — the slide bullets carry the explanation.
# Run from the repo root: Rscript images/make_ego_bias_baseline.R
library(ggplot2)

blue <- "#5B9BD5"; orange <- "#F39C12"; edge <- "grey75"

# population pool: 8 blue + 2 orange
pool <- data.frame(
  x = rep(c(0.12, 0.22, 0.32, 0.42, 0.52), 2),
  y = rep(c(0.62, 0.34), each = 5),
  grp = c("blue", "blue", "blue", "orange", "orange",
          "blue", "blue", "blue", "blue", "blue")
)

# ego networks: diamond ego + alter spokes
spokes <- function(cx, eg, blue_n, orange_n) {
  n <- blue_n + orange_n
  ang <- seq(pi/2, pi/2 + 2*pi*0.999, length.out = n)
  data.frame(x = cx + 0.22 * cos(ang), y = 0.48 + 0.22 * sin(ang),
             grp = c(rep("blue", blue_n), rep("orange", orange_n)))
}
altU <- spokes(1.10, "blue", 4, 1)   # baseline: mirrors the 80/20 pool
altB <- spokes(1.90, "orange", 0, 5) # inbreeding: all similar alters

edges <- function(cx, eg) do.call(rbind, lapply(seq_len(nrow(altU) + 1), function(i)
  NULL)) # built below
mk <- function(cx, alt) do.call(rbind, lapply(seq_len(nrow(alt)), function(i)
  data.frame(x = cx, y = 0.48, xend = alt$x[i], yend = alt$y[i])))
eU <- mk(1.10, altU); eB <- mk(1.90, altB)

p <- ggplot() +
  annotate("rect", xmin = 0.03, xmax = 0.60, ymin = 0.06, ymax = 0.92,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 0.68, xmax = 1.52, ymin = 0.06, ymax = 0.92,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 1.60, xmax = 2.44, ymin = 0.06, ymax = 0.92,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("text", x = 0.315, y = 0.87, label = "Population pool (80/20)",
           fontface = "bold", size = 5.0) +
  annotate("text", x = 1.10, y = 0.87, label = "Baseline ego network",
           fontface = "bold", size = 5.0) +
  annotate("text", x = 2.02, y = 0.87, label = "Inbreeding ego network",
           fontface = "bold", size = 5.0) +
  geom_segment(data = rbind(eU, eB), aes(x, y, xend = xend, yend = yend),
               color = edge, linewidth = 1.1, lineend = "round") +
  geom_point(data = pool, aes(x, y, fill = grp), shape = 21,
             size = 7.5, color = "grey55", stroke = 0.4) +
  geom_point(data = altU, aes(x, y, fill = grp), shape = 21,
             size = 8, color = "grey35", stroke = 0.5) +
  geom_point(data = altB, aes(x, y, fill = grp), shape = 21,
             size = 8, color = "grey35", stroke = 0.5) +
  geom_point(data = data.frame(x = c(1.10, 1.90), y = 0.48, grp = c("blue", "orange")),
             aes(x, y, fill = grp), shape = 23, size = 9,
             color = "grey30", stroke = 0.6) +
  scale_fill_manual(values = c(blue = blue, orange = orange), guide = "none") +
  coord_cartesian(xlim = c(0, 2.47), ylim = c(0, 1), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(8, 10, 8, 10))

ggsave("images/ego-bias-baseline.png", p, width = 8.25, height = 3.75,
       dpi = 200, bg = "white")
