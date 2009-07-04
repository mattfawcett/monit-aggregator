Spec::Runner.configure do |config|
  config.include MonitAggregatorHelpers
  

  def encode_credentials(username, password)
    "Basic " + Base64.encode64("#{username}:#{password}")
  end

end