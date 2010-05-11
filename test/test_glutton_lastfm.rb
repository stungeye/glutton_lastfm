require 'helper'

# I'm currently only testing two methods and one exception.
# HTTP calls are replaced by fixture file responses using the fakeweb gem.

class TestGluttonLastfm < Test::Unit::TestCase
  LASTFM_API_KEY = '<your last.fm API key>'
  
  def setup
    @lastfm = GluttonLastfm.new LASTFM_API_KEY
  end
  
  def test_api_key_is_set
    assert_not_equal(LASTFM_API_KEY, '<your last.fm API key>')
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
end
