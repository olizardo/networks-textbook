# Schematic of household technology diffusion (S-curves) anchored to measured midpoints.
# Run from the repo root: source("images/make_diffusion_schematic.R")
#
# Each curve's midpoint (year at 50% adoption) comes from the source named in `midpt_source`.
# Where the source gives two measured points, the midpoint is linearly interpolated.
# Curve steepness is illustrative and is not estimated from the data.
# Cellphone is omitted: the available Pew series starts at 62% (2002), so it has no measured 50% point.

library(ggplot2)

years <- seq(1880, 2010, by = 1)

techs <- data.frame(
  name = c("Telephone", "Electricity", "Automobile", "Radio", "Color TV",
           "Air conditioning", "Personal computer", "Internet"),
  midpt = c(1945, 1925, 1948, 1932, 1971, 1976, 2000, 2001),
  steep = c(0.12, 0.10, 0.12, 0.18, 0.20, 0.16, 0.20, 0.25),
  denom = c("housing units", "dwelling units", "households", "households",
            "TV households", "occupied housing units", "households", "households"),
  midpt_source = c(
    "telephone in housing units, Census decennial 1940 (36.9%) and 1950 (61.8%), interpolated",
    "electric service in dwelling units, Census 1920 (34.7%) and 1930 (68.2%), interpolated",
    "automobile ownership, households, 1948 (50%)",
    "radio ownership, households, 1930 (40%) and 1934 (60%), interpolated",
    "color sets, TV households, 1971 (about 48%) and 1972 (first year above 50%)",
    "air conditioning, occupied housing units, 1970 (35.8%) and 1980 (58.5%), interpolated",
    "computer ownership, CPS households, 2000 (51%)",
    "home Internet use, CPS households, 2001 (50.4%)"
  ),
  stringsAsFactors = FALSE
)

techs$label <- paste0(techs$name, " (% of ", techs$denom, ")")

curves <- do.call(rbind, lapply(seq_len(nrow(techs)), function(i) {
  data.frame(
    year = years,
    share = 100 / (1 + exp(-techs$steep[i] * (years - techs$midpt[i]))),
    tech = techs$label[i],
    stringsAsFactors = FALSE
  )
}))

curves$tech <- factor(curves$tech, levels = techs$label)

p_schematic <- ggplot(curves, aes(x = year, y = share, color = tech)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(values = c(
    "#264653", "#2A9D8F", "#E9C46A", "#F4A261",
    "#E76F51", "#8AB17D", "#6D597A", "#355070"
  )) +
  labs(
    x = "Year",
    y = "Adoption (%)",
    color = NULL,
    caption = "Midpoints are measured; curve shapes are illustrative. Sources are listed in the deck's sources slide."
  ) +
  scale_y_continuous(limits = c(0, 100), breaks = c(0, 25, 50, 75, 100)) +
  theme_minimal(base_size = 18) +
  theme(
    legend.position = "right",
    legend.text = element_text(size = 15),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(face = "italic", size = 13, hjust = 0)
  )

ggsave(
  filename = "images/diffusion_schematic.png",
  plot = p_schematic,
  width = 10,
  height = 6,
  dpi = 200
)

p_schematic
