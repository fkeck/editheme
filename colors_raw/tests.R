
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)


twi_pal <- function() {scales::manual_pal(c("#232323", "#232323", "#232323"))}

scale_colour_twilight <- function(...) {discrete_scale("colour", "twilight", twi_pal(), ...)}
scale_color_twilight <- scale_color_twilight

ggplot(df) +
  geom_point(aes(gp, y, color = gp)) +
  scale_twilight() +
  theme(plot.background = element_rect(fill = "#232323"),
        panel.background = element_rect(fill = "#141414"), panel.grid.major = element_line(color = "#232323")) +

theme_minimal()





devtools::load_all("C:/Users/fske0001/Downloads/css-master/css-master")
library(css)
library(magrittr)
library(dplyr)
library(ggplot2)
library(purrr)

dracula <- paste0(
  "https://raw.githubusercontent.com/rstudio/rstudio/",
  "0d9d49aa8671527370c6c261fc031ae8a8081c45/src/gwt/src/",
  "org/rstudio/studio/client/workbench/views/source/editors/text/themes/dracula.css"
)

list_css <- list.files(path = "inst/themes/", pattern = "\\.css$", full.names = TRUE)

# reading it with read_css

all_themes <- map(list_css, process_css)
names(all_themes) <- gsub("\\.css$", "", list.files(path = "inst/themes/", pattern = "\\.css$"))
all_themes <- bind_rows(all_themes, .id = "theme")

filter(all_themes, rule %in% c(".ace_editor",
                               ".ace_keyword",
                               ".ace_keyword.ace_operator",
                               ".ace_constant.ace_language",
                               ".ace_comment",
                               ".ace_string"
                               )) %>%
  arrange(theme, rule) %>%
  write.csv("inst/themes_data.csv", col.names = F)

plot(rep(0, length(data$value)), 1:length(data$value), col = data$value, pch = 20, cex = 5)
text(rep(0, length(data$value)), 1:length(data$value), data$rule, pos = 2)
text(rep(0, length(data$value)), 1:length(data$value), IDPmisc::col2hsv(data$value)[3,], pos = 4)




better <- new_style(par = list(pch = 16,
                               fg = grey(0.6),
                               col.axis = grey(0.4),
                               col.lab = grey(0.2),
                               las = 1,
                               col.main = grey(0.4),
                               col.sub = grey(0.4),
                               tcl = -0.25,
                               bty="l"),
                    graphics = list(axis = list(hadj = 0.5),
                                    hist.default = list(col = "navyblue",
                                                        border = "white",
                                                        main = "",
                                                        ylab = "count"),
                                    plot.xy = list(col = "navyblue",
                                                   lwd = 2.5,
                                                   cex = 1.1),
                                    barplot.default = list(col = "navyblue",
                                                           border = NA,
                                                           space = 0.3),
                                    boxplot.default = list(col = scales::alpha("navyblue", 0.5),
                                                           border = "navyblue",
                                                           pars = list(boxwex = 0.8,
                                                                       staplewex = 0.5,
                                                                       outwex = 0.5,
                                                                       cex = 1,
                                                                       whisklty = "solid")),
                                    title = list(line = 2)))
