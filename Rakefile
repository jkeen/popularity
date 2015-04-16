# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "popularity"
  gem.homepage = "http://github.com/jkeen/popularity"
  gem.license = "MIT"
  gem.summary = %Q{Popularity searches social networks a url and returns the metrics.}
  gem.description = %Q{Supports Facebook, Twitter, Pinterest, Reddit (Links, Posts, and Comments), Github, Soundcloud, Medium, and Rubygems}
  gem.email = "jeff@keen.me"
  gem.authors = ["Jeff Keen"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => [:spec]
desc 'run Rspec specs'
task :spec do
  sh 'rspec spec'
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "popularity #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



