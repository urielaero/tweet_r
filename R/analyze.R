# range_created(db, "2016-03-14 14:19:05", "2016-03-14 14:32:10")
range_created <- function(data, from, to=NULL) {
    if (is.null(to)) {
        filter_data(data, data$created>from)
    } else {
        filter_data(data, data$created>from & data$created<to)
    }
}

#filter_by_location(d, "Honduras")
filter_by_location <- function(data, location) {
    filter_data(data, data$location == location)
}

# sort_by_favorite(d, DESC=TRUE)
sort_by_favorite <- function(data, DESC=FALSE) {
    sort_data(data, "favoriteCount", DESC=DESC)
}

# filter_by_retweet(d, TRUE)
filter_by_retweet <- function(data, isRetweet=FALSE) {
    filter_data(data, data$isRetweet == isRetweet)
}
