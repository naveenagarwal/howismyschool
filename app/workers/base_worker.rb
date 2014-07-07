class BaseWorker
  include Sidekiq::Worker

  def log(msg)
    Sidekiq.logger.info msg
  end
end