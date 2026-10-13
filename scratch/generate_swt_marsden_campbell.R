# Generates images/swt-marsden-campbell.png
#
# Conceptual diagram of Marsden & Campbell's (1984) framework for measuring
# tie strength: exogenous predictors (role relations, similarities) that
# give rise to the latent construct of tie strength, which is revealed
# through observable indicators (subjective closeness, interaction
# frequency, tie duration, social support/exchange).
#
# Replaces the original exported-PPT diagram, which had large empty
# margins, a central box overflowing its container, and misaligned panels.

library(ggplot2)

teal    <- "#1b9e77"
orange  <- "#d95f02"
blue    <- "#3182bd"
greytxt <- "grey30"

panel <- function(xmin, xmax, ymin, ymax, header, fill) {
  list(
    annotate("rect", xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
             fill = scales::alpha(fill, 0.06), color = fill, linewidth = 0.7),
    annotate("rect", xmin = xmin, xmax = xmax, ymin = ymax - 0.8, ymax = ymax,
             fill = fill, color = NA),
    annotate("text", x = (xmin + xmax) / 2, y = ymax - 0.4, label = header,
             size = 4.4, fontface = "bold", color = "white")
  )
}

item <- function(x, y, w, h, label, col) {
  list(
    annotate("rect", xmin = x - w / 2, xmax = x + w / 2, ymin = y - h / 2, ymax = y + h / 2,
             fill = "white", color = col, linewidth = 0.55),
    annotate("text", x = x, y = y, label = label, size = 3.4,
             color = greytxt, lineheight = 0.95)
  )
}

p <- ggplot() +
  xlim(0, 12) + ylim(0, 7) +

  # Left panel: predictors
  panel(0.3, 3.7, 0.3, 6.5, "PREDICTORS (Inputs)", teal) +
  item(2.0, 4.5, 2.9, 1.2, "Role Relations\n(friend, kin, coworker)", teal) +
  item(2.0, 2.9, 2.9, 1.2, "Similarities / Homophily\n(shared foci, demographics)", teal) +
  annotate("text", x = 2.0, y = 1.4,
           label = "Exogenous features that make\na strong tie likely to form",
           size = 3.0, fontface = "italic", color = greytxt, lineheight = 0.95) +

  # Center: latent construct
  annotate("text", x = 6.2, y = 5.35, label = "LATENT CONSTRUCT",
           size = 3.8, fontface = "bold", color = orange) +
  annotate("rect", xmin = 4.9, xmax = 7.5, ymin = 2.6, ymax = 4.9,
           fill = scales::alpha(orange, 0.10), color = orange, linewidth = 0.9) +
  annotate("text", x = 6.2, y = 3.75,
           label = "TIE STRENGTH\n\n(the underlying,\nunobserved bond)",
           size = 4.4, fontface = "bold", color = orange, lineheight = 0.95) +

  # Right panel: indicators
  panel(8.3, 11.7, 0.3, 6.5, "INDICATORS (Outputs)", blue) +
  item(10.0, 4.85, 3.0, 1.0, "Subjective Closeness\n(intimacy & mutual confiding)", blue) +
  annotate("text", x = 10.0, y = 4.13,
           label = "most reliable survey indicator",
           size = 2.7, fontface = "italic", color = orange) +
  item(10.0, 3.35, 3.0, 1.0, "Interaction Frequency\n(how often you communicate)", blue) +
  item(10.0, 2.15, 3.0, 1.0, "Tie Duration\n(how long it has lasted)", blue) +
  item(10.0, 0.95, 3.0, 1.0, "Social Support / Exchange\n(reciprocal aid & services)", blue) +

  # Connecting arrows
  annotate("segment", x = 3.7, xend = 4.9, y = 3.75, yend = 3.75,
           arrow = arrow(length = unit(0.25, "cm"), type = "closed"),
           linewidth = 0.9, color = "grey45") +
  annotate("text", x = 4.3, y = 4.1, label = "shape", size = 3.0,
           fontface = "italic", color = greytxt) +
  annotate("segment", x = 7.5, xend = 8.3, y = 3.75, yend = 3.75,
           arrow = arrow(length = unit(0.25, "cm"), type = "closed"),
           linewidth = 0.9, color = "grey45") +
  annotate("text", x = 7.9, y = 4.1, label = "reveals", size = 3.0,
           fontface = "italic", color = greytxt) +

  theme_void(base_family = "sans") +
  theme(plot.margin = margin(2, 2, 2, 2))

ggsave("images/swt-marsden-campbell.png", p, width = 11, height = 6.2, dpi = 300)
print("Saved images/swt-marsden-campbell.png")
