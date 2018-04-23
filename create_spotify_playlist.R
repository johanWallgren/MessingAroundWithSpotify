library(spotifyr)
library(tidyverse)
library(httr)



# access_token = get_spotify_access_token()
access_token <- ''

Sys.setenv(SPOTIFY_CLIENT_ID = '21fae2a08aad434d9da510b25f09de90')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '8d3588f452d445329ab8d1c5d8e5cb7a')
user <- 'dn1mre3xxwdhwg9m9oxoes8tu'


url <- paste0("https://api.spotify.com/v1/users/", user, "/playlists")

res <- POST(url,
            accept_json(),
            authenticate(client_id, client_secret),
            body = list(name = "New Playlist12",
                             description = "Test playlist desc",
                             public = "false",
                             access_token = access_token),
            encode = 'form',
            httr::config(http_version = 2),
            verbose()) %>% 
  content


# post <- POST('https://accounts.spotify.com/api/token',
#              accept_json(), authenticate(client_id, client_secret),
#              body = list(grant_type = 'client_credentials'),
#              encode = 'form', httr::config(http_version = 2)) %>% content
