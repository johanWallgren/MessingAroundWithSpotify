# ui

##########################################################################
# Set initial state
library(shiny)
library(tidyverse)
library(RColorBrewer)
library(shinythemes)

load('./artistData.RData')

normalizeData <- function(data){
  normData <- (data - min(data)) / (max(data) - min(data))
  return(normData)
}

# energy
# loudness
# speechiness
# acousticness
# instrumentalness
# liveness
# valence
# tempo
# track_popularity

ad <<- artistData %>%
  mutate(energy = normalizeData(energy)) %>%
  mutate(loudness = normalizeData(loudness)) %>%
  mutate(speechiness = normalizeData(speechiness)) %>%
  mutate(acousticness = normalizeData(acousticness)) %>%
  mutate(instrumentalness = normalizeData(instrumentalness)) %>%
  mutate(liveness = normalizeData(liveness)) %>%
  mutate(valence = normalizeData(valence)) %>%
  mutate(tempo = normalizeData(tempo)) %>%
  mutate(track_popularity = normalizeData(track_popularity))

##########################################################################
# UI
ui <- fluidPage(theme = shinytheme("cyborg"),
                titlePanel("MessingAroundWithSpotify"),
                sidebarLayout(
                  sidebarPanel(width = 3,
                               ####################################
                               # Sidebar panel
                               
                               # energy
                               sliderInput(
                                 "energy",
                                 label = "Select range for energy:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # loudness
                               sliderInput(
                                 "loudness",
                                 label = "Select range for loudness:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # speechiness
                               sliderInput(
                                 "speechiness",
                                 label = "Select range for speechiness:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # acousticness
                               sliderInput(
                                 "acousticness",
                                 label = "Select range for acousticness:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # instrumentalness
                               sliderInput(
                                 "instrumentalness",
                                 label = "Select range for instrumentalness:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # liveness
                               sliderInput(
                                 "liveness",
                                 label = "Select range for liveness:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # valence
                               sliderInput(
                                 "valence",
                                 label = "Select range for valence:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               ),
                               # tempo
                               sliderInput(
                                 "tempo",
                                 label = "Select range for tempo:",
                                 min = 0,
                                 max = 1,
                                 value = c(0,1),
                                 sep = '',
                                 step = 0.05,
                                 width = '350px'
                               )


                  ),
                  ####################################
                  # Main panel
                  
                  mainPanel(
                    
                    tableOutput(outputId = 'tableOfSongs')

  
                  ))
                  
                )
