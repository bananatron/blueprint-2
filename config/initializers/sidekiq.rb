
# Uncomment to use Sidekiq instead of GoodJob

# Sidekiq.configure_client do |config|
#   config.redis = { url: Rails.env.test? ? 'redis://localhost:6379/1' : ENV["SIDEKIQ_REDIS_URL"] }
# end
