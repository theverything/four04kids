class ApiController < ApplicationController
  before_filter :set_access_control_headers
  def random
    if location.country_code == "US"
      query = Kid.near([location.latitude, location.longitude], 500)
    else
      query = Kid.all
    end
    query = query.where("age > 0")
    query = query.where("id != ?", params[:exclude].to_i) if params[:exclude]
    @kid = query.to_a.sample
    job = Afterparty::BasicJob.new @kid, :increment
    Rails.configuration.queue << job
    render json: @kid
  end

  def index
    Kid.all.to_a
  end

  def show
  end

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end
