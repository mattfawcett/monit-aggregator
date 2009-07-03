module MonitAggregatorHelpers
  def friendly_seconds(seconds)
    days = (seconds / 86400).floor
    hours = ((seconds - (days * 86400)) / 3600).floor
    minutes = ((seconds - (days * 86400) - (hours * 3600)) / 60).floor
    string = ''
    string << "#{days}d " if days > 0
    string << "#{hours}h " if hours > 0
    string << "#{minutes}m"
    return string
  end
  
  def xml_doc(url, username=nil, password=nil)
    url = URI.parse(url)
    res = Net::HTTP.start(url.host, url.port) {|http|
      req = Net::HTTP::Get.new('/_status?format=xml')
      req.basic_auth username, password if username && password
      http.request(req).response
    }
    doc = Nokogiri::XML.parse(res.body)
    return doc
  end
  
  def status_text(doc)
    if doc.css("pid").inner_html == ""
      'Down'
    else
      'Ok'
    end
  end
  
  def link_with_auth(installation_hash)
    if installation_hash['username'].nil? || installation_hash['password'].nil?
      return installation_hash['url']
    else
      return "http://#{installation_hash['username']}:#{installation_hash['password']}@#{installation_hash['url'].gsub(/http:\/\//, '')}"
    end
  end
end