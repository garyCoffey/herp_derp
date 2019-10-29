#
require 'aws-sdk-comprehend'

# SiteController.
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
      sentiment = get_sentiment(params[:question])
      render json: { message: message, sentiment: sentiment, principal: 'greg' }
      pid = spawn('python lights.py')
      Process.detach(pid)
    end
  end

  private

  def message
    words = AppConfig.architecturey.famous_words.sample(3)
    "You should build an application using #{words.to_sentence}."
  end

  def get_sentiment(question)
    resp = client.detect_sentiment(
      text: question,
      language_code: 'en'
    )
    puts resp
    resp.sentiment
  rescue Aws::Comprehend::Errors::ServiceError => e
    puts e

    'NEUTRAL'
  end

  def client
    return @client if @client

    @client = Aws::Comprehend::Client.new(:profile => 'herp_derp')
  end
end
