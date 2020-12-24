class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event


    mail to: event.user.email, subject: "subscription"#default_i18n_subject(event: event.title)
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "comment"#default_i18n_subject(event: event.title)
  end

  def photo(event, photo, email)
    @event = event
    @photo = photo

    mail to: email, subject: "photo" #default_i18n_subject(event: event.title)
  end
end
