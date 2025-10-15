class Organization < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  enum status: { active: 0, inactive: 1 }
end
