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
      sentiment_response = get_sentiment(params[:question])
      render json: { message: message, sentiment: sentiment_response, principal: 'greg' }
      start_lights(sentiment_response['type'])
    end
  end

  private

  def start_lights(sentiment)
    pid = spawn("python lights.py #{sentiment}")
    Process.detach(pid)
  end

  def message
    words = AppConfig.architecturey.famous_words.sample(3)
    "You should build an application using #{words.to_sentence}."
  end

  def get_sentiment(question)
    response = client.detect_sentiment(
        text: question,
        language_code: 'en'
    )

    {
        type: response.sentiment.downcase,
        scores: {
            negative: response.sentiment_score.negative,
            positive: response.sentiment_score.positive,
            neutral: response.sentiment_score.neutral,
            mixed: response.sentiment_score.mixed
        }
    }
  rescue Aws::Comprehend::Errors::ServiceError => e
    puts e

    {
        type: 'neutral',
        scores: {
            negative: 0.0,
            positive: 0.0,
            neutral: 0.0,
            mixed: 0.0
        }
    }
  end

  def client
    return @client if @client

    @client = Aws::Comprehend::Client.new(profile: 'herp_derp')
  end
end
