require File.expand_path(File.dirname(__FILE__) + '/../monit_instance')
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe MonitInstance do
  describe "xml_doc" do
    it "should start a Net::HTTP connection" do
      Net::HTTP.should_receive(:start).with("mysite.com", 2812).and_return(mock(:body => "xmlbody"))
      Nokogiri::XML.should_receive(:parse).with("xmlbody")
      MonitInstance.new("http://mysite.com:2812").xml_doc
    end
  end
  
  describe "link_with_auth" do
    it "should just be a link to the Monit web interafce if there are no login credecntials" do
      instance = MonitInstance.new("http://mymonit.com:1234")
      instance.link_with_auth.should eql("http://mymonit.com:1234")
    end
    
    it "should include the username and password in the url if they are defined" do
      instance = MonitInstance.new("http://mymonit.com:1234", "myuser", "mypass")
      instance.link_with_auth.should eql("http://myuser:mypass@mymonit.com:1234")
    end  
  end
end