require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'should validate name' do
    game = Game.create(schedule_date: Time.zone.today, team_ids: [teams(:one).id, teams(:two).id])
    assert_not game.save
    assert_not_nil game.errors[:line1]
  end

  test 'should validate schedule date' do
    game = Game.create(name: 'Cricket', team_ids: [teams(:one).id, teams(:two).id])
    assert_not game.save
    assert_not_nil game.errors[:line1]
  end

  test 'should validate team_ids' do
    game = Game.create(name: 'Cricket', schedule_date: Time.zone.today)
    assert_not game.save
    assert_not_nil game.errors[:line1]
  end

  test 'should know teams' do
    game = Game.create(name: 'Cricket',
                       schedule_date: Time.zone.today,
                       team_ids: [teams(:one).id, teams(:two).id])
    assert_equal game.teams.pluck(:id), game.team_ids
  end

  test 'should know players' do
    team_one_players = teams(:one).players.pluck(:id)
    team_two_players = teams(:two).players.pluck(:id)
    game = Game.create(name: 'Cricket',
                       schedule_date: Time.zone.today,
                       team_ids: [teams(:one).id, teams(:two).id])
    assert_equal [], game.players.pluck(:id) - team_one_players - team_two_players
  end

  test 'should know if it has individual player' do
    game = Game.create(name: 'Cricket',
                       schedule_date: Time.zone.today,
                       team_ids: [teams(:one).id, teams(:two).id])
    assert game.has_player?(users(:captain))
  end
end
