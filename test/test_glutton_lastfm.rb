require 'helper'

# HTTP calls are replaced by fixture file responses using the fakeweb gem.
# Because of this the API_KEY can be left blank.

class TestGluttonLastfm < Test::Unit::TestCase
  LASTFM_API_KEY = ''
  
  def setup
    @lastfm = GluttonLastfm.new LASTFM_API_KEY
  end
  
  def test_object_creations
    assert_equal(@lastfm.class, GluttonLastfm)
  end
  
  def test_artist_info_by_name
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.getinfo&artist=Prince", 'artist_info_prince.xml')
    prince_artist_info = @lastfm.artist_info('Prince')
    assert_equal(prince_artist_info['mbid'],'070d193a-845c-479f-980e-bef15710653e')
  end
  
  def test_artist_info_by_mbid
    mbid = '070d193a-845c-479f-980e-bef15710653e'
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.getinfo&mbid=#{mbid}", 'artist_info_prince.xml')
    prince_artist_info = @lastfm.artist_info_by_mbid(mbid)
    assert_equal(prince_artist_info['name'],'Prince')
  end
  
  def test_unauthorized_exception
    lastfm_bad_key = GluttonLastfm.new 'invalid_key'
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=invalid_key&method=artist.getinfo&artist=Prince", 'invalid_api_key.xml', 403)
    assert_raise(GluttonLastfm::Unauthorized) { lastfm_bad_key.artist_info('Prince') }
  end
  
  def test_can_handle_one_album_top_albums
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.gettopalbums&artist=Foxboro%20Hot%20Tubs", 'one_album_top_albums.xml')
    one_album_top_albums = @lastfm.artist_top_albums('Foxboro Hot Tubs')
    assert_equal(one_album_top_albums[0]['name'], 'Coolest Songs In The World! Vol. 7')
  end
  
  def test_can_handle_multi_album_top_albums
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.gettopalbums&artist=Atmosphere", 'multi_album_top_albums.xml')
    one_album_top_albums = @lastfm.artist_top_albums('Atmosphere')
    assert_equal(one_album_top_albums[0]['name'], 'God Loves Ugly')
  end
  
  def test_unknown_artist_top_albums
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.gettopalbums&artist=nowaytherebeanartistnamedthis", 'unknown_artist_top_albums.xml')
    assert_raise(GluttonLastfm::QueryStatusFail) { @lastfm.artist_top_albums('nowaytherebeanartistnamedthis') }
  end
  
  def test_artist_no_albums_top_albums
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.gettopalbums&artist=Wally%20Glutton", 'artist_no_albums_top_albums.xml')
    top_albums = @lastfm.artist_top_albums('Wally Glutton')
    assert_equal(top_albums.size, 0)
  end  
  
  def test_artist_no_tags_top_tags
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.gettoptags&artist=Wally%20Glutton", 'artist_no_tags_top_tags.xml')
    top_tags = @lastfm.artist_top_tags('Wally Glutton')
    assert_equal(top_tags.size, 0)
  end  
  
  def test_artist_multi_tags_top_tags
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.gettoptags&artist=Buck%2065", 'artist_multi_tags_top_tags.xml')
    top_tags = @lastfm.artist_top_tags('Buck 65')
    assert_equal(top_tags[0]['name'], 'Hip-Hop')
  end
  
  def test_artist_no_events
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.getevents&artist=Wally%20Glutton", 'artist_no_events.xml')
    events = @lastfm.artist_events('Wally Glutton')
    assert_equal(events.size, 0)
  end
  
  def test_unknown_artist_artist_search
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.search&artist=nowaytherebeanartistnamedthis", 'unknown_artist_artist_search.xml')
    artists = @lastfm.artist_search('nowaytherebeanartistnamedthis')
    assert_equal(artists.size, 0)
  end
  
  def test_known_artist_artist_serach
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=artist.search&artist=weakerthans", 'known_artist_artist_search.xml')
    artists = @lastfm.artist_search('weakerthans')
    assert_equal(artists[0]['name'], 'The Weakerthans')
  end
  
  def test_unknown_album_album_search
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=album.search&album=nowaytherebeanalbumnamedthis", 'unknown_album_album_search.xml')
    albums = @lastfm.album_search('nowaytherebeanalbumnamedthis')
    assert_equal(albums.size, 0)
  end
  
  def test_known_album_album_serach
    stub_get("http://ws.audioscrobbler.com/2.0?api_key=#{LASTFM_API_KEY}&method=album.search&album=vertex", 'known_album_album_search.xml')
    albums = @lastfm.album_search('vertex')
    assert_equal(albums[0]['name'], 'Vertex')
  end
end
