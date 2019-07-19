require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Faire une array avec les prénoms et noms des députés


def get_all_the_depute_list (url)
	page = Nokogiri::HTML(open(url))
	@depute_list = page.xpath('/html/body/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a').map {|a| a.text}
	return @depute_list

end

puts get_all_the_depute_list ("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")


#Faire une array avec les urls des députés

def get_all_the_depute_url (url)
	page = Nokogiri::HTML(open(url))
	@depute_url = page.xpath('/html/body/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a').map {|a| a["href"]}.map{|a| "http://www2.assemblee-nationale.fr#{a[0..-1]}" }
	return @depute_url
end

puts get_all_the_depute_url ("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")

#Récupérer l'email du député dans chaque url des députés

def get_the_email (email_url)

	page = Nokogiri::HTML(open(email_url))
	page.xpath('/html/body/div[3]/div/div/div/section[2]/div/div/div/article/div[4]/section/dl/dd[1]/a').each do |a|
	  puts a["href"].delete("mailto:")
		end
end

#get_the_email ("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")


#Faire une array de hashs qui contiennent les prénoms, noms et emails des députés

depute_email = Array.new
n=0
577.times do
	a = get_the_email (@depute_url[n])
	depute_email<<a
	n+=1
end

return depute_email

puts Hash[@depute_list.zip @depute_email]