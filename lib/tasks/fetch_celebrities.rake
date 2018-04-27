desc "Fetch celebrities and movies by birthday"
task :fetch_celebrities => :environment do
  scraper = Scraper.new
  scraper.scrape_all
end
