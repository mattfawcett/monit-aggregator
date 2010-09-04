require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'monit_instance'
require 'helpers'

use Rack::Auth::Basic do |username, password|
  [username, password] == ['admin', 'password']
end

get '/' do
  @monit_installations = MonitInstance.all
  erb :index
end

helpers do
  include MonitAggregatorHelpers
end