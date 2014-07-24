class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ["howismyschooldoing@gmail.com"]
  end
end

ActionMailer::Base.register_interceptor(SandboxEmailInterceptor) unless Rails.env.production?
