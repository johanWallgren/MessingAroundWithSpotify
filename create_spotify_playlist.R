library(spotifyr)
library(tidyverse)
library(httr)

Sys.setenv(SPOTIFY_CLIENT_ID = '21fae2a08aad434d9da510b25f09de90')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '8d3588f452d445329ab8d1c5d8e5cb7a')


user <- 'dn1mre3xxwdhwg9m9oxoes8tu'


url <- paste0("https://api.spotify.com/v1/users/", 
              user, "/playlists")

access_token = get_spotify_access_token()
access_token <- 'BQBIYq-iZQjuFNyW6e9es731oaBRqW8i7EkBYoJdkQUXcmBTZopWoXkKfvoiSDTOg04T-rkwSOsXHIjlrLry1XlizzspsY87iXgoRXv66SFyp3wHcBtqfKJnBVzg44-HsHdsUnjSwKpDFPndqFEjU7OiNidAK4TX8eHKuyqfH-eDAIYlDclWf-EUXatGZLbGlDQN7LA__ZUSJSdVUTZ7nnf-Mx35BK4E2Kmf5vQ'

res <- POST(url, body = list(name = "New Playlist12",
                              description = "Test playlist desc",
                              public = "false"
                         ), query = list(access_token = access_token),
            verbose()) %>% 
  content



