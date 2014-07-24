class Notify < ActionMailer::Base
  default from: "howismyschooldoing@gmail.com",
          cc: "howismyschooldoing@gmail.com"

  def welcome(user)
    @user = user
    mail(
        to: @user.email
      )
  end

  def schedule_added(schedule_id)
    @schedule = Schedule.find schedule_id
    emails = @schedule.notification_emails_list
    return if emails.blank?

    mail(
        to: emails,
        subject: "New schedule  - #{@schedule.title}"
      )
  end

  def schedule_destroyed(title, start_time, end_time, emails)
    return if emails.blank?

    @title = title
    @start_time = start_time
    @end_time = end_time

    mail(
        to: emails,
        subject: "Schedule Removed - #{@title}"
      )
  end

end
