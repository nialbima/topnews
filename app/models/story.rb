class Story < ApplicationRecord
  has_many :flags, dependent: :destroy
  has_many :flagging_users, through: :flags, source: :user
end
