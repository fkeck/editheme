
#' Palettes for RStudio editor themes
#'
#' A dataset containing the hexadecimal colors of various syntax items for 31 RStudio editor themes.
#'
#' @format A data frame with 4 columns.
#' \describe{
#'   \item{\code{theme}}{The theme (CSS reference).}
#'   \item{\code{theme_name}}{The theme name in Rstudio.}
#'   \item{\code{rule}}{The interface element or syntax item to be coloured.}
#'   \item{\code{value}}{The color (hexadecimal 6 digits format).}
#' }
#'
#' @source
#' Colors were extracted from the CSS file of each theme
#' (\href{https://github.com/rstudio/rstudio/tree/master/src/gwt/src/org/rstudio/studio/client/workbench/views/source/editors/text/themes/}{RStudio Github})
"rs_pal_data"
