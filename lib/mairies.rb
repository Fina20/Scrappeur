require 'rubygems'
require 'nokogiri'
require 'open-uri'

 def get_the_email_of_a_townhal_from_its_webpage (townhal_url)

page = Nokogiri::HTML(open(townhal_url))
page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
	  puts node.text
	end
 end
   
get_the_email_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/vaureal.html")


def get_all_the_urls_of_val_doise_townhalls (url)
page = Nokogiri::HTML(open(url))
urls_array = page.xpath('//p/a').map{|link| link["href"]}.map{|link| "www.http://annuaire-des-mairies.com#{link[1..-1]}" }
	 puts urls_array
end

get_all_the_urls_of_val_doise_townhalls ("http://annuaire-des-mairies.com/val-d-oise.html")

def get_the_email_of_val_doise_townhalls(url)

	urls_array = get_all_the_urls_of_val_doise_townhalls (url)
	emails_array = urls_array.map {|x| get_the_email_of_a_townhal_from_its_webpage(x)}
	puts emails_array

end

get_the_email_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")