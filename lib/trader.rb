
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def cours_crypto(url)

page = Nokogiri::HTML(open(url))
name_array = page.xpath('//*[contains(@class,"currency-name-container link-secondary")]').map { |a| a.text }
#puts name_array

price_array = page.xpath('//*[contains(@class,"no-wrap text-right")]').map { |a| "$#{a["data-sort"]}"}
#puts price_array

crypto = Hash[name_array.zip price_array]
puts crypto

end

cours_crypto('https://coinmarketcap.com/all/views/all/')