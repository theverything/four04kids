#!/usr/bin/env rackup
#\ -E deployment

require 'rack-livereload'

use Rack::ContentLength

app = Rack::Directory.new Dir.pwd
use Rack::LiveReload

run app