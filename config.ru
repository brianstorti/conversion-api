require 'bundler/setup'
require_relative "lib/api"

use Rack::Cache
run Api
