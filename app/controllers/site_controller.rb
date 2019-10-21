class SiteController < ApplicationController

  def index
    render :json => "Hi!", :status => 200
  end
end