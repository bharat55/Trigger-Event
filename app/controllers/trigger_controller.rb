class TriggerController < ApplicationController
  def index
    last_request = RequestTracker.last
    current_datetime = DateTime.now

    if last_request.nil? || last_request.datetime <= 1.minute.ago
      
      # Store current datetime in the database
      RequestTracker.create(datetime: current_datetime)

      # Publish event to Redis channel using Sidekiq
      TriggerEventJob.perform_later(current_datetime.to_s)
    end

    render json: { datetime: current_datetime.to_s }
  end
end