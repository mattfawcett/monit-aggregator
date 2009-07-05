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
  
  def status_text(doc)
    if doc.css("pid").inner_html == ""
      'Down'
    else
      'Ok'
    end
  end
    
end