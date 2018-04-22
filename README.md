# MessingAroundWithSpotify
Generate list of song depending on filter options

Code for R.

1. 

Install all packages needed.
>Run requierments.R 

2.

>run downloadArtistData.R 

This will create a tibble with data for all songs by the artists in artistList. 

Edit the list for different artist. The tibble will be saved as artistData.RData.
Move artistData.RData to folder "App".

3.

Load library Shiny with
>library(shiny)

Start app with
>runApp('App')


/Johan Wållgren 201804
