class BirthdayController < ApplicationController

  def show_db
    offset = params[:offset]
    offset ||= 0
    @celebrities = Celebrity.where(
      birth_month: params[:month],
      birth_day: params[:day]
    ).limit(50).offset(offset)

    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @celebrities.as_json(:include_media => true) }
    end
  end

  def show_scrape
    month = params[:month]
    day = params[:day]
    offset = params[:offset]
    if offset
      offset = Integer(offet)
    end

    scraper = Scraper.new
    scraper.process_one_date(month, day, offset)

    @celebrities = Celebrity.where(
      birth_month: params[:month],
      birth_day: params[:day]
    )

    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @celebrities.as_json(:include_media => true) }
    end
  end
end
