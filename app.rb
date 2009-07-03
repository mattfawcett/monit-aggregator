require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'sinatra'
require 'haml'
require 'helpers'

get '/' do
  @monit_installations = []
  YAML::load( File.open( 'monit_installations.yml' ) ).each do |key, installation|
    @monit_installations << installation.merge('doc' =>  xml_doc(installation['url'], installation['username'], installation['password']))
  end    
  haml :index
end

helpers do      
  include MonitAggregatorHelpers        
end