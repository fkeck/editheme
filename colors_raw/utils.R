
# convert 3 to 6 digits hexadecimal colors
hex_solve_digits <- function(x){
  sel <- stringr::str_subset(x, "^#[:alnum:]{3}$")
  sel <- stringr::str_split(sel, "")
  sel <- purrr::map(sel, function(x) rep(x[2:4], each = 2))
  sel <- purrr::map_chr(sel, function(x) paste(c("#", x), collapse = ""))
  x[stringr::str_detect(x, "^#[:alnum:]{3}$")] <- sel
  return(x)
}

# CSS rgba colors to hexadecimal
rgba_str_hex <- function(x){
  # RGB
  sel <- stringr::str_subset(x, "^rgb\\(.+\\)$")
  sel <- stringr::str_replace_all(sel, "^rgb\\(|\\)$", "")
  sel <- stringr::str_replace_all(sel, "[:blank:]", "")
  sel <- stringr::str_split(sel, ",")
  sel <- purrr::map_chr(sel, function(x) rgb(x[1], x[2], x[3], maxColorValue = 255))
  x[stringr::str_detect(x, "^rgb\\(.+\\)$")] <- sel
  # RGBA
  sel <- stringr::str_subset(x, "^rgba\\(.+\\)$")
  sel <- stringr::str_replace_all(sel, "^rgba\\(|\\)$", "")
  sel <- stringr::str_replace_all(sel, "[:blank:]", "")
  sel <- stringr::str_split(sel, ",")
  sel <- purrr::map_chr(sel, function(x) rgb(x[1], x[2], x[3], as.numeric(x[4]) * 255, maxColorValue = 255))
  x[stringr::str_detect(x, "^rgba\\(.+\\)$")] <- sel

  return(x)
}


process_css <- function(path){
  data <-
    read_css(path) %>%
    tidyr::separate_rows(rule, sep = ", ") %>%
    dplyr::select(rule, property, value) %>%
    dplyr::filter(property %in% c("background", "background-color", "color")) %>%
    dplyr::filter(!grepl("xterm", rule)) %>%
    dplyr::filter(!grepl("url\\(", value)) %>%
    mutate(important = grepl(" !important", value)) %>%
    mutate(value = gsub(" !important", "", value)) %>%
    mutate(value = hex_solve_digits(value)) %>%
    mutate(value = rgba_str_hex(value)) %>%
    dplyr::filter(grepl("^\\.ace", rule))

  return(data)

}
