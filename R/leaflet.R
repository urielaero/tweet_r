require("leaflet")

urlGreen <- "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png"
urlYellow <- "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-yellow.png"
urlRed <- "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png"

markerGreen <- leaflet::makeIcon(iconUrl=urlGreen)
markerYellow <- leaflet::makeIcon(iconUrl=urlYellow)
markerRed <- leaflet::makeIcon(iconUrl=urlRed)

drawMap <- function(tweets) {
    map <- leaflet::leaflet()
    map <- leaflet::addTiles(map)
    for(i in 1:nrow(tweets)){
        tweet <- tweets[i,]
        icon <- markerGreen
        text <- tweet$text
        if (tweet$retweetCount > 0 && tweet$favoriteCount < 49) {
            icon <- markerYellow
            text <- paste(text, " (ret: ", tweet$retweetCount, ") ")
            text <- paste(text, " (fav: ", tweet$favoriteCount, ")")
        } else if(tweet$favoriteCount >= 50) {
            icon <- markerRed
            text <- paste(text, " (fav: ", tweet$favoriteCount, ")")
        }
        lng <- as.numeric(tweet$longitude)
        lat <- as.numeric(tweet$latitude)
        map <- leaflet::addMarkers(map, lng=lng, lat=lat, popup=text, icon=icon)
    }

    map
}


