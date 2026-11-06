# Generates images/blau-group-size.png for slides/ego-homogeneity.qmd
# ("Visualizing Blau's Group Size Effects" slide). Stylized schematic.
# No internal title/subtitle — the slide bullets carry Rule 1/Rule 2 text.
# Run from the repo root: Rscript images/make_blau_group_size.R
library(ggplot2)

blue <- "#5B9BD5"; orange <- "#F39C12"; edge_h <- "grey45"; edge_l <- "grey80"

# left panel: minority ego (orange) — Rule 1
egoL <- data.frame(x = 0.55, y = 0.55, grp = "orange")
altL <- data.frame(
  x = c(0.55, 0.40, 0.44, 0.50, 0.72, 0.76),
  y = c(0.80, 0.66, 0.36, 0.22, 0.55, 0.42),
  grp = c("blue", "blue", "blue", "blue", "orange", "orange")
)
# right panel: majority ego (blue) — Rule 2
altR <- data.frame(
  x = c(1.50, 1.62, 1.72, 1.62, 1.50, 1.42, 1.32, 1.38),
  y = c(0.82, 0.74, 0.60, 0.44, 0.30, 0.26, 0.38, 0.62),
  grp = "blue"
)

seg <- function(df, pairs, w) do.call(rbind, lapply(pairs, function(p)
  data.frame(x = df$x[p[1]], y = df$y[p[1]], xend = df$x[p[2]],
             yend = df$y[p[2]], w = w)))

# ego = row 1 of alt frames
eL <- rbind(egoL, altL); eL$grp <- c("orange", as.character(altL$grp))
eR <- rbind(data.frame(x = 1.52, y = 0.55, grp = "blue"), altR)
edges <- rbind(
  seg(eL, list(c(1,2), c(1,3), c(1,4), c(1,5), c(1,6)), edge_h),  # ego ties heavy
  seg(eL, list(c(2,3), c(5,6)), edge_l),                          # alter-alter light
  seg(eR, list(c(1,2), c(1,3), c(1,4), c(1,5), c(1,6)), edge_h),
  seg(eR, list(c(2,8), c(4,5), c(3,7)), edge_l)
)

# population strips (opportunity structure)
stripL <- data.frame(x = seq(0.08, 0.36, length.out = 8), y = 0.12, grp = "blue")
stripR <- data.frame(x = seq(1.28, 1.96, length.out = 10), y = 0.12,
                     grp = c(rep("blue", 6), rep("orange", 4)))

p <- ggplot() +
  annotate("rect", xmin = 0.02, xmax = 0.98, ymin = 0.04, ymax = 0.98,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 1.22, xmax = 2.18, ymin = 0.04, ymax = 0.98,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("text", x = 0.06, y = 0.935, label = "Minority ego (orange)",
           hjust = 0, fontface = "bold", size = 5.6) +
  annotate("text", x = 1.26, y = 0.935, label = "Majority ego (blue)",
           hjust = 0, fontface = "bold", size = 5.6) +
  geom_segment(data = subset(edges, w == edge_l),
               aes(x, y, xend = xend, yend = yend),
               color = edge_l, linewidth = 0.8, lineend = "round") +
  geom_segment(data = subset(edges, w == edge_h),
               aes(x, y, xend = xend, yend = yend),
               color = edge_h, linewidth = 1.9, lineend = "round") +
  geom_point(data = altL, aes(x, y, fill = grp), shape = 21,
             size = 7.5, color = "grey35", stroke = 0.5) +
  geom_point(data = egoL, aes(x, y, fill = grp), shape = 23,
             size = 8.5, color = "grey30", stroke = 0.6) +
  geom_point(data = eR[1, ], aes(x, y, fill = grp), shape = 23,
             size = 8.5, color = "grey30", stroke = 0.6) +
  geom_point(data = altR, aes(x, y, fill = grp), shape = 21,
             size = 7.5, color = "grey35", stroke = 0.5) +
  geom_point(data = stripL, aes(x, y, fill = grp), shape = 21,
             size = 4.6, color = "grey55", stroke = 0.4) +
  geom_point(data = stripR, aes(x, y, fill = grp), shape = 21,
             size = 4.6, color = "grey55", stroke = 0.4) +
  # thin links inside the strips
  geom_segment(data = data.frame(
    x = c(stripL$x[6], stripR$x[2], stripR$x[7], stripR$x[8]),
    y = 0.12,
    xend = c(stripL$x[7], stripR$x[3], stripR$x[8], stripR$x[9]),
    yend = 0.12), aes(x, y, xend = xend, yend = yend),
    color = edge_l, linewidth = 0.8) +
  scale_fill_manual(values = c(blue = blue, orange = orange), guide = "none") +
  coord_cartesian(xlim = c(0, 2.2), ylim = c(0, 1), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(8, 10, 8, 10))

ggsave("images/blau-group-size.png", p, width = 8.25, height = 4.125,
       dpi = 200, bg = "white")
