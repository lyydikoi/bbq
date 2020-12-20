# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  user_name  :string
#  event_id   :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }
  
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

end
