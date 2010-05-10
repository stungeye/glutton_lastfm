require 'rubygems'
require 'glutton_lastfm'
require 'pp'

last = GluttonLastfm.new '923a366899eebed73ba992fff9be063e'

artist = 'Leonard Cohen'

artist_search       = last.artist_search artist
artist_info         = last.artist_info artist
artist_info_by_mbid = last.artist_info_by_mbid '65314b12-0e08-43fa-ba33-baaa7b874c15'
artist_top_albums   = last.artist_top_albums artist
artist_top_tracks   = last.artist_top_tracks artist
artist_top_tags     = last.artist_top_tags artist
artist_events       = last.artist_events artist

album = 'Songs of Leonard Cohen'

album_search       = last.album_search album
album_info         = last.album_info artist, album
album_info_by_mbid = last.album_info_by_mbid '256312e7-0377-47e0-b2e6-df2c6e0cd2e8'

# Inspect any of the returned structures using pp (pretty print):

pp artist_info