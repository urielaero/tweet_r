
save_tweets <- function() {
   register_mongo_backend()
   tweets = get_tweets_df("#data", 5)
   insert_from_df(tweets, "tweetr.tweets")
}
