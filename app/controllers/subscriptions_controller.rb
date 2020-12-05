class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  def create  
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user
    
    message = { alert: I18n.t('controllers.subscriptions.failed_creation') }
  
    if @new_subscription.save
      message = { notice:  I18n.t('controllers.subscriptions.created') }
    end

    if @new_subscription.errors&.messages[:host_subscription]&.present?
      message[:alert] << " " << @new_subscription.errors.messages[:host_subscription][0]
    end
    
    redirect_to @event, message
  end


  def destroy
    message = { notice: I18n.t('controllers.subscriptions.destroyed') }

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message =  { alert: I18n.t('controllers.subscriptions.failed_destroy') }
    end
  
    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    # .fetch разрешает в params отсутствие ключа :subscription
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
