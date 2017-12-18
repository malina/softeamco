redis_config = { url: 'redis://localhost:6379', namespace: 'sidekiq' }

Sidekiq.configure_server do |config|
  config.redis = redis_config

  schedule_file = "config/schedule.yml"

  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
