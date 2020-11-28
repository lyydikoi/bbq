class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "User №#{rand(777)}" if self.name.blank?
  end
end
