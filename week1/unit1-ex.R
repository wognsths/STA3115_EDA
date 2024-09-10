
## ----load required packages and data-------------------------------------
library(tidyverse);library(readxl);library(tidyr);library(data.table)
#options(tibble.print_min = 15)
heights = read_csv("week1/highest-points-by-state.csv")
heights %>% arrange(., by = desc(elevation))

stem(heights$elevation)

ggplot(heights, aes(x = elevation)) + geom_density() +
  geom_rug()

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

