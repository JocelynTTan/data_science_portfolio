
library(psych)

setwd("~/Desktop/Research/Dataset")
AskJPM<-read.csv("askjpm.csv")

hist(AskJPM$day)