require 'nokogiri'
require 'open-uri'
require 'net/http'

class MonitInstance

  attr_accessor :url
  attr_accessor :username
  attr_accessor :password

  def initialize(url, username=nil, password=nil)
    self.url = url
    self.username = username
    self.password = password
  end

  def self.all
    @monit_installations = []
    YAML::load( File.open( 'monit_installations.yml' ) ).each do |key, installation|
      @monit_installations << MonitInstance.new(installation['url'], installation['username'], installation['password'])
    end
    return @monit_installations
  end

  def xml_doc
    uri = URI.parse(url)
    res = Net::HTTP.start(uri.host, uri.port) {|http|
      req = Net::HTTP::Get.new('/_status?format=xml')
      req.basic_auth username, password if username && password
      http.request(req).response
    }
    doc = Nokogiri::XML.parse(res.body)
    return doc
  end

  def link_with_auth
    if username.nil? || password.nil?
      return url
    else
      return "http://#{username}:#{password}@#{url.gsub(/http:\/\//, '')}"
    end
  end

  def xml_seems_ok?
    !xml_doc.xpath('//service[@type=5]').blank?
  end
end