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
    assert game.player?(users(:captain))
  end

  test 'should create scores' do
    game = games(:four)
    game.update(team_ids: [teams(:one).id, teams(:two).id])
    game.create_scores
    assert_not_nil game.scores.count
    scores = Score.where(game_id: game.id)
    assert_equal scores.count, game.scores.count
    assert_equal scores.first.team_id, teams(:one).id
    assert_equal scores.first.game_id, game.id
    assert_equal scores.last.team_id, teams(:two).id
    assert_equal scores.last.game_id, game.id
  end
end
