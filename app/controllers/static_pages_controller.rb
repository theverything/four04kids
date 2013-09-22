class StaticPagesController < ApplicationController
  before_filter :fetch_kids

  def home
  end

  def about
  end

  def stories
  end

  def donate
  end

  private

  def fetch_kids
    if params[:location].blank?
      @location_query = [location.latitude, location.longitude]
      @city = request.location.city
    else
      @location_query = params[:location]
      @city = params[:city]
    end
    @kids = Kid.limit(50).near(@location_query, 500)
    @kids = @kids.to_a.slice(0,30).shuffle
  end
end
