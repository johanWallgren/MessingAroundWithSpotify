library(spotifyr)
library(tidyverse)
source('get_artist_audio_features_mod.R', local = TRUE)

artistList <- c('Avicii','Drake','The Weeknd','Ed Sheeran','Marshmello','Kendrick Lamar','Dua Lipa',
                'J Balvin','David Guetta','Post Malone','Camila Cabello','Rihanna','Khalid',
                'The Chainsmokers','Calvin Harris','Eminem','Shawn Mendes','Daddy Yankee',
                'Bruno Mars','Chris Brown','Maroon 5')

Sys.setenv(SPOTIFY_CLIENT_ID = '21fae2a08aad434d9da510b25f09de90') # Not my real client id
Sys.setenv(SPOTIFY_CLIENT_SECRET = '8d3588f452d445329ab8d1c5d8e5cb7a') # Not my real client secret

access_token <- get_spotify_access_token()

artistData <- as_tibble()

for (i in 1:length(artistList)){
  
  # Sleeps to avoid crash of download
  if(i %% 3 == 0){
    print('--Resting for 5 seconds--')
    Sys.sleep(5)
    }
  
  print(artistList[i])
  temp <- as_tibble(get_artist_audio_features_mod(artistList[i]))
  temp <- mutate(temp, 'artist' = artistList[i])
  
  artistData <- bind_rows(artistData, temp)
  rm(temp)
}

save(artistData, file = 'artistData.RData')

