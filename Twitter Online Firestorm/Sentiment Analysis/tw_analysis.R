setwd('/Users/xiaotonghe/Documents/research/tw_data')
library(tidytext)
library(tidyr)
library(dplyr)
library(readr)
raw_data<-read.csv('0410_0510.csv')
str(raw_data)


#data_preprocessing:
raw_data$text.1 <- gsub("(ftp|http)(s?)://.*\\b", "", raw_data$text) #remove URLs (http, https, ftp) 
raw_data$text.1 <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)","",raw_data$text.1) #remove people name. RT's
raw_data$text.1<- gsub("@\\w+","",raw_data$text.1) # remove names
raw_data$text.1 <- gsub("http[^[:blank:]]+","",raw_data$text.1) # remove html
raw_data$text.1<-gsub('#\\S+', '', raw_data$text.1)#remove hashtag
raw_data$text.1<-gsub('[[:punct:]]', '', raw_data$text.1)#remove punctuation
raw_data$text.1<-gsub("^[[:space:]]*","",raw_data$text.1) #Remove leading whitespaces
raw_data$text.1<-gsub("[[:space:]]*$","",raw_data$text.1)#Remove trailing whitespaces
raw_data$text.1<-gsub(' +',' ',raw_data$text.1) #Remove extra whitespaces
#write_csv(raw_data,'/Users/xiaotonghe/Documents/research/tw_data/data_cleaned.csv')


#tokenization of words into tidy dataframe
#group by id,each text is split into words in new colomn 'word'
tidy_data<- raw_data %>%
  group_by(id) %>%
  unnest_tokens(word,text.1)%>%
  ungroup()
#write_csv(tidy_data,'/Users/xiaotonghe/Documents/research/tw_data/tidy_data.csv')


#remove stop_words using default stop_words of tidytext package
data("stop_words")
tidy_data_stop<-tidy_data%>%
  anti_join(stop_words)
#write_csv(tidy_data_stop,'/Users/xiaotonghe/Documents/research/tw_data/tidy_data_nostop.csv')


#word counts in text.1
text_words_counts<-tidy_data_stop%>%count(word,sort = TRUE)
head(text_words_counts,10)


#nrc dict
lexi<- get_sentiments('nrc')%>%filter(sentiment %in% c("positive","negative"))
lexi_word<-get_sentiments('nrc')%>%filter(word %in% c("united","airline"))

#get sentiments for each word
abc_nrc<-tidy_data_stop%>%
  inner_join(get_sentiments("nrc"),by='word')%>%
  ungroup()

#sentiments counts
sentiments_count<-abc_nrc%>%
  filter(sentiment %in% c("positive","negative"))%>%
  group_by(sentiment)%>%
  count(sentiment)

#match ratio:
#negative=17832
#positive=25660
#total_words=185468
#(17832+25660)/185468 =0.23449













  
















