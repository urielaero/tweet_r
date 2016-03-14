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
