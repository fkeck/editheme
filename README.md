[![Build Status](https://travis-ci.org/fkeck/xxx)

# editheme

### Palettes and graphics matching your RStudio editor
The package editheme provides a collection of color palettes designed to match the different themes available in RStudio. It also includes functions to customize 'base' and 'ggplot2' graphs styles in order to harmonize the look of your favorite IDE.

### Install
To install the package from Gihub you can use devtools:

    devtools::install_github("fkeck/editheme")

### Palettes
Print the list of available palettes with list_pal:

list_pal()

Get one specific palette with get_pal and visualize it with viz_pal:

my_pal <- get_pal(theme = "Twilight")
viz_pal(my_pal, print.hex = TRUE)

get_pal is smart, if you are using RStudio, it can find automatically the palette matching your current theme using rstudioapi, just type:
get_pal()

### Customizing base graphics
To change the look of base graphics editheme uses the styles package.
The function set_base_sty modifies the graphical parameters and the behavior of different generic plotting functions.

set_base_sty("Tomorrow Night", 3)
hist(rnorm(100))
plot(iris$Sepal.Length, iris$Petal.Length)
barplot(1:5, names.arg = LETTERS[1:5])
boxplot(iris$Sepal.Length ~ iris$Species)
image(volcano)

### Customizing ggplot2 graphics
ggplot2 integrates a system of 
