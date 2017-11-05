

#' Color palettes matching RStudio themes
#'
#'The function \code{get_pal} generates a palette of colors according to a provided theme.
#'The list of available themes is returned by \code{list_pal} (see also Details).
#'Palettes can be previewed using the function \code{viz_pal}.
#'
#' @param theme Theme of the palette. A string corresponding to one of the 31 themes available in RStudio (see Details).
#' If not specified, the function tries to retrieve the active theme using \pkg{rstudioapi}.
#' @param n Number of colors to return. Currently limited to 5.
#' @param pal A color palette as returned by \code{get_pal}.
#'
#' @details The available themes are:
#' \code{Ambiance}, \code{Chaos}, \code{Chrome}, \code{Clouds}, \code{Clouds Midnight}, \code{Cobalt},
#' \code{Crimson Editor}, \code{Dawn}, \code{Dracula}, \code{Dreamweaver}, \code{Eclipse}, \code{Idle Fingers},
#' \code{Katzenmilch}, \code{Kr Theme}, \code{Material}, \code{Merbivore}, \code{Merbivore Soft},
#' \code{Mono Industrial}, \code{Monokai}, \code{Pastel On Dark}, \code{Solarized Dark}, \code{Solarized Light},
#' \code{TextMate}, \code{Tomorrow}, \code{Tomorrow Night}, \code{Tomorrow Night 80s}, \code{Tomorrow Night Blue},
#' \code{Tomorrow Night Bright}, \code{Twilight}, \code{Vibrant Ink} and \code{Xcode}.
#'
#' @return A vector of hexadecimal colors with additional attributes.
#'
#' @note The function \code{viz_pal} is directly inspired by the function \code{print.palette}
#' available in the package \pkg{wesanderson} by Karthik Ram.
#'
#' @export
#'
#' @rdname color_palette
#'
#' @examples
#' \dontrun{
#' get_pal()
#' }
#'
#' list_pal()
#' my_pal <- get_pal(theme = "Twilight")
#' viz_pal(my_pal)
#'
#' par(mfrow = c(7, 5))
#' for(i in list_pal()) {viz_pal(get_pal(i))}
#'
get_pal <- function(theme = NA, n){

  if (is.na(theme)) {
      theme <- rstudioapi::getThemeInfo()$editor
  }
  theme <- match.arg(theme, list_pal())
  rules <- c("keyword", "operator", "const_lang", "string", "comment")

  rs_pal_data <- edistyle::rs_pal_data
  sel_theme <- rs_pal_data[rs_pal_data[["theme_name"]] == theme, ]

  pal <- sel_theme[match(rules, rs_pal_data[["rule"]]), ][["value"]]

  if (missing(n)) {
    n <- length(pal)
  }

  if(n > length(pal)) {
    stop(paste0("n is too large, allowed maximum for ",
                theme, " is ", length(pal), "."))
  }

  pal <- pal[1:n]

  attr(pal, "theme") <- theme
  attr(pal, "rules") <- rules
  attr(pal, "background") <- sel_theme[sel_theme$rule == "background", "value"]
  attr(pal, "base_text") <- sel_theme[sel_theme$rule == "base_text", "value"]
  return(pal)
}


#' @export
#' @rdname color_palette
list_pal <- function(){
  rs_pal_data <- edistyle::rs_pal_data
  unique(rs_pal_data[["theme_name"]])
}


#' @export
#' @rdname color_palette
viz_pal <- function(pal){
  n <- length(pal)
  old <- par(mar = rep(1, 4), bg = attr(pal, "background"))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = pal,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1,
       col = rgb(t(col2rgb(attr(pal, "background"))), alpha = 0.8 * 255, maxColorValue = 255),
       border = NA)
  text((n + 1) / 2, 1, labels = attr(pal, "theme"), col = attr(pal, "base_text"))
}


col_bg <- function(theme = NA, fade = 0){
  pal <- get_pal(theme = theme)
  col_bg <- attr(pal, "background")
  col_fg <- attr(pal, "base_text")
  res <- (col2rgb(col_bg) * (1 - fade)) + (col2rgb(col_fg) * fade)
  res <- rgb(res[1], res[2], res[3], maxColorValue = 255)
  return(res)
}

col_fg <- function(theme = NA, fade = 0){
  pal <- get_pal(theme = theme)
  col_bg <- attr(pal, "background")
  col_fg <- attr(pal, "base_text")
  res <- (col2rgb(col_fg) * (1 - fade)) + (col2rgb(col_bg) * fade)
  res <- rgb(res[1], res[2], res[3], maxColorValue = 255)
  return(res)
}
