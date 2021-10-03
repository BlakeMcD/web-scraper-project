#this is like package.json, but in Ruby
Gem::Specification.new do |s|
    s.name        = 'JSAAJSE App'
    s.version     = '0.0.0'
    s.summary     = "Job Searcher App for Aussie Junior Software Engineers"
    s.description = "This app scrapes the seek.com.au website for Junior Software Engineer roles based in Australia."
    s.authors     = ["Blake McDermott"]
    s.email       = 'blakemcd@gmail.com'
    s.files       = [
        "lib/job.rb","
        lib/scaper.rb"
    ]
    s.homepage    =
      'https://rubygems.org/gems/JSAAJSE'
    s.license       = 'MIT'
  end