class BirthdayController < ApplicationController

  def show
    @celebrities = ['Hello World', 'Jon Snow']
  end

  def show_scrape
    require 'openssl'
    month = params[:month]
    day = params[:day]
    doc = Nokogiri::HTML(open("http://www.imdb.com/search/name?birth_monthday=${month}-${day}", :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

    entries = doc.css('.lagos-market-rates-inner')
    rate = entries.css('table')[0].css('tr')[1].css('td')[1].text
    @formattedrate = rate[6..8]
    render template: 'parallel/home'
  end
end
