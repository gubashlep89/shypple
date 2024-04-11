## Solution for processing JSON data from team MapReduce

### How to run

- pull folder on your computer
- cd in project folder
- ruby needs to be installed
- run `./bin/main.rb CNSHA NLRTM` in command line where `./bin/main.rb` call the script and `CNSHA NLRTM` is arguments 
with `origin port` and `destination port`

### How to test

- gem bundler needs to be installed
- run `bundle install` in command line
- run `rspec` in command line

### Description
As written in the task I focused on maintainability and adjustable architecture. As a result, the solution can be
implemented in existing application as a rake task, API function, etc. Or grow to an independent service

Thanks for your time!
