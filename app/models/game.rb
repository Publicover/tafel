# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :scores, inverse_of: :game, dependent: :destroy
  accepts_nested_attributes_for :scores

  validates :name, :schedule_date, :team_ids, presence: true

  def teams
    team_ary = []
    team_ids.each do |team_id|
      team_ary << Team.find(team_id)
    end
    team_ary
  end

  def players
    user_ary = []
    teams.each do |team|
      user_ary << Team.find(team.id).players
    end
    user_ary.flatten
  end

  def player?(user)
    players.include?(user)
  end

  def create_scores
    team_ids.each do |team_id|
      Score.create(points: 0, game_id: id, team_id: team_id)
    end
  end
end
