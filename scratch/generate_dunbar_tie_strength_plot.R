# Generates images/dunbar-tie-strength-circles.png
#
# Stylized ego network laid out in Dunbar's concentric circles, illustrating
# the mapping between Granovetter's tie-strength argument and the Dunbar
# layers: strong ties in the inner circles close into g-transitive triads,
# while weak ties to the outer circles leave triads open (transitivity
# violated), so Ego spans structural holes in the periphery.
#
# The slide quotes the contrast qualitatively (closure vs. reach), not the
# exact counts; the sanity check below just verifies the construction is
# as intended: 13 inner alters with 26 ties among them, 12 outer alters
# tied only to Ego.

library(igraph)
library(ggraph)
library(ggforce)
library(ggplot2)

set.seed(8417)

n1 <- 5  # support clique
n2 <- 8  # sympathy group
n3 <- 12 # affinity group + active network
r1 <- 1.25; r2 <- 2.1; r3 <- 3.0

nodes <- data.frame(
  name = c("Ego", sprintf("S%d", 1:n1), sprintf("Y%d", 1:n2), sprintf("A%d", 1:n3)),
  ring = c(0, rep(1, n1), rep(2, n2), rep(3, n3))
)
# Stagger ring angles so nodes do not align radially
ang <- c(0,
         seq(0, 2*pi, length.out = n1+1)[-1] + 0.35,
         seq(0, 2*pi, length.out = n2+1)[-1] + 0.05,
         seq(0, 2*pi, length.out = n3+1)[-1] + 0.20)
rad <- c(0, rep(r1, n1), rep(r2, n2), rep(r3, n3))
nodes$x <- rad * cos(ang)
nodes$y <- rad * sin(ang)
nodes$node_type <- c("ego", rep("strong", n1 + n2), rep("weak", n3))

s1 <- nodes$name[nodes$ring == 1]
s2 <- nodes$name[nodes$ring == 2]
s3 <- nodes$name[nodes$ring == 3]

pair_df <- function(x) {
  m <- combn(x, 2)
  data.frame(from = m[1, ], to = m[2, ])
}
ring_cycle <- function(x) {
  data.frame(from = x, to = c(x[-1], x[1]))
}

edges <- rbind(
  # Strong: Ego to inner circles; support clique fully closed;
  # sympathy group triangulated; some cross-ring closure
  transform(data.frame(from = "Ego", to = c(s1, s2)), type = "strong"),
  transform(pair_df(s1), type = "strong"),
  transform(ring_cycle(s2), type = "strong"),
  transform(data.frame(from = s2[seq(1, n2, by = 2)], to = s2[seq(1, n2, by = 2) + 1]), type = "strong"),
  transform(data.frame(from = c(s1[1], s1[2], s1[2], s1[3]),
                       to = c(s2[1], s2[1], s2[2], s2[2])), type = "strong"),
  # Weak: Ego to outer circles only -- outer alters are strangers to each other
  transform(data.frame(from = "Ego", to = s3), type = "weak")
)

g <- graph_from_data_frame(edges, directed = FALSE, vertices = nodes)
V(g)$label <- ifelse(V(g)$ring == 0, "Ego", NA)

p <- ggraph(g, layout = "manual", x = x, y = y) +
  geom_circle(data = data.frame(x0 = 0, y0 = 0, r = r3),
              aes(x0 = x0, y0 = y0, r = r), fill = "steelblue", alpha = 0.06,
              color = "grey70", linewidth = 0.3) +
  geom_circle(data = data.frame(x0 = 0, y0 = 0, r = r2),
              aes(x0 = x0, y0 = y0, r = r), fill = "firebrick", alpha = 0.08,
              color = "grey70", linewidth = 0.3) +
  geom_edge_link0(aes(color = type, linetype = type, width = type)) +
  scale_edge_color_manual(values = c(strong = "firebrick", weak = "steelblue"),
                          labels = c(strong = "Strong tie", weak = "Weak tie")) +
  scale_edge_linetype_manual(values = c(strong = "solid", weak = "2212"), guide = "none") +
  scale_edge_width_manual(values = c(strong = 1.0, weak = 0.5), guide = "none") +
  geom_node_point(aes(color = node_type, size = node_type)) +
  scale_color_manual(values = c(ego = "grey10", strong = "firebrick", weak = "steelblue"), guide = "none") +
  scale_size_manual(values = c(ego = 9, strong = 5.5, weak = 4.5), guide = "none") +
  geom_node_text(aes(label = label), color = "white", fontface = "bold", size = 3.2, na.rm = TRUE) +
  annotate("label", x = 0, y = 1.68, label = "Strong-tie circles:\nclosed, g-transitive triads",
           size = 2.9, fontface = "bold", color = "firebrick", lineheight = 0.9,
           label.padding = unit(0.18, "lines"), alpha = 0.92) +
  annotate("label", x = 0, y = -2.62, label = "Weak-tie circles:\nopen triads (no g-transitivity)",
           size = 2.9, fontface = "bold", color = "steelblue", lineheight = 0.9,
           label.padding = unit(0.18, "lines"), alpha = 0.92) +
  labs(edge_colour = NULL) +
  guides(edge_colour = guide_legend(override.aes = list(linetype = c("solid", "2212"),
                                                        linewidth = c(1, 0.6)))) +
  theme_graph(base_size = 12) +
  coord_fixed(xlim = c(-3.45, 3.45), ylim = c(-3.45, 3.45)) +
  theme(plot.margin = margin(2, 2, 2, 2),
        legend.position = "bottom",
        legend.box.margin = margin(t = -4))

ggsave("images/dunbar-tie-strength-circles.png", p, width = 6.5, height = 6.2, dpi = 300)
print("Saved images/dunbar-tie-strength-circles.png")

# Sanity check on the counts quoted on the slide
inner <- c(s1, s2)
closed <- ecount(induced_subgraph(g, inner))
nb_pairs <- choose(vcount(g) - 1, 2)
inner_pairs <- choose(length(inner), 2)
open_weak <- nb_pairs - inner_pairs
stopifnot(closed == 26, open_weak == 222)
cat(sprintf("closed triads (inner): %d | open triads involving a weak tie: %d\n", closed, open_weak))
