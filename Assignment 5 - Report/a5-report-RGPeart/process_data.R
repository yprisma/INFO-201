### This file contains your main code.
### Feel free to rename it, or use several files instead.
### It should contain the code along the following lines:

library("httr")
library("jsonlite")
library("dplyr")
library("data.table")


setwd("~/../Desktop/School Stuff/Senior Year 2017-2018/Homework Fall Quarter 2017/INFO 201/Assignment 5 - Report/a5-report-RGPeart/")

## 1. create the google civic platform request and httr::GET() the result
##    you need to include your api key in the request

source('keys.R')
my.address <- "930 Big Tree Drive NW"

base.url <- 'https://www.googleapis.com/civicinfo/v2/representatives'
query.params <- list(address=my.address, key = google.key)
response <- GET(base.url, query = query.params)
body <- content(response, "text")

## 2. extract the elected officials' data from the result

results <- fromJSON(body)

## 3. transform the data into a well formatted table

representatives.df <- flatten(results$officials) %>% as.data.frame()
representatives.df[is.na(representatives.df)] <- '-'


## 4. Get state representatives from propublica API
##    you need the respective API key.

base.url.2 <- 'https://api.propublica.org/congress/'
ending.parameters <- "v1/115/house/members.json"
names(propublica.key) <- "X-API-Key"
response.2 <- GET(paste0(base.url.2, ending.parameters), add_headers(.headers = propublica.key), content_type_json())
body.2 <- content(response.2, "text")
results.2 <- fromJSON(body.2)


## 5. transform it in a form you can use for visualizations

pro.representatives.df <- results.2$results$members
pro.representatives.df <- as.data.frame(pro.representatives.df)

pro.representatives.df[is.na(pro.representatives.df)] <- '-'


## 6 & 7. pick a representative and get this representative's info.

# Pramila Jayapal
P.Jayapal <- pro.representatives.df %>% filter(last_name == "Jayapal")

## 8. get her recent votes. Was not sure what it was meant by "recent votes", so I selected all of
##    information regarding votes for Mrs. Jayapal. 
Jayapal.base.uri <- "https://api.propublica.org/congress/v1/members/"
Jayapal.id <- P.Jayapal$id
get.P.Jayapal <- GET(paste0(Jayapal.base.uri, Jayapal.id, "/votes.json"), add_headers(.headers = propublica.key), content_type_json())
Jayapal.body <- content(get.P.Jayapal, "text")
Jayapal.results <- fromJSON(Jayapal.body)

Jayapal.results <- Jayapal.results$results
Jayapal.results <- Jayapal.results$votes
final.results <- as.data.frame(Jayapal.results) %>% flatten()

final.results$agreement <- (final.results$position == "Yes") & (final.results$result == "Passed")
only.trues <- final.results %>% filter(agreement == TRUE)

vote.percentage <- nrow(only.trues) / nrow(final.results) * 100
