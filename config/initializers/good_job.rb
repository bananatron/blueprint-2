Rails.application.configure do

  # GoodJob can execute jobs "async" in the same process as the web server (e.g. bin/rails s).
  # GoodJob's async execution mode offers benefits of economy by not requiring a separate
  # job worker process
  config.good_job.execution_mode = :async
  config.good_job.max_threads = 4
  config.good_job.poll_interval = 10

  config.good_job.cron = { # https://github.com/floraison/fugit (for chron syntax)
    sample_job: {
      cron: "every 60 seconds",
      class: "SampleJob",
    }
  }


#   # Configure options individually...
#   config.good_job.preserve_job_records = true
#   config.good_job.retry_on_unhandled_error = false
#   config.good_job.on_thread_error = -> (exception) { Rails.error.report(exception) }
#   config.good_job.queues = '*'
#   config.good_job.max_threads = 5
#   config.good_job.poll_interval = 30 # seconds
#   config.good_job.shutdown_timeout = 25 # seconds
#   config.good_job.enable_cron = true
#   config.good_job.cron = { example: { cron: '0 * * * *', class: 'ExampleJob'  } }
#   config.good_job.dashboard_default_locale = :en

#   # ...or all at once.
#   config.good_job = {
#     preserve_job_records: true,
#     retry_on_unhandled_error: false,
#     on_thread_error: -> (exception) { Rails.error.report(exception) },
#     execution_mode: :async,
#     queues: '*',
#     max_threads: 5,
#     poll_interval: 30,
#     shutdown_timeout: 25,
#     enable_cron: true,
#     cron: {
#       example: {
#         cron: '0 * * * *',
#         class: 'ExampleJob'
#       },
#     },
#     dashboard_default_locale: :en,
#   }
end
