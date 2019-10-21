class SiteController < ApplicationController

  def index
    render 'index'
  end

  def project_description
    project = params[:user_input]
    if project.blank?
      render :json => "Please describe your project in plain english, using words.", :status => 200
      return
    end
    ##String processing - what are we processing though?
  end

  def architecture
    famous_words = AppConfig.architecturey.famous_words
    famous_words.shuffle.last 3
  end
end