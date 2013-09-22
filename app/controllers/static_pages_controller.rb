class StaticPagesController < ApplicationController
  def home
    if request.ip == "127.0.0.1"
      req_ip = "173.160.181.220"
    else
      req_ip = request.ip
    end
    @kids = Kid.near(req_ip, 500)
  end

  def about
    if request.ip == "127.0.0.1"
      req_ip = "173.160.181.220"
    else
      req_ip = request.ip
    end
    @kids = Kid.near(req_ip, 500)
  end

  def stories

  end

  def donate

  end

  def docs

  end
end
