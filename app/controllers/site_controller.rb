class SiteController < ApplicationController
  def index
    render template: 'pages/index.html'
  end

  def architecture
    if params[:question].blank?
      render json: {
        error: 'Please describe your project in plain english.'
      }, status: :bad_request
    else
      system('python lights.py')
      render json: { message: message, principal: 'greg' }
    end
  end

  private

  def message
    words = AppConfig.architecturey.famous_words.sample(3)
    "You should build an application using #{words.to_sentence}."
  end
end
