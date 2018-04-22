# server

server <- function(input, output) {
  ################################################
  # Reactive function returning table to plot
  filterAd <- reactive({
    # energy
    # loudness
    # speechiness
    # acousticness
    # instrumentalness
    # liveness
    # valence
    # tempo
    # track_popularity
    
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
        tempo <= input$tempo[2]
    )
  })

  ################################################
  output$tableOfSongs <- renderTable({
    
    dataToPlot <- filterAd()
    
    dataToPlot <- select(dataToPlot, artist, track_name, album_name, track_popularity) %>%
      arrange(desc(track_popularity)) %>%
      select(-track_popularity) %>%
      rename('Artist' = artist, 'Track' = track_name, 'Album' = album_name)
    
    head(dataToPlot, 25)
    
  })

}