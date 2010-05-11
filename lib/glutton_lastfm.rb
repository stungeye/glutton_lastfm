# glutton_lastfm
#
# A last.fm Ruby API Wrapper
#
# Author         : Wally Glutton - http://stungeye.com
# Required       : Last.fm API Key - http://www.last.fm/api
# Source Repo    : http://github.com/stungeye/glutton_lastfm
# Gem Dependence : HTTParty - Installed by gem along with glutton_lastfm.
# Ruby Version   : Written and tested using Ruby 1.8.7.
# License        : This is free and unencumbered software released into the public domain. See LICENSE for details.

require 'httparty'

class GluttonLastfm
  include HTTParty
  API_VERSION = "2.0".freeze
  base_uri "http://ws.audioscrobbler.com/#{API_VERSION}/"
  format :xml
  
  class QueryStatusFail < StandardError; end
  class QueryArgumentFail < StandardError; end
  class Unauthorized < StandardError; end
  class NotFound < StandardError; end
  class UnknownFail < StandardError; end
  
  def initialize( key )
    self.class.default_params :api_key => key
  end
  
  def q( options )
    response = self.class.get( '', :query => options )
    raise_errors(response, options)
    response['lfm']
  end
  
  def artist_search( artist )
    q( :method => 'artist.search', :artist => artist )['results']['artistmatches']['artist']
  end
  
  def album_search( album )
    q( :method => 'album.search', :album => album )['results']['albummatches']['album']
  end
   
  def artist_top_albums( artist )
    q( :method => 'artist.gettopalbums', :artist => artist )['topalbums']['album']
  end
  
  def artist_top_tracks( artist )
    q( :method => 'artist.gettoptracks', :artist => artist )['toptracks']['track']
  end
  
  def artist_top_tags( artist )
    q( :method => 'artist.gettoptags', :artist => artist )['toptags']['tag']
  end
  
  def artist_events( artist )
    response = q( :method => 'artist.getevents', :artist => artist )['events']
    (response['total'].to_i == 0) ? [] : response['event']
  end
  
  def album_info( artist, album )
    q( :method => 'album.getinfo', :artist => artist, :album => album )['album']
  end
  
  def album_info_by_mbid( mbid )
    q( :method => 'album.getinfo', :mbid => mbid )['album']
  end
  
  def artist_info( artist )
    q( :method => 'artist.getinfo', :artist => artist )['artist']
  end
  
  def artist_info_by_mbid( mbid )
    q( :method => 'artist.getinfo', :mbid => mbid )['artist']
  end
  
  private

  def raise_errors(response, options)
    case response.code.to_i
      when 400
        raise QueryArgumentFail, "#{response['lfm']['error'] if response['lfm']} #{options.inspect}"
      when 403
        raise Unauthorized,  "#{response['lfm']['error'] if response['lfm']} #{options.inspect}"
      when 404
        raise NotFound, options.inspect
      when 200 # Is it overkill to test all successfully received requests like this?
        if response['lfm']
          raise QueryStatusFail, "#{response['lfm']['error']} #{options.inspect}" if response['lfm']['status'] != 'ok'
        else
          raise UnknownFail, "Successfully received an HTTP response but could not correctly parse data. #{options.inspect}"
        end
    end
  end
  
end