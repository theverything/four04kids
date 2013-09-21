class ApiController < ApplicationController
  def random
    query = Kid.all
    query = query.where("id != ?", params[:exclude]) if params[:exclude]
    @kid = query.to_a.sample
    render json: @kid
  end

  def index
  end

  def show
  end
end
