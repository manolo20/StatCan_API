library(httr)
library(jsonlite)
library(lubridate)
library(tidyverse)

# We want to keep characters as characters and not factors
options(stringsAsFactors = FALSE) 

# We specify the URL and get it 
url <- "http://www.statcan.gc.ca/sites/json/ind-all.json"
raw.result <- GET(url = url)

# Let's see what our results are:
names(raw.result)

# Let's see the status code if we get the request worked without any issues (we expect to get 200)
raw.result$status_code

# Codes:
# 1XX - Informational
# 2XX - Success
# 3XX - Client Error 
# 4XX - Server Error 

# We transform the data set into text
this.raw.content <- rawToChar(raw.result$content)

# Parsing to a readable R list
content <- fromJSON(this.raw.content)

# A little bit of data cleaning
example <- content$results$indicators %>% select(geo_code, title, release_date, growth_rate)

a<-example$geo_code
b<-example$title$en
c<-example$release_date
d<-example$growth_rate$growth$en
e<-example$growth_rate$details$en

data<-cbind(Geography=a,Item=b,Release=c,Growth=d,Change=e)
