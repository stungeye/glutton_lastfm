# Example: Looping Through Arist Tag Names and Image Urls

require 'rubygems'
require 'glutton_lastfm'

last = GluttonLastfm.new '<your last.fm API key>'

artist = 'Buck 65'
artist_info         = last.artist_info artist

puts "#{artist} Tags: "
artist_info['tags']['tag'].each { |tag| puts tag['name']  }
puts
puts "#{artist} Image URLs: "
artist_info['image'].each { |img| puts img }