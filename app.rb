require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'sinatra'
require 'erb'
require 'helpers'
require 'monit_instance'

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