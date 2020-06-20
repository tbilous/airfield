require 'sidekiq'
require 'sidekiq-status'

# Some middleware that logs the status of the job to the sidekiq worker record.
#
class Sidekiq::SidekiqWorkerLogger
  class ServerMiddleware
    def call(_worker, job, _queue)
      Sidekiq::SidekiqWorkerLogger.log(job['jid'])
      yield
      Sidekiq::SidekiqWorkerLogger.log(job['jid'])
    end
  end

  class ClientMiddleware
    def call(_worker_class, job, _queue, _redis_pool)
      Sidekiq::SidekiqWorkerLogger.log(job['jid'])
      yield
    end
  end

  def self.log(jid)
    SidekiqWorker.find_by(job_id: jid).status
  rescue StandardError
    nil
  end
end

Sidekiq.configure_server do |config|
  config.redis = { namespace: :airfield, url: (ENV['REDIS_URL'] || 'redis://127.0.0.1:6379/0') }

  config.client_middleware do |chain|
    chain.add Sidekiq::SidekiqWorkerLogger::ClientMiddleware
  end

  config.server_middleware do |chain|
    chain.add Sidekiq::SidekiqWorkerLogger::ServerMiddleware
  end

  # config.error_handlers << proc { |ex, ctx_hash| Raven.capture_exception(ex, ctx_hash) }

  config.death_handlers << lambda { |job, ex|
    worker = begin
               SidekiqWorker.find_by(job_id: job['jid'])
             rescue StandardError
               nil
             end
    worker.update(last_error_at: Time.now, last_error: ex.message) if worker.present?
  }

  # accepts :expiration (optional)
  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes

  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end

Sidekiq.configure_client do |config|
  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
  config.redis = { namespace: :claim_service, url: (ENV['REDIS_URL'] || 'redis://127.0.0.1:6379/0') }
end

# HEROKU CONFIGS
if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end

Sidekiq.default_worker_options = { 'backtrace' => true }

# Perform Sidekiq jobs immediately in development,
# so you don't have to run a separate process.
# You'll also benefit from code reloading.
if Rails.env.development?
  require 'sidekiq/testing'
  # Sidekiq::Testing.inline!
  Sidekiq::Testing.disable!
end
