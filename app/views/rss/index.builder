xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title("UpgradingDave.com")
    xml.link("http://upgradingdave.com")
    xml.description "UpgradingDave.com: Recent items"
    xml.language "en-us"
    xml.ttl "40"

    for item in @nodes
      xml.item do
        xml.title(item.name)
        xml.description(item.to_html)
        xml.pubDate(item.publish_date)
        xml.link(url_for :controller => 'nodes', :action => 'show', :id => item.id)
        xml.guid(url_for :controller => 'nodes', :action => 'show', :id => item.id)
      end
    end
  end
end

