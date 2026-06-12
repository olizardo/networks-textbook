# Global override for ggraph's theme_graph to use "sans" instead of "Arial Narrow"
# to prevent "font family not found in Windows font database" warnings.
theme_graph <- function(base_family = "sans", ...) {
  # Call the real ggraph::theme_graph, passing "sans" as the default
  ggraph::theme_graph(base_family = base_family, ...)
}
