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
      famous_words = AppConfig.architecturey.famous_words
      render json: { words: famous_words.sample(3) }
    end
  end
end
