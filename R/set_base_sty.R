
#' Set graphical parameters
#'
#' @param theme A string corresponding to one of the 31 themes available in RStudio (see \code{\link{list_pal}}).
#' If not specified, the function tries to retrieve the active theme using \pkg{rstudioapi}.
#' @param variation An integer ranging from 0 to 5 to select among 6 flavors for each theme.
#'
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#' set_base_sty()
#' }
#'
#' set_base_sty("Tomorrow Night", 3)
#' hist(rnorm(100))
#' plot(iris$Sepal.Length, iris$Petal.Length)
#' barplot(1:10, names.arg = LETTERS[1:10])
#' boxplot(iris$Sepal.Length ~ iris$Species)
#' image(volcano)
#'
#' par(mfrow = c(2, 3))
#' x <- rnorm(100)
#' for(i in list_pal()){
#'    for(j in 0:5){
#'        set_base_sty(i, variation = j)
#'        hist(x)
#'        title(paste(i, j))
#'    }
#' }
#'
set_base_sty <- function(theme = NA, variation = 2){

  pal <- get_pal(theme)
  col_bg <- col_bg(theme)
  col_fg <- col_fg(theme)

  if(variation > length(pal)){
    stop(paste0("The number of variations is limited to ",
                length(pal), " for ", attr(pal, "theme"), "."))
  }
  if(variation == 0){
    col_data <- col_fg
  } else {
    col_data <- pal[variation]
  }

  ed_sty <-
    styles::new_style(par = list(pch = 20,
                         bg = col_bg,
                         fg = col_fg,
                         col.axis = col_fg,
                         col.lab = col_fg,
                         las = 1,
                         col.main = col_fg,
                         col.sub = col_fg,
                         tcl = -0.25,
                         bty = "l"),
              graphics = list(axis = list(hadj = 0.5),
                              hist.default = list(col = col_data,
                                                  border = col_bg,
                                                  main = "",
                                                  ylab = "Count"),
                              plot.xy = list(col = col_data,
                                             lwd = 2.5,
                                             cex = 1),
                              barplot.default = list(col = col_data,
                                                     border = NA,
                                                     space = 0.3),
                              boxplot.default = list(col = scales::alpha(col_data, 0.6),
                                                     border = col_data,
                                                     pars = list(boxwex = 0.8,
                                                                 staplewex = 0.5,
                                                                 outwex = 0.5,
                                                                 cex = 1,
                                                                 whisklty = "solid")),
                              image.default = list(col = colorRampPalette(c(col_bg, col_data))(12)),
                              title = list(line = 2)))

  styles::style(ed_sty)

}
