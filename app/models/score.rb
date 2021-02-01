# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :game, inverse_of: :scores
  belongs_to :team, inverse_of: :scores

  delegate :players, to: :team, allow_nil: true
end
