require 'rubygems'
require 'bundler/setup'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'base64'
require File.expand_path(File.dirname(__FILE__) + '/../app')


Spec::Runner.configure do |config|
  config.include MonitAggregatorHelpers
  

  def encode_credentials(username, password)
    "Basic " + Base64.encode64("#{username}:#{password}")
  end

end