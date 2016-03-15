# Install
## devtools::install()

# import
## library(twitter)

# use (with env for twitter API)
## twitter::save_tweets()

# use with db
## data <- twitter::find_data(db_collection="tweetr.tweets")

# analyze

## filter by date
### range_created(data, "2016-03-14 14:19:05", "2016-03-14 14:32:10")

## filter by location
### #filter_by_location(data, "Cancun")

## sort by favoriteCount
### sort_by_favorite(data, DESC=TRUE)


## remove no retweets
### filter_by_retweet(d, TRUE)

## remove retweets
### filter_by_retweet(d)

