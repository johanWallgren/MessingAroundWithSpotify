get_artist_audio_features_mod <- function (artist_name, access_token = get_spotify_access_token()) 
{
  artists <- get_artists(artist_name)
  if (nrow(artists) > 0) {
    # if (interactive()) {
    #   cat(paste0("We found the following artists on Spotify matching \"", 
    #              artist_name, "\":\n\n\t", paste(artists$artist_name, 
    #                                              collapse = "\n\t"), "\n\nPlease type the name of the artist you would like:"), 
    #       sep = "")
    #   selected_artist <- readline()
    # }
    # else {
    #   selected_artist <- artists$artist_name[1]
    # }
    
    selected_artist <- artists$artist_name[1]
    artist_uri <- artists$artist_uri[artists$artist_name == 
                                       selected_artist]
  }
  else {
    stop(paste0("Cannot find any artists on Spotify matching \"",
                artist_name, "\""))
  }
  albums <- get_albums(artist_uri)
  if (nrow(albums) > 0) {
    albums <- select(albums, -c(base_album_name, base_album, 
                                num_albums, num_base_albums, album_rank))
  }
  else {
    # stop(paste0("Cannot find any albums for \"", selected_artist, 
    #             "\" on Spotify"))
    tots <- NA
    return(tots)
    
  }
  album_popularity <- get_album_popularity(albums)
  tracks <- get_album_tracks(albums)
  track_features <- get_track_audio_features(tracks)
  track_popularity <- get_track_popularity(tracks)
  tots <- albums %>% left_join(album_popularity, by = "album_uri") %>% 
    left_join(tracks, by = "album_name") %>% left_join(track_features, 
                                                       by = "track_uri") %>% left_join(track_popularity, by = "track_uri")
  return(tots)
}
