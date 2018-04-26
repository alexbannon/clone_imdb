require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Scraper

  def scrape_all

    month = 01
    day = 01
    self.class.process_date(month, day)


    # (1..12).each do |month|
    #   (1..31).each do |day|
    #     page = "https://www.imdb.com/search/name?birth_monthday=#{month}-#{day}&count=100"
    #     self.class.scrape_page(page)
    #   end
    # end
  end

# { people: [ { name: "Gemma Arterton", photoUrl: "https://images-na.ssl-images-amazon.com/images/M/MV5BOTAwNTMwMzE5OF5BMl5BanBnXkFtZTgwMjYwNzI2MjE@._V1_UX140_CR0,0,140,209_AL_.jpg", profileUrl: "http://www.imdb.com/name/nm2605345", mostKnownWork: { title: "Prince of Persia: The Sands of Time", url: "http://www.imdb.com/title/tt0473075/", rating: 6.6, director: "Louis Leterrier" } }, ... ] }

def self.update_most_known_work(site, actor)
  # title: "Prince of Persia: The Sands of Time", url: "http://www.imdb.com/title/tt0473075/", rating: 6.6, director: "Louis Leterrier"
  page = "https://www.imdb.com/title/#{site}"

  doc = Nokogiri::HTML(open(page))

  puts doc

end


  def self.process_date(month, day, offset = 1)
    page = "https://www.imdb.com/search/name?birth_monthday=#{month}-#{day}&count=100&start=#{offset}"

    doc = Nokogiri::HTML(open(page))
    people = doc.css(".lister-item")

    if people.length > 0
      people.each do |person|
        name = person.css(".lister-item-header").css("a")[0].text
        name.slice!(0)

        photoUrl = person.css(".lister-item-image").css("a")[0].css("img")[0].attr('src')

        siteEnd = person.css(".lister-item-header").css("a")[0].attr("href")

        profileUrl = "https://www.imdb.com#{siteEnd}"

        mostKnownWorkContainer = person.css(".lister-item-content")[0].css("p")[0].css("a")[0]

        mostKnownWork = mostKnownWorkContainer.text
        mostKnownWork.slice!(0)
        mostKnownWorkSite = mostKnownWorkContainer.attr("href")
        mostKnownWorkSite.slice!(0, 7)
        mostKnownWorkSite.chop!

        celebrity = update_celebrity(name, photoUrl, profileUrl)

        update_most_known_work(mostKnownWorkSite, celebrity)

        puts name
        puts photoUrl
        puts profileUrl
        puts mostKnownWork
        puts mostKnownWorkSite
      end

      # process_date(month, day, offset + 100)
    else
      puts "all done"
    end
  end

  def self.update_celebrity(name, photoUrl, profileUrl)
    # celebrity = Celebrity.where(:profileUrl => profileUrl).first_or_create({
    #   :name => name,
    #   :photoUrl => photoUrl,
    #   :profileUrl => profileUrl
    # })
    #

    profileUrl

  end

end

scrape = Scraper.new

scrape.scrape_all
