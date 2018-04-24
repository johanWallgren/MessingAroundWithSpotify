# MessingAroundWithSpotify
Create playlist of song depending on filter options in Spotify.
The filters are: energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo and danceability.

A lot of the code is from https://github.com/charlie86 and the spotifyr library.

To use this app a spotify account is needed, also you need a developers account. Read more about this here:
https://github.com/charlie86/spotifyr/blob/master/README.md

This app is not complete, to create a playlist in Spotify you need a token, creating this token is to colicated for me so you need to go to https://beta.developer.spotify.com/console/post-playlists/ and generate a token with your username, the token expiers after 10 minutes. The token is the string of letters and numbers between the word Bearer and the last ".
Copy the token to App/ui.R, variable access_tokenCreate. I have no idea how to generate the token from within the app.

Anyways...

Code for R.

1. 

Install all packages needed.
>Run requierments.R 

2.

Change following variables in ui.R:
access_tokenCreate
User
SPOTIFY_CLIENT_ID
SPOTIFY_CLIENT_SECRET

3.

Load library Shiny with
>library(shiny)

Start app with
>runApp('App')

Typ in artist and press Go! to start generating list of songs.

Filter the songs and press Playlist!


4. 

Open Spotify to play your new playlist.

/Johan Wållgren 201804
