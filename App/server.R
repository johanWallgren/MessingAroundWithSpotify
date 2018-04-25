# server

server <- function(input, output) {
  ################################################
  # Reactive function returning table to plot
  filterAd <- reactive({
    
    ad <- createAd()
    
    ad <<- filter(
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
    
    print('Retreaving related artists!')
    
    relatedArtists <- get_related_artists(input$startArtist)
    allArists <- c(input$startArtist, relatedArtists$artist_name)
    
    access_token <- get_spotify_access_token()
    
    artistData <- as_tibble()
    
    for (i in 1:10) {
      Sys.sleep(2)
      print(paste(i, allArists[i]))
      
      # Does not work if Spotify does not have any tracks with related artist
      temp <- as_tibble(get_artist_audio_features_mod(allArists[i]))
      
      if(length(temp) > 1){
        
        temp <- mutate(temp, 'artist' = allArists[i])
        
        artistData <- bind_rows(artistData, temp)
        rm(temp)
        
      }

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
    
    print('Done retreaving related artists!')
    
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
    
    head(outputTable, 50)
    
  })
  
  ################################################
  ################################################
  output$doneText <- renderText({
    doneText <- doneText()
    doneText <- 'Done!'
    doneText
  })
  
  ################################################
  doneText <- eventReactive(input$createPlaylist, {
    # Code to create playlist goes here
    
    print('Create Playlist!')
    
    # Name of playlist to be created
    playlistName <- paste('MAWS', input$startArtist)
    
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
    
    # Get playlist data
    # File copied from Rcharlie, https://github.com/charlie86/ since not in library yet
    userPlaylists<- get_user_playlists(user)
    
    # Selecting all playlists with name == playlistName
    playlistURIs <- filter(userPlaylists, playlist_name == playlistName) %>% 
      select(playlist_uri)
    
    # The first playlistURI will be used
    playlistURI <- playlistURIs$playlist_uri[1]  
    
    # Add track to playlist
    # Adds 50 songs to playlist
    if(length(ad$track_uri) >= 50){
      trackURIs <- c(ad$track_uri[1:50])
    }else {
      trackURIs <- c(ad$track_uri)
    }

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
      query = list(access_token = access_tokenCreate),
      content_type_json(),
      encode = 'form',
      httr::config(http_version = 2),
      verbose()
    ) %>%
      content
    
    doneText <- 'Done'
    doneText

  })
  
}
