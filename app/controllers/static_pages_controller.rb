class StaticPagesController < ApplicationController

  def home
    fetch_kids
  end

  def about
    fetch_kids(6)
  end

  def stories
    fetch_kids(6)
  end

  def donate
    fetch_kids(6)
  end

  def docs
    fetch_kids(6)
  end

  private

  def fetch_kids(number_of_entries = 30)
    if params[:location].blank?
      @location_query = [location.latitude, location.longitude]
      @city = request.location.city
    else
      @location_query = params[:location]
      @city = params[:city]
    end
    @kids = Kid.limit(50).near(@location_query, 500)
    @kids = @kids.to_a.slice(0,number_of_entries).shuffle
  end
end
