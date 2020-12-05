class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, 
              presence: true, 
              unless: -> { user.present? }

  validates :user_email, 
              presence: true, 
              format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, 
              unless: -> { user.present? }

  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  validates :user_email, uniqueness: {scope: :user_id}, unless: -> {user.present?}
  validate :event_host_cannot_subscribe

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end
  
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def event_host_cannot_subscribe
    errors.add(:host_subscription, I18n.t('error.subscription.host_cannot_subscribe')) if
      event.user == user
  end

end
