
# Loading Library
library(tidyverse)
library(leaps)
library(skimr)
library(ggplot2)
library(dplyr)
library(stopwords)


# Create Twitter token API --------------------------------

library(rtweet)

API_Key <- 'JpJOayzuYTvhpnWAhuWOlf44V'
API_Key_Secret <- '0ydxQ5M6k05qYfJON3MgqjnDIukX4IEAAXFWrLmhYA7uWNaPgs'
Access_Token <- '1503956935615279106-j6OWD59SS8mxzA1U2mRPoTGYFgZRs2'
Access_Token_Secret <- 'YfYwCbHe0fmZCd8NqcFqrhEFSolDpSFV7gt2a8XvGZbEn'



twitter_token <- rtweet::create_token(
  app = 'msa_v3',
  consumer_key = API_Key,
  consumer_secret = API_Key_Secret,
  access_token = Access_Token,
  access_secret = Access_Token_Secret
)



# Create API Database ElephanSQL ------------------------

library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")

dbnames <- 'ugrcwdha'
pass <- '37hjgVJNTjCdx6ncq1A6NmoWhRExsrLi'
hosts <- 'topsy.db.elephantsql.com'

con <- dbConnect(drv,
                 dbname = dbnames, 
                 host = hosts,
                 port = 5432,
                 user = dbnames,
                 password = pass
)


# Scrapiing Data Tren

## get list trends indonesia
indo_trends <- get_trends("Indonesia")

indo_trends_1 <- indo_trends %>% select(trend,
                                        url,
                                        tweet_volume) %>% mutate(
                                          date_time = Sys.time()
                                        )
head(indo_trends_1)
## Membuat Table List Top 1 Tren by Day
dbWriteTable(conn = con, 
             name = "Testing_1", 
             value = indo_trends_1[1,], 
             append = TRUE, 
             row.names = TRUE, 
             overwrite=FALSE)



on.exit(dbDisconnect(con)) 