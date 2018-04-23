library(spotifyr)
library(tidyverse)
library(httr)

# These expire, needs to be updated
access_tokenCreate <- 'BQC9lzahE-1bqjPj9Z1ITKDjXaUe5JX-6KWN1aMR-LwTZ1YcUCXuUpoth9H5zyM36bchHM4jM6p6AckteM_XuQVIe9lQu5jrAF-463LsxuEMSOr4XhgdOWJcD5PfEq654M3X_YXAe335MrYYc5H5Y-6YYyrG9i58q2QHQlUbV-j6Az6u8sXXFp7kOtN4KgOEIygG5zoxHEmEGS0wtIClzA9Z2br73to5sGWep9E'
access_tokenAdd <- 'BQDTAk0y4regGeiqTMXXjAekjN2FBpsaepFBcO_csuVWYoyLvXoSYwK-tb3XfQG-IIIhSbIVB-J-5emLUYKitwmAm8JHJhzrzNPwXTPfnaeIzHYDkd4cHbLeAaihMOLdyGYcOuzm4eV3y2WrTOsopUqIOdpiGDsSMPaoITQo2YDVuKuRo2K3wfuCpNSfVTtmOzv9Kz02Tp8Y5SsppOBxTTzOOas7kdWqPPQNz_Y'

# User information
user <- 'dn1mre3xxwdhwg9m9oxoes8tu'
Sys.setenv(SPOTIFY_CLIENT_ID = '21fae2a08aad434d9da510b25f09de90')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '8d3588f452d445329ab8d1c5d8e5cb7a')

# Name of playlist to be created
playlistName <- 'MAWS01'

load('./artistData.RData')
ad <- artistData
#######################################################
# Artist to get related arists for
startArtist <- 'Avicii'

#######################################################
# Get related artists
relatedArtists <- get_related_artists(startArtist)
allArists <- c(startArtist, relatedArtists$artist_name)

#######################################################
# Create playlist
url <- paste0("https://api.spotify.com/v1/users/", user, "/playlists")

bodyText <- paste0('{"name": "', playlistName,'","public": true}')

res <- POST(
  url,
  accept_json(),
  query = list(access_token = access_tokenCreate),
  body = bodyText,
            content_type_json(),
  encode = 'form',
  httr::config(http_version = 2),
  verbose()
) %>%
  content

#######################################################
# Get playlist data
# File copied from Rcharlie, https://github.com/charlie86/ since not in library yet
userPlaylists<- get_user_playlists(user)

# Selecting all playlists with name == playlistName
playlistURIs <- filter(userPlaylists, playlist_name == playlistName) %>% 
  select(playlist_uri)

# The top playlistURI will be used
playlistURI <- playlistURIs$playlist_uri[1]

#######################################################
# Add track to playlist
# Adds 50 songs to playlist
trackURIs <- c(ad$track_uri[1:50])
textBeforeTracks <- 'spotify%3Atrack%3A'

trackURIsText <- ''
for(i in 1:length(trackURIs)){
  
  trackURIsText <- paste0(trackURIsText, textBeforeTracks, trackURIs[i])
  
  if(i != length(trackURIs)){
    trackURIsText <- paste0(trackURIsText,',')
  }
}

url <- paste0("https://api.spotify.com/v1/users/", user, "/playlists/",playlistURI,
              '/tracks?uris=', trackURIsText)

res <- POST(
  url,
  accept_json(),
  query = list(access_token = access_tokenAdd),
  content_type_json(),
  encode = 'form',
  httr::config(http_version = 2),
  verbose()
) %>%
  content

