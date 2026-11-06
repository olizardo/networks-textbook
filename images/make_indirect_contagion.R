# Generates images/indirect-contagion.png for slides/ego-homogeneity.qmd
# ("Hachen et al.'s Concept of 'Indirect Contagion'" slide). Stylized schematic.
# No internal title/subtitle — the slide bullets carry the explanation;
# small t1/t2 tags mark the two snapshots.
# Run from the repo root: Rscript images/make_indirect_contagion.R
library(ggplot2)

blue <- "#5B9BD5"; green <- "#2E9B4E"; orange <- "#F39C12"
edge <- "grey75"; red <- "#CC2200"

scene <- function(cx) list(
  fA = c(cx, 0.80), fB = c(cx, 0.20), p1 = c(cx - 0.33, 0.50), p2 = c(cx + 0.33, 0.50))
s1 <- scene(0.55); s2 <- scene(1.65)

tie <- function(a, b, col, lty, w)
  data.frame(x = a[1], y = a[2], xend = b[1], yend = b[2], col = col,
             lty = lty, w = w)

edges <- rbind(
  tie(s1$p1, s1$fA, edge, "solid", 1.2), tie(s1$p2, s1$fA, edge, "solid", 1.2),
  tie(s1$p1, s1$fB, edge, "solid", 1.2),
  tie(s2$p1, s2$fA, edge, "solid", 1.2), tie(s2$p2, s2$fA, edge, "solid", 1.2),
  tie(s2$p1, s2$fB, edge, "solid", 1.2),
  tie(s2$fB, s2$p2, red, "22", 1.8)   # the 4-cycle: Person 2 adopts Focus B
)

pers <- data.frame(
  x = c(s1$p1[1], s1$p2[1], s2$p1[1], s2$p2[1]),
  y = c(s1$p1[2], s1$p2[2], s2$p1[2], s2$p2[2]), grp = "blue")
fA <- data.frame(x = c(s1$fA[1], s2$fA[1]), y = c(s1$fA[2], s2$fA[2]), grp = "orange")
fB <- data.frame(x = c(s1$fB[1], s2$fB[1]), y = c(s1$fB[2], s2$fB[2]), grp = "green")

p <- ggplot() +
  annotate("rect", xmin = 0.08, xmax = 1.02, ymin = 0.04, ymax = 0.96,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("rect", xmin = 1.18, xmax = 2.12, ymin = 0.04, ymax = 0.96,
           fill = "grey98", color = "grey85", linewidth = 0.4) +
  annotate("text", x = 0.55, y = 0.935, label = "t[1]", parse = TRUE, size = 4.8) +
  annotate("text", x = 1.65, y = 0.935, label = "t[2]", parse = TRUE, size = 4.8) +
  geom_segment(data = edges,
               aes(x, y, xend = xend, yend = yend, color = col,
                   linetype = lty, linewidth = w), lineend = "round") +
  scale_color_identity() + scale_linetype_identity() + scale_linewidth_identity() +
  geom_point(data = pers, aes(x, y, fill = grp), shape = 21,
             size = 9, color = "grey35", stroke = 0.5) +
  geom_point(data = fA, aes(x, y, fill = grp), shape = 22,
             size = 9.5, color = "grey35", stroke = 0.5) +
  geom_point(data = fB, aes(x, y, fill = grp), shape = 22,
             size = 9.5, color = "grey35", stroke = 0.5) +
  annotate("text", x = 0.55, y = 0.885, label = "Focus A (Running Club)",
           size = 3.9, fontface = "bold") +
  annotate("text", x = 1.65, y = 0.885, label = "Focus A (Running Club)",
           size = 3.9, fontface = "bold") +
  annotate("text", x = 0.55, y = 0.115, label = "Focus B (History Class)",
           size = 3.9, fontface = "bold") +
  annotate("text", x = 1.65, y = 0.115, label = "Focus B (History Class)",
           size = 3.9, fontface = "bold") +
  annotate("text", x = s1$p1[1], y = s1$p1[2] - 0.075, label = "Person 1",
           size = 3.9, fontface = "bold", hjust = 0.5) +
  annotate("text", x = s1$p2[1] + 0.05, y = s1$p2[2], label = "Person 2",
           size = 3.9, fontface = "bold", hjust = 0) +
  annotate("text", x = s2$p1[1], y = s2$p1[2] - 0.075, label = "Person 1",
           size = 3.9, fontface = "bold", hjust = 0.5) +
  annotate("text", x = s2$p2[1] + 0.05, y = s2$p2[2], label = "Person 2",
           size = 3.9, fontface = "bold", hjust = 0) +
  scale_fill_manual(values = c(blue = blue, green = green, orange = orange),
                    guide = "none") +
  coord_cartesian(xlim = c(0, 2.2), ylim = c(0, 1), clip = "off") +
  theme_void() +
  theme(plot.margin = margin(8, 10, 8, 10))

ggsave("images/indirect-contagion.png", p, width = 8.25, height = 3.75,
       dpi = 200, bg = "white")
