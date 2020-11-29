class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user
  
    if @new_subscription.save
      # Если сохранилась, редиректим на страницу самого события
      redirect_to @event, notice:  'Subscription was successfully created.'
    else
      # если ошибки — рендерим шаблон события
      render 'events/show', alert: 'Subscription was not created...'
    end
  end


  def destroy
    message = { notice: 'Subscription was successfully destroyed.' }

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message =  { alert: 'Subscription was not destroyed...' }
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
