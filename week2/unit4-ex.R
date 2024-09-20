
## ----load required packages and data-------------------------------------
library(tidyverse)
## the "lattice" package has the singer data
library(lattice)
## the "reshape2" package has the melt function
#install.packages(reshape2)
library(reshape2)
## the "lattice.RData" workspace has the fusion time data
load("~/Documents/Yonsei/homework/lattice.RData")

## ----print-data----------------------------------------------------------
head(singer) 

## ----data-transformation-------------------------------------------------
#subset data
tenor1 = singer |> subset(voice.part == "Tenor 1") 

## ----q-q-norm-----------------------------------------------------------
#random samples from normal vs theoretical normal distribution
ggplot(data.frame(x = rnorm(1000))) +
  stat_qq(aes(sample = x)) +
  geom_abline(aes(slope = 1, intercept = 0))

#random samples from t-dist vs theoretical normal distribution
ggplot(data.frame(x = rt(1000, df = 2))) +
  stat_qq(aes(sample = x)) +
  geom_abline(aes(slope = 1, intercept = 0))

#singer data (samples) vs theoretical normal distribution
ggplot(singer, aes(sample = height)) + 
  stat_qq(distribution = qnorm)
#subset tenor1 data
ggplot(tenor1, aes(sample = height)) + 
  stat_qq(distribution = qnorm) 

## ----box-cox transformation---------------------------------------------
x = seq(0, 5, length.out = 100)[-1]
# build function for box-cox transformation
bc_trans = function(x, tau) {
  if(tau == 0){
    return(log(x))
  }
  return((x^tau - 1) / tau)
}
tau_vec = seq(-.4, 1.4, by = .2)
transforms = sapply(tau_vec, function(tau) bc_trans(x, tau))
transforms_melted = melt(transforms)
transforms_for_plotting = transforms_melted |> mutate(x = x[Var1], tau = tau_vec[Var2])
ggplot(transforms_for_plotting) +
  geom_line(aes(x = x, y = value, color = as.factor(tau))) +
  xlab("Original Data Value") + ylab("Transformed Value")

## ----box-cox to real data-----------------------------------------------
vv = fusion.time |> subset(nv.vv == "VV")
tau_vec = seq(-1, 1, by = .25)
transforms = sapply(tau_vec, function(tau) bc_trans(vv$time, tau))
transforms_melted = melt(transforms)
transforms_for_plotting = transforms_melted |> mutate(tau = tau_vec[Var2])

ggplot(transforms_for_plotting) +
  stat_qq(aes(sample = value)) +
  facet_wrap(~ tau, scales = "free", ncol = 5)
