class TriggerController < ApplicationController
  def index
    current_datetime = DateTime.now
    # Store current datetime in the database
    RequestTracker.create(datetime: current_datetime)
    # Publish event to Redis channel using Sidekiq
    TriggerEventJob.perform_later

    render json: { datetime: current_datetime.to_s }
  end
end