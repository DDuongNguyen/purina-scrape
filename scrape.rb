require 'nokogiri'
require 'httparty'
require 'byebug'


def scrape_cat
  url = 'https://www.purina.com/breeds/cats'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  cat_card = parsed_page.css('a.callout')

  cats = []
  cat_card.each_with_index do |card,index|
    cat = {
      number: index+1,
      name: card.css('span.callout-label').text,
      url: "https://www.purina.com/breeds" + card.attributes['href'].value
    }
    cats << cat
  end
  byebug
end

scrape_cat
