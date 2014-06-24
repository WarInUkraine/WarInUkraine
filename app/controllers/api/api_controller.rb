class API::APIController < ApplicationController
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound do
    response_error('Not found', status: :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    response_error(exception.message)
  end

  rescue_from Exception do |exception|
    response_error('Unknown error')
  end if Rails.env.production?

  protected
  def response_ok(options = {})
    options[:status] ||= :ok

    json = {}
    json[:message] = options[:message] unless options[:message] === nil
    json[:payload] = options[:object] unless options[:object] === nil

    render json: json, status: options[:status]
  end

  def response_error(errors = {}, options = {})
    options[:status] ||= :bad_request

    json = {}
    json[:errors]  = errors
    json[:payload] = options[:payload] unless options[:payload] === nil

    render json: json, status: options[:status]
  end
end
