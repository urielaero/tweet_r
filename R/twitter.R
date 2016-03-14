library(twitteR)
api_key = Sys.getenv("TWITTER_API_KEY")
api_secret = Sys.getenv("TWITTER_API_SECRET")
access_token = Sys.getenv("TWITTER_ACCESS_TOKEN")
access_token_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
get_tweets_df <- function(search, max) {
    twitteR::setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
    tweets = twitteR::searchTwitter(search, n=max, lang="es")
    twitteR::twListToDF(tweets)
}
