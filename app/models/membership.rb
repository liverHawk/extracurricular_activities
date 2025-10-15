class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum role: { user: 0, leader: 1, admin: 2 }
end
