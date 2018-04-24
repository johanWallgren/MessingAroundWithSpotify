# ui

##########################################################################
# Set initial state
library(shiny)
library(tidyverse)
library(shinythemes)
library(spotifyr)
library(httr)

source('./get_artist_audio_features_mod.R')
source('./get_user_playlists.R')
source('./get_related_artists.R')
source('./normalizeData.R')

# Update these two:
# https://beta.developer.spotify.com/console/post-playlists/
access_tokenCreate <<- 'BQB7pNmnWudTq68Uu5uzxHpNR5L9OKoXT2NOM-3rqdPV4TNdod_QKHhd7Ow9reFyYHV_Cws0gcQNgcnno80ymjPRE9c_QboCRqZRIThWegcGNbypzu27jVNSG1ln9Db2EyHbjVhWxJ8V2BU1NglUzMxXqFKUkR0FW5_9gS7yn2gdT0P2Me4FvkAn1G8YtPBH7Ufeg5rOLoSzCXusaN-bwNCixCFIWavSA_byXtI'

# User information
user <<- 'dn1mre3xxwdhwg9m9oxoes8tu'
Sys.setenv(SPOTIFY_CLIENT_ID = '21fae2a08aad434d9da510b25f09de90') # Not my real client id
Sys.setenv(SPOTIFY_CLIENT_SECRET = '8d3588f452d445329ab8d1c5d8e5cb7a') # Not my real client secret

##########################################################################
# UI
ui <- fluidPage(theme = shinytheme("cyborg"),
                titlePanel("MessingAroundWithSpotify"),
                sidebarLayout(
                  sidebarPanel(width = 3,
                               ####################################
                               # Sidebar panel
                               
                               textInput("startArtist", "Choose artist", "Avicii"),
                               actionButton("importRelatedArtist", "Go!"),
                               
                               # energy
                               sliderInput(
                                 "energy",
                                 label = "Select range for energy:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # loudness
                               sliderInput(
                                 "loudness",
                                 label = "Select range for loudness:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # speechiness
                               sliderInput(
                                 "speechiness",
                                 label = "Select range for speechiness:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # acousticness
                               sliderInput(
                                 "acousticness",
                                 label = "Select range for acousticness:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # instrumentalness
                               sliderInput(
                                 "instrumentalness",
                                 label = "Select range for instrumentalness:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # liveness
                               sliderInput(
                                 "liveness",
                                 label = "Select range for liveness:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # valence
                               sliderInput(
                                 "valence",
                                 label = "Select range for valence:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # tempo
                               sliderInput(
                                 "tempo",
                                 label = "Select range for tempo:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # danceability
                               sliderInput(
                                 "danceability",
                                 label = "Select range for danceability:",
                                 min = -1,
                                 max = 1,
                                 value = c(-1,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               )


                  ),
                  ####################################
                  # Main panel
                  
                  mainPanel(
                    actionButton("createPlaylist", "Playlist!"),
                    textOutput(outputId = "doneText"),
                    tableOutput(outputId = 'tableOfSongs')

  
                  ))
                  
                )
