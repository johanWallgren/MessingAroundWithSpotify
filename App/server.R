# server

server <- function(input, output) {
  ################################################
  # Reactive function returning table to plot
  filterAd <- reactive({
    ad <- createAd()
    
    ad <- filter(
      ad,
      energy >= input$energy[1] &
        energy <= input$energy[2] &
        loudness >= input$loudness[1] &
        loudness <= input$loudness[2] &
        speechiness >= input$speechiness[1] &
        speechiness <= input$speechiness[2] &
        acousticness >= input$acousticness[1] &
        acousticness <= input$acousticness[2] &
        instrumentalness >= input$instrumentalness[1] &
        instrumentalness <= input$instrumentalness[2] &
        liveness >= input$liveness[1] &
        liveness <= input$liveness[2] &
        valence >= input$valence[1] &
        valence <= input$valence[2] &
        tempo >= input$tempo[1] &
        tempo <= input$tempo[2] &
        danceability >= input$danceability[1] &
        danceability <= input$danceability[2]
    )
  })
  ################################################
  createAd <- eventReactive(input$importRelatedArtist, {
    relatedArtists <- get_related_artists(input$startArtist)
    allArists <- c(input$startArtist, relatedArtists$artist_name)
    
    access_token <- get_spotify_access_token()
    
    artistData <- as_tibble()
    
    for (i in 1:10) {
      Sys.sleep(2)
      print(paste(i, allArists[i]))
      
      # Does not work if Spotify does not have any tracks with related artist
      
      temp <- as_tibble(get_artist_audio_features_mod(allArists[i]))
      temp <- mutate(temp, 'artist' = allArists[i])
      
      artistData <- bind_rows(artistData, temp)
      rm(temp)
    }
    # energy
    # loudness
    # speechiness
    # acousticness
    # instrumentalness
    # liveness
    # valence
    # tempo
    # danceability
    # track_popularity
    
    artistData %>%
      mutate(energy = normalizeData(energy)) %>%
      mutate(loudness = normalizeData(loudness)) %>%
      mutate(speechiness = normalizeData(speechiness)) %>%
      mutate(acousticness = normalizeData(acousticness)) %>%
      mutate(instrumentalness = normalizeData(instrumentalness)) %>%
      mutate(liveness = normalizeData(liveness)) %>%
      mutate(valence = normalizeData(valence)) %>%
      mutate(tempo = normalizeData(tempo)) %>%
      mutate(danceability = normalizeData(danceability)) %>%
      mutate(track_popularity = normalizeData(track_popularity))
    
  })
  
  ################################################
  output$tableOfSongs <- renderTable({
    outputTable <- filterAd()
    
    outputTable <-
      select(outputTable,
             artist,
             track_name,
             album_name,
             track_popularity) %>%
      arrange(desc(track_popularity)) %>%
      select(-track_popularity) %>%
      rename('Artist' = artist,
             'Track' = track_name,
             'Album' = album_name)
    
    head(outputTable, 25)
    
  })
  
  ################################################
  createPlaylist <- eventReactive(input$createPlaylist, {
    # Code to create playlist goes here
    
  })
  
  
}