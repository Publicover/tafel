# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :f_name, :l_name, :role, presence: true

  enum role: {
    admin: 0,
    captain: 1,
    player: 2
  }

  def full_name
    "#{f_name} #{l_name}"
  end

  private

    def team_id_present?
      team_id.present?
    end
end
