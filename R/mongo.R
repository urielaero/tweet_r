library(rmongodb)

db_backend_cache = new.env(hash=TRUE)

register_mongo_backend <- function() {
    if (!has_backend()) {
        handle = connect()
        assign("db_handle", handle, envir=db_backend_cache)
    }
}

connect <- function() {
    db <- rmongodb::mongo.create()
    if (rmongodb::mongo.is.connected(db) == TRUE) {
        db
    } else {
        FALSE
    }

}

insert_from_df <- function(data, db_collection) {
    inserts = rmongodb::mongo.bson.from.df(data)
    handle = get_db_backend()
    d = 1
    for (t in inserts) {
        tweet_id = data$id[d]
        if (!exist_in_db(tweet_id, db_collection)) {
            print("insertando")
            print(tweet_id)
            rmongodb::mongo.insert(handle, db_collection, t)
        }
        d = d + 1
    }
}

get_collections <- function(db_name) {
    handle = get_db_backend()
    rmongodb::mongo.get.database.collections(handle, db_name)
}

get_db_backend <- function() {
    if (!has_backend()) {
        stop("No backend")
    }
    get("db_handle", envir=db_backend_cache)
}

has_backend <- function() {
    exists("db_handle", envir=db_backend_cache)
}

exist_in_db <- function(id, coll) {
    handle = get_db_backend()
    find = paste('{"id":"',id , '"}',sep="") 
    one = rmongodb::mongo.find.one(handle, coll, find)
    !is.null(one)
}

db_find_all <- function(query, db_collection, limit=0L){
    handle = get_db_backend()
    res = rmongodb::mongo.find.all(handle, db_collection, limit=limit)
    list_obj_to_df(res)
}

list_obj_to_df <- function(list_data) {
    text <- c()
    created <- c()
    id <- c()
    latitude <- c()
    longitude <- c()
    favorited <- c()
    favoriteCount <- c()
    screenName <- c()
    retweetCount <- c()
    retweeted <- c()
    location <- c()
    isRetweet <- c()
    for(data in list_data){
        text <- c(text, data$text)
        favorited <- c(favorited, data$favorited)
        favoriteCount <- c(favoriteCount, data$favoriteCount)
        created_time <- as.POSIXct(data$created)
        if (length(created) == 0) {
            created <- c(created_time)
        } else {
            created <- c(created, created_time)
        }
        id <- c(id, data$id)
        screenName <- c(screenName, data$screenName)
        retweetCount <- c(retweetCount, data$retweetCount)
        retweeted <- c(retweeted, data$retweeted)
        lat <- null_to_na(data$latitude)
        latitude <- c(latitude, lat)
        lon <- null_to_na(data$longitude)
        longitude <- c(longitude, lon)
        loc <- null_to_na(data$location)
        location <- c(location, loc)
        isRetweet <- c(isRetweet, data$isRetweet)
    }

    data.frame(text, favorited, favoriteCount, created, id, screenName, retweetCount, retweeted, isRetweet, latitude, longitude, location, stringsAsFactors=FALSE)
}

null_to_na <- function(val) {
    if (is.null(val)){
        NA
    }else{
        val
    }
}
