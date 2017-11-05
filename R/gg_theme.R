


#' Theme for \code{ggplot2}
#'
#' @inheritParams ggplot2::theme_grey
#' @param theme A string corresponding to one of the 31 themes available in RStudio (see \code{\link{list_pal}}).
#' If not specified, the function tries to retrieve the active theme using \pkg{rstudioapi}.
#'
#' @export
#'
#' @examples
#'
#' df <- data.frame(
#' gp = factor(rep(letters[1:3], each = 10)),
#' y = rnorm(30)
#' )
#'
#' ggplot(df, aes(gp, y, color = gp, fill = gp)) +
#'   geom_boxplot(color = col_fg(fade = 0.2)) +
#'   labs(title = "A nice plot", subtitle = "This is a demo of edistyle") +
#'   facet_wrap(~gp) +
#'   theme_editor() +
#'   scale_fill_editor()
#'
#' ggplot(iris, aes(Sepal.Length, Petal.Length)) +
#'   geom_point(color = col_fg(fade = 0.2)) +
#'   geom_smooth(color = get_pal()[1], fill = get_pal()[2]) +
#'   labs(title = "Edgar Anderson's Iris Data", subtitle = "This is a demo", caption = "edistyle v.0.1.0") +
#'   theme_editor() +
#'   scale_fill_editor()
#'
theme_editor <- function(theme = NA, base_size = 10, base_family = "sans"){

  pal <- get_pal(theme)
  col_bg <- col_bg(theme)
  col_fg <- col_fg(theme)

  theme_classic(base_family = base_family, base_size = base_size) +
    theme(plot.background = element_rect(fill = col_bg),
          panel.background = element_rect(fill = col_bg, colour = NA),
          axis.line = element_line(colour = col_fg),
          axis.ticks = element_line(colour = col_fg),
          axis.text = element_text(colour = col_fg),
          title = element_text(colour = col_fg),
          legend.background = element_rect(fill = col_bg, color = NA),
          legend.key = element_rect(fill = col_bg, colour = NA, linetype = 0),
          legend.box.background = element_rect(fill = col_bg, colour = NA),
          legend.text = element_text(colour = col_fg),
          strip.background = element_rect(fill = col_fg(theme, fade = 0.2))
          )
}


scale_fill_editor <- function(theme = NA, ...) {
  discrete_scale("fill", "editor", scales::manual_pal(unname(get_pal(theme = theme))), ...)
}

scale_colour_editor <- function(theme = NA, ...) {
  discrete_scale("colour", "editor", scales::manual_pal(unname(get_pal(theme = theme))), ...)
}

scale_color_editor <- scale_colour_editor
