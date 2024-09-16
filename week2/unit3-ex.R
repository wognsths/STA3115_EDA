
## ----load required packages and data-------------------------------------
library(tidyverse)
## the "lattice" package has the singer data
library(lattice)

## ----print-data----------------------------------------------------------
head(singer) 

## ----data-transformation-------------------------------------------------
#subset data
tenor1 = singer |> subset(voice.part == "Tenor 1") 
bass2 = singer |> subset(voice.part == "Bass 2")
tenor1_or_bass2 = singer |> subset(voice.part %in% c("Tenor 1", "Bass 2")) 

## ----histogram-----------------------------------------------------------
ggplot(tenor1, aes(x = height)) + geom_histogram()
#try different bin number
ggplot(tenor1, aes(x = height)) + geom_histogram(bins = 10) 

## ----density-------------------------------------------------------------
ggplot(tenor1, aes(x = height)) + geom_density()
#density with rug
ggplot(tenor1, aes(x = height)) +
  geom_density(adjust = .3) +
  geom_rug(aes(y = 0), sides = "b", 
           position = position_jitter(height = 0))

## ----histograms-for-comparison-------------------------------------------
#histograms
ggplot(tenor1_or_bass2) +
  geom_histogram(aes(x = height, fill = voice.part),
                 alpha = .5, position = "dodge")
#density plots
ggplot(tenor1_or_bass2) +
  geom_density(aes(x = height, fill = voice.part), alpha = .5)

## ----plot-ecdf-----------------------------------------------------------
ggplot(tenor1, aes(x = height)) + stat_ecdf() +
  xlab("height") +
  ylab("probability") + 
  ggtitle("ECDF for Tenor 1")

ggplot(bass2, aes(x = height)) + stat_ecdf() +
  xlab("height") +
  ylab("probability") + 
  ggtitle("ECDF for Bass 2")

## ----quantile-plots------------------------------------------------------
#by hand
n.tenor1 = nrow(tenor1)
f.value = (0.5:(n.tenor1 - 0.5))/n.tenor1
tenor1 = tenor1 |> 
  arrange(height) |> 
  mutate(f.value = f.value) 
ggplot(tenor1, aes(x = f.value, y = height)) +
  geom_line() +
  geom_point()

n.bass2 = nrow(bass2)
f.value = (0.5:(n.bass2 - 0.5))/n.bass2
bass2 = bass2 |> 
  arrange(height) |> 
  mutate(f.value = f.value)
ggplot(bass2, aes(x = f.value, y = height)) +
  geom_line() +
  geom_point()

## ----q-q-plot-----------------------------------------------------------
#using base R function to generate a dataframe

qq.df = as.data.frame(qqplot(tenor1$height, bass2$height,
                             plot.it = FALSE))
ggplot(qq.df, aes(x = x, y = y)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  xlim(c(64, 76)) +
  ylim(c(64, 76)) +
  xlab("Tenor 1") + ylab("Bass 2")

## ----m-d-plot-----------------------------------------------------------
ggplot(qq.df, aes(x = (x+y)/2, y = y-x)) +
  geom_point() +
  geom_abline(slope = 0, intercept = 0) +
  xlab("Mean") + ylab("Difference")

## ----summary-statistics-------------------------------------------------
singer |> 
  group_by(voice.part) |> 
  summarise(mean = mean(height),
            sd = sd(height),
            median = median(height),
            mad = mad(height),
            iqr = IQR(height))

## ----box-plot-----------------------------------------------------------
ggplot(tenor1, aes(x = "Height", y = height)) +
  geom_boxplot()

ggplot(singer, aes(x = voice.part, y = height)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle("Boxplot of singer's heights by voice part") +
  ylab("Height") + xlab("Voice part")
