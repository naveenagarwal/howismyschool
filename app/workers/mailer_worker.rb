class MailerWorker < BaseWorker

  def perform(mailer_method_name, mailer_method_arguments)
    log "Sending Email"

    mail = Notify.send(mailer_method_name, *mailer_method_arguments)
    mail.deliver!

    log "Email Sent"
  rescue Exception => e
    log e.message
    log e.backtrace
    raise e
  end

end