save_tweets <- function(query="#R", limit=5) {
    register_mongo_backend()
    tweets = get_tweets_df(query, limit)
    insert_from_df(tweets, "tweetr.tweets")
}

find_data <- function(query="", limit=10, db_collection="", use_db=FALSE) {
    if (use_db || db_collection != "") {
        register_mongo_backend()
        db_find_all(query, db_collection, limit) #0L for all
    } else {
        get_tweets_df(query, limit)
    }
}

sort_data <- function(data, field, DESC=FALSE) {
    fields <- data[c(field)]
    if (DESC) {
        data[rev(order(fields)),]
    } else {
        data[order(fields),]
    }
}

filter_data <- function(data, range) {
    subset(data, range)
}

