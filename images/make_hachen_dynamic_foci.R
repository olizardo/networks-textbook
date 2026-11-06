# Generates images/hachen-dynamic-foci.png for slides/ego-homogeneity.qmd
# ("Visualizing Dynamic Foci Processes" slide). Stylized schematic.
# No internal title/subtitle — the slide bullets carry the Panel A/B story;
# small t1/t2 and A/B tags keep the sequence readable.
# Layout: 2x2 grid (rows = Panel A / Panel B, columns = t1 / t2) with roomy
# scenes so labels do not crowd.
# Run from the repo root: Rscript images/make_hachen_dynamic_foci.R
library(ggplot2)

blue <- "#5B9BD5"; orange <- "#F39C12"; edge <- "grey75"
purple <- "#B366FF"

# scene: p1, p2 (circles, upper), f (focus square, lower center)
sc <- function(cx, cy) list(p1 = c(cx - 0.48, cy + 0.34),
                            p2 = c(cx + 0.48, cy + 0.34),
                            f  = c(cx,       cy - 0.30))

# columns (t1, t2) x rows (A, B)
sA1 <- sc(1.15, 2.10); sA2 <- sc(3.45, 2.10)
sB1 <- sc(1.15, 0.78); sB2 <- sc(3.45, 0.78)

tie <- function(a, b, col, lty, w)
  data.frame(x = a[1], y = a[2], xend = b[1], yend = b[2], col = col,
             lty = lty, w = w)

edges <- rbind(
  tie(sA1$p1, sA1$f, edge, "solid", 1.2), tie(sA1$p2, sA1$f, edge, "solid", 1.2),
  tie(sA2$p1, sA2$f, edge, "solid", 1.2), tie(sA2$p2, sA2$f, edge, "solid", 1.2),
  tie(sA2$p1, sA2$p2, purple, "22", 2.0),                    # t2: new tie forms
  tie(sB1$p1, sB1$p2, edge, "solid", 1.2), tie(sB1$p1, sB1$f, edge, "solid", 1.2),
  tie(sB2$p1, sB2$p2, edge, "solid", 1.2), tie(sB2$p1, sB2$f, edge, "solid", 1.2),
  tie(sB2$p2, sB2$f, purple, "22", 2.0)                      # t2: affiliation diffuses
)

pers <- as.data.frame(do.call(rbind, list(sA1$p1, sA1$p2, sA2$p1, sA2$p2,
                                          sB1$p1, sB1$p2, sB2$p1, sB2$p2)))
names(pers) <- c("x", "y"); pers$grp <- "blue"
foci <- as.data.frame(do.call(rbind, list(sA1$f, sA2$f, sB1$f, sB2$f)))
names(foci) <- c("x", "y"); foci$grp <- "orange"

tagP <- function(pt, lab)
  annotate("text", x = pt[1], y = pt[2] + 0.13, label = lab, size = 4.5,
           fontface = "bold", hjust = 0.5)

p <- ggplot() +
  # scene boxes
  annotate("rect", xmin = 0.15, xmax = 2.15, ymin = 1.55, ymax = 2.95,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 2.45, xmax = 4.45, ymin = 1.55, ymax = 2.95,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 0.15, xmax = 2.15, ymin = 0.08, ymax = 1.48,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 2.45, xmax = 4.45, ymin = 0.08, ymax = 1.48,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  # panel and time tags
  annotate("label", x = 0.22, y = 2.87, label = "A", size = 5.5, fontface = "bold",
           label.size = 0, fill = "grey93") +
  annotate("label", x = 0.22, y = 1.40, label = "B", size = 5.5, fontface = "bold",
           label.size = 0, fill = "grey93") +
  annotate("text", x = 1.95, y = 2.87, label = "t[1]", parse = TRUE, size = 4.8) +
  annotate("text", x = 4.25, y = 2.87, label = "t[2]", parse = TRUE, size = 4.8) +
  annotate("text", x = 1.95, y = 1.40, label = "t[1]", parse = TRUE, size = 4.8) +
  annotate("text", x = 4.25, y = 1.40, label = "t[2]", parse = TRUE, size = 4.8) +
  geom_segment(data = edges,
               aes(x, y, xend = xend, yend = yend, color = col,
                   linetype = lty, linewidth = w), lineend = "round") +
  scale_color_identity() + scale_linetype_identity() + scale_linewidth_identity() +
  geom_point(data = pers, aes(x, y, fill = grp), shape = 21,
             size = 12, color = "grey35", stroke = 0.5) +
  geom_point(data = foci, aes(x, y, fill = grp), shape = 22,
             size = 12, color = "grey35", stroke = 0.5) +
  tagP(sA1$p1, "P1") + tagP(sA1$p2, "P2") +
  tagP(sA2$p1, "P1") + tagP(sA2$p2, "P2") +
  tagP(sB1$p1, "P1") + tagP(sB1$p2, "P2") +
  tagP(sB2$p1, "P1") + tagP(sB2$p2, "P2") +
  annotate("text", x = sA1$f[1], y = sA1$f[2] - 0.17, label = "Focus A",
           size = 4.5, fontface = "bold") +
  annotate("text", x = sA2$f[1], y = sA2$f[2] - 0.17, label = "Focus A",
           size = 4.5, fontface = "bold") +
  annotate("text", x = sB1$f[1] + 0.14, y = sB1$f[2], label = "Focus A",
           size = 4.5, fontface = "bold", hjust = 0) +
  annotate("text", x = sB2$f[1] + 0.14, y = sB2$f[2], label = "Focus A",
           size = 4.5, fontface = "bold", hjust = 0) +
  scale_fill_manual(values = c(blue = blue, orange = orange), guide = "none") +
  coord_cartesian(xlim = c(0, 4.6), ylim = c(0, 3.05), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(8, 10, 8, 10))

ggsave("images/hachen-dynamic-foci.png", p, width = 5.2, height = 3.4,
       dpi = 200, bg = "white")
