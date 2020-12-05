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
  validate :event_host_cannot_subscribe
  validate :anonym_cannot_subscribe_existing_user, unless: -> { user.present? }

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
    errors.add(:host, I18n.t('error.subscription.host_cannot_subscribe')) if
      event.user == user
  end

  def anonym_cannot_subscribe_existing_user
    errors.add(:anonym, I18n.t('error.subscription.anonym_cannot_subscribe_existing_user')) if
      User.where(email: user_email).count > 0 
  end

end
