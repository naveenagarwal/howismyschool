class NotifyPreview < ActionMailer::Preview
  def welcome
    Notify.welcome Teacher.first
  end
end