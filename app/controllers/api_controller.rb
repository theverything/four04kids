class ApiController < ApplicationController
  before_filter :set_access_control_headers
  def random
    if location.country_code == "US"
      @limit = params[:limit].blank? ? 500 : params[:limit].to_i
      @query = Kid.near_location(location, @limit)
    else
      @query = Kid.all
    end
    @query = @query.excluding(params[:exclude]) if params[:exclude]
    @kid = @query.random
    @kid.increment!
    render json: @kid, meta: {location: location.data}
  end

  def index
    @kids = Kid.where(api_params).paginate(pagination_params)
    @kids = @kids.order("missing_date DESC")
    render json: @kids
  end

  def show
  end

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def api_params
    params.permit(:sex, :missing_state)
  end

  def pagination_params
    if params[:per_page]
      @per_page = [params[:per_page].to_i, 100].min
    else
      @per_page = 100
    end
    {
      page: params[:page] || 1,
      per_page: @per_page
    }
  end
end
