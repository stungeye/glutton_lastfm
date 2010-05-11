# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{glutton_lastfm}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wally Glutton"]
  s.date = %q{2010-05-10}
  s.description = %q{Simple last.fm API wrapper written using HTTParty in Ruby.}
  s.email = %q{stungeye@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "examples/all_methods.rb",
     "examples/artist_tags_and_images.rb",
     "glutton_lastfm.gemspec",
     "lib/glutton_lastfm.rb",
     "test/helper.rb",
     "test/test_glutton_lastfm.rb"
  ]
  s.homepage = %q{http://github.com/stungeye/glutton_lastfm}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby last.fm API wrapper.}
  s.test_files = [
    "test/helper.rb",
     "test/test_glutton_lastfm.rb",
     "examples/artist_tags_and_images.rb",
     "examples/all_methods.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.5.0"])
    else
      s.add_dependency(%q<httparty>, [">= 0.5.0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.5.0"])
  end
end

