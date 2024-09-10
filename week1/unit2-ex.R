
## ----load required packages and data-------------------------------------
library(tidyverse)

## ----pipe-line-----------------------------------------------------------
mean(head(seq(.5, 11, by = 1)))
seq(.5, 11, by = 1) |> head() |> mean()

## ----tidy-data-----------------------------------------------------------
## the "tidyverse" package has the following data
table1
table2
table3

## ----non-tidy-data-------------------------------------------------------
table4a
table4b

## ----pivot-longer--------------------------------------------------------
#gather
table4a_new <- table4a |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases") |>  # names_to: new variable to define # values_to: column in data
  head(n = 3)

table4b_new <- table4b |>
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")

table4a_new |> left_join(table4b_new, by = c("country", "year"))
#head(pivot_longer(table4a, c(`1999`, `2000`), names_to = "year", values_to = "cases"), n = 3)

## ----pivot-wider---------------------------------------------------------
#spread
table2 |> 
  pivot_wider(names_from = type, values_from = count) # not a tidy data. observation is scattered

## ----tibbles-------------------------------------------------------------
(df = data.frame("a" = 1:5, "b 2" = 5:1))

(ti = tibble("a" = 1:5, "b 2" = 5:1))

df$c
ti$c

df[,1]
ti[,1]

df$b
ti$b

## ----separate------------------------------------------------------------
(df_test = data.frame(t = c("a b", "a c", "a c d")))
df_test |> separate(t, into = c("position 1", "position 2"))
df_test |> separate(t, into = c("position 1", "position 2", "position 3"))

## ----mutate--------------------------------------------------------------
(df_test = data.frame(a = sample(10), b = sample(10, replace = TRUE)))
df_test |> mutate(sum = a + b, 
                  log_ratio = log(a/b))

## ----arrange-------------------------------------------------------------
(df_test = data.frame(a = sample(10), b = sample(10, replace = TRUE)))
df_test |> arrange(a)