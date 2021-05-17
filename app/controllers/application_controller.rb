# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.exception.message }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: exception.exception.message }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { error: exception.record.errors.as_json }, status: :bad_request
  end

  rescue_from VenmoError do |exception|
    render json: { error: exception.exception.message }, status: :internal_server_error
  end
end
