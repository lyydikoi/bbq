class PhotosController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]

  def create
    @new_photo = @event.photos.build(photo_params)
    @new_photo.user = current_user

    if @new_photo.save
      notify_other_subscribers(@event, @new_photo)

      redirect_to @event, notice: I18n.t('controllers.photos.created')
    else
      render 'events/show', alert: I18n.t('controllers.photos.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.photos.destroyed')}

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = {alert: I18n.t('controllers.photos.error')}
    end

    redirect_to @event, message
  end

  private

  # Notify all other subscribers including event host, if he is not current user
  def notify_other_subscribers(event, photo)
    emails = event.subscriptions.where.not(user_email: current_user&.email).map(&:user_email)
    emails = emails + [event.user.email] if event.user.email != current_user&.email

    emails.each do |email|
      EventMailer.photo(event, photo, email).deliver_now
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
