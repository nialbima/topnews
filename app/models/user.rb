class User < ApplicationRecord
  has_many :flags, dependent: :destroy
  has_many :stories, through: :flags

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
