# frozen_string_literal: true

class Team < ApplicationRecord
  has_one_attached :logo, service: :amazon

  has_many :players, class_name: 'User',
                     inverse_of: :team, dependent: :destroy
  has_many :scores, inverse_of: :team, dependent: :destroy

  validates :name, presence: true
end
