
## ----load required packages and data-------------------------------------
library(tidyverse);library(readxl)
#options(tibble.print_min = 15)
heights = read_csv("week1/highest-points-by-state.csv")
## switch from feet to meters
heights$elevation = heights$elevation * .3048

## ----print-data----------------------------------------------------------
heights

## ----arrange-data-ascending----------------------------------------------
arrange(heights, elevation)

## ----arrange-data-descending---------------------------------------------
arrange(heights, desc(elevation))

## ----stem-and-leaf-------------------------------------------------------
stem(heights$elevation)

## ----density-estimate----------------------------------------------------
ggplot(heights, aes(x = elevation)) + geom_density()

## ----density-estimate-plus-rug-------------------------------------------
ggplot(heights, aes(x = elevation)) + geom_density() + geom_rug()

