class TriggerEventJob < ApplicationJob
  queue_as :default

  def perform(datetime)
    Sidekiq.logger.info "Starting publishing time #{datetime} to redis"
    publish_to_redis(datetime)
  end

  private

  def publish_to_redis(datetime)
    redis = Redis.new(url: 'redis://localhost:6379/0')
    redis.publish('events', datetime)
  end
end