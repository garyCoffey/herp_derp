class SiteInputController < ApplicationController

  def project_description
    project = params[:user_input]
    if project.blank?
      render "Please describe your project in plain english, using words.", :status => 200
      return
    end
    ##String processing - what are we processing though?

  end
end