require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Scraper

  def scrape_all
    (1..12).each do |month|
      (1..31).each do |day|
        puts "-- starting date #{month}/#{day} --"
        self.class.process_date(month, day)
      end
    end
  end

  def self.process_date(month, day, offset = 1)
    puts "processing #{offset} - #{offset + 49}"
    page = "https://www.imdb.com/search/name?birth_monthday=#{month}-#{day}&start=#{offset}"

    doc = Nokogiri::HTML(open(page))
    people = doc.css(".lister-item")

    if people.length > 0
      people.each do |person|
        begin
          name = person.css(".lister-item-header").css("a")[0].text
          name.slice!(0)
          name.chop!

          photo_url = person.css(".lister-item-image").css("a")[0].css("img")[0].attr('src')

          site_end = person.css(".lister-item-header").css("a")[0].attr("href")

          profile_url = "https://www.imdb.com#{site_end}"

          most_known_work_container = person.css(".lister-item-content")[0].css("p")[0].css("a")[0]

          most_known_work = most_known_work_container.text
          most_known_work.slice!(0)
          most_known_work_site = most_known_work_container.attr("href")
          most_known_work_site.slice!(0, 7)
          most_known_work_site.chop!

          media = update_most_known_work(most_known_work_site)

          update_celebrity(name, photo_url, profile_url, media)
        rescue Exception => e
          puts e
          puts page
          break
        end
      end

      process_date(month, day, offset + 50)
    else
      puts "** finished processing #{month}/#{day} **"
    end
  end

  def self.update_most_known_work(site)
    page = "https://www.imdb.com/title/#{site}"

    media = Media.where(:url => page)

    if (media.empty?)
      doc = Nokogiri::HTML(open(page))
      begin
        title = doc.css(".title_wrapper")[0].css("h1")[0].text
        title.strip!
        rating_container = doc.css(".ratingValue")[0]
        if rating_container.nil?
          rating = 0
        else
          rating = rating_container.css("strong")[0].css("span")[0].text
        end
        director_container = doc.css(".credit_summary_item")[0].css("a")[0].css("span")[0]
        if director_container.nil?
          director = 'Not Yet Determined'
        else
          director = director_container.text
        end
        url = page

        Media.create!({
          :title => title,
          :url => url,
          :rating => rating,
          :director => director
        })
      rescue Exception => e
        puts e
        puts site
      end
    else
      media.first
    end
  end


  def self.update_celebrity(name, photo_url, profile_url, media)
    Celebrity.where(:profile_url => profile_url).first_or_create!({
      :name => name,
      :photo_url => photo_url,
      :profile_url => profile_url,
      :media_id => media.id
    })
  end

end
