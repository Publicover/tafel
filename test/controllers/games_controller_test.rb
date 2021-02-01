require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    games(:one).update(team_ids: [teams(:one).id, teams(:two).id])
    games(:two).update(team_ids: [teams(:one).id, teams(:two).id])
    games(:three).update(team_ids: [teams(:three).id])
  end

  class Admin < GamesControllerTest
    setup do
      login_as users(:admin)
    end

    test 'should get index' do
      get games_path
      assert_response :success
    end

    test 'should get single game' do
      get games_path(games(:one))
      assert_response :success
    end

    test 'should get new page' do
      get new_game_path
      assert_response :success
    end

    test 'should create game' do
      assert_difference('Game.count') do
        post games_path, params: { game: {
            name: 'Test Game',
            schedule_date: Time.zone.tomorrow,
            team_ids: [teams(:one).id, teams(:two).id]
          }
        }
      end
    end

    test 'should get edit' do
      get edit_game_path(games(:one))
      assert_response :success
    end

    test 'should update game' do
      name = Faker::Lorem.word
      patch game_path(games(:one)), params: { game: {
          name: name
        }
      }
      assert_equal name, games(:one).reload.name
    end

    test 'should destroy game' do
      assert_difference('Game.count', -1) do
        delete game_path(games(:one))
      end
    end
  end

  class Captain < GamesControllerTest
    setup do
      login_as users(:captain)
    end

    test 'should not get index' do
      assert_raises(Pundit::NotAuthorizedError) {
        get games_path
      }
    end

    test 'should get show if playing' do
      get game_path(games(:one))
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get game_path(games(:three))
      }
    end

    test 'should get new' do
      get new_game_path
      assert_response :success
    end

    test 'should create' do
      assert_difference('Game.count') do
        post games_path, params: { game: {
            name: 'New Test',
            schedule_date: Time.zone.tomorrow,
            team_ids: [teams(:one).id, teams(:two).id]
          }
        }
      end
    end

    test 'should get edit' do
      get edit_game_path(games(:one))
      assert_response :success
    end

    test 'should update' do
      name = Faker::Lorem.word
      patch game_path(games(:one)), params: { game: {
          name: name
        }
      }
      assert_equal name, games(:one).reload.name
    end

    test 'should destroy own game' do
      assert_difference('Game.count', -1) do
        delete game_path(games(:one))
      end

      assert_raises(Pundit::NotAuthorizedError) {
        delete game_path(games(:three))
      }
    end
  end

  class Player < GamesControllerTest
    setup do
      login_as users(:player)
    end

    test 'should not get index' do
      assert_raises(Pundit::NotAuthorizedError) {
        get games_path
      }
    end

    test 'should show game if playing' do
      get game_path(games(:one))
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get game_path(games(:three))
      }
    end

    test 'should get new' do
      get new_game_path
      assert_response :success
    end

    test 'should create' do
      assert_difference('Game.count') do
        post games_path, params: { game: {
            name: 'Testing this here',
            schedule_date: Time.zone.tomorrow,
            team_ids: [teams(:one).id, teams(:two).id]
          }
        }
      end
    end

    test 'should get edit if playing' do
      get edit_game_path(games(:one))
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get edit_game_path(games(:three))
      }
    end

    test 'should update if playing' do
      get edit_game_path(games(:one))
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get edit_game_path(games(:three))
      }
    end

    test 'should destroy own game' do
      assert_difference('Game.count', -1) do
        delete game_path(games(:one))
      end

      assert_raises(Pundit::NotAuthorizedError) {
        delete game_path(games(:three))
      }
    end
  end
end
