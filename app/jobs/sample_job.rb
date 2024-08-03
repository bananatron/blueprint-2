class SampleJob < ApplicationJob
  queue_as :default

  def perform()
    puts "👋 Hi there i'm a sample job"
    Rails.logger.info "👋 Hi there i'm a sample job"
  end
end
