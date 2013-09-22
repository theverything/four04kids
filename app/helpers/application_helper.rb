module ApplicationHelper
  def request_city
    if params[:location].blank?
      if request.location.city.blank?
        "Seattle"
      else
        request.location.city
      end
    else
      params[:location]
    end
  end
end
