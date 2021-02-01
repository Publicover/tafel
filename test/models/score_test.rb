require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  setup do
    @score = scores(:game_one_team_one)
  end

  test 'should know team' do
    assert_equal @score.team.id, teams(:one).id
  end

  test 'should know game' do
    assert_equal @score.game.id, games(:one).id
  end

  test 'should know players' do
    assert_equal @score.players.size, @score.team.players.size
  end
end
