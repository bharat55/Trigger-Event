class TriggerEventJob < ApplicationJob
  queue_as :default

  def perform
    last_request_datetime = RequestTracker.last.datetime
    last_event = Event.last
    if last_event.blank? || (last_event.published_at <= 1.minute.ago)
      Sidekiq.logger.info "Starting publishing time #{last_request_datetime} to redis"
      publish_to_redis(last_request_datetime.to_s)
      Event.create(published_at: DateTime.now)
    end
  
  end

  private

  def publish_to_redis(datetime)
    redis = Redis.new(url: 'redis://localhost:6379/0')
    redis.publish('events', datetime)
  end
end