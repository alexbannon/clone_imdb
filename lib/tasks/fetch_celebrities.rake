desc "Fetch celebrities and movies by birthday"
task :fetch_celebrities => :environment do
  require 'nokogiri'
  require 'open-uri'

  1..12.each do |month|

  end

  Product.find_all_by_price(nil).each do |product|
    escaped_product_name = CGI.escape(product.name)
    url = "http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=#{escaped_product_name}&Find.x=0&Find.y=0&Find=Find"
    doc = Nokogiri::HTML(open(url))
    price = doc.at_css(".PriceXLBold, .PriceCompare .BodyS").text[/[0-9\.]+/]
    product.update_attribute(:price, price)
  end
end
