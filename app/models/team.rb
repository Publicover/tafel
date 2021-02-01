class Team < ApplicationRecord
  has_many :players, class_name: 'User', foreign_key: 'team_id',
            inverse_of: :team, dependent: :destroy

  validates :name, presence: true
end
