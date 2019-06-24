library(tidyverse)      # data manipulation & plotting
library(stringr)        # text cleaning and regular expressions
library(tidytext)       # provides additional text mining functions
library(lubridate)
library(readxl)

jpm <- read_excel("AskJPM.xls")
head(jpm)


jpm$date.char <- as.character(jpm$date)
data$date1 <- dmy_hm(jpm$date.char)