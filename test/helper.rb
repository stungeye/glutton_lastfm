require 'rubygems'
require 'test/unit'
require 'fakeweb'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'glutton_lastfm'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
end

def fixture_file(filename)
  return "" if filename == ""
  file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
  File.read(file_path)
end

def stub_get(url, filename, status=nil)
  options = { :body => fixture_file(filename) }
  options.merge!({ :status => status }) unless status.nil?
  FakeWeb.register_uri(:get, url, options)
end