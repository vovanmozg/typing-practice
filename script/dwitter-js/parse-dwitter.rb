require 'nokogiri'
require 'em-http-request'
url = 'https://www.theverge.com/2023/2/22/23610048/microsoft-bing-ai-chatbot-availability-ios-android-edge-skype-apps'


url = 'https://www.dwitter.net/d/27132'



def download(id)
  url = "https://www.dwitter.net/d/#{id}"

  http = EventMachine::HttpRequest.new(url).get 

  http.errback { p 'Uh oh'; EM.stop }
  http.callback {

  	page = Nokogiri::HTML(http.response)   
	#*puts page.class   # => Nokogiri::HTML::Document

    result = page.css('#content > div > div.dweet-wrapper > div.dweet > div.dark-section > form > div.dweet-code > textarea').text
    File.write("#{id}.txt", result)
  }
end

EventMachine.run {
	(27130..27132).each do |id|
		
		download(id)
	end
	#EventMachine.stop
}