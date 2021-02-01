require 'test_helper'

class ScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    fill_in_game_team_ids
  end

  class Admin < ScoresControllerTest
    setup do
      @score = scores(:game_one_team_one)
      login_as users(:admin)
    end

    test 'should get index' do
      get scores_path
      assert_response :success
    end

    test 'should get single record' do
      get scores_path(@score)
      assert_response :success
    end

    test 'should get new' do
      get new_score_path
      assert_response :success
    end

    test 'should create' do
      assert_difference('Score.count') do
        post scores_path, params: { score: {
            points: 100, game_id: games(:one).id, team_id: teams(:one).id
          }
        }
      end
    end

    test 'should get edit' do
      get edit_score_path(@score)
      assert_response :success
    end

    test 'should update score' do
      points = rand(1..1000)
      patch score_path(@score), params: { score: {
          points: points
        }
      }
      assert_equal points, @score.reload.points
    end

    test 'should destroy score' do
      assert_difference('Score.count', -1) do
        delete score_path(@score)
      end
    end

    class Captain < ScoresControllerTest
      setup do
        @score = scores(:game_one_team_one)
        login_as users(:captain)
      end

      test 'should not get index' do
        assert_raises(Pundit::NotAuthorizedError) {
          get scores_path
        }
      end

      test 'should get show if player' do
        get score_path(@score)
        assert_response :success

        assert_raises(Pundit::NotAuthorizedError) {
          get score_path(scores(:game_three_team_three))
        }
      end

      test 'should not get new' do
        assert_raises(Pundit::NotAuthorizedError) {
          get new_score_path
        }
      end

      test 'should not create' do
        assert_raises(Pundit::NotAuthorizedError) {
          post scores_path, params: { score: {
              points: 55, game_id: games(:one).id, team_id: teams(:one).id
            }
          }
        }
      end

      test 'should get edit if player' do
        get edit_score_path(@score)
        assert_response :success

        assert_raises(Pundit::NotAuthorizedError) {
          get edit_score_path(scores(:game_three_team_three))
        }
      end

      test 'should update if player' do
        points = rand(1..1000)
        patch score_path(@score), params: { score: {
            points: points
          }
        }
        assert_equal points, @score.reload.points

        assert_raises(Pundit::NotAuthorizedError) {
          patch score_path(scores(:game_three_team_three)), params: { score: {
              points: points
            }
          }
        }
      end

      test 'should not get destroy' do
        assert_raises(Pundit::NotAuthorizedError) {
          delete score_path(@score)
        }
      end
    end
  end

  class Player < ScoresControllerTest
    setup do
      @score = scores(:game_one_team_one)
      login_as users(:player)
    end

    test 'should not get index' do
      assert_raises(Pundit::NotAuthorizedError) {
        get scores_path
      }
    end

    test 'should get show if player' do
      get score_path(@score)
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get score_path(scores(:game_three_team_three))
      }
    end

    test 'should not get new' do
      assert_raises(Pundit::NotAuthorizedError) {
        get new_score_path
      }
    end

    test 'should not create' do
      assert_raises(Pundit::NotAuthorizedError) {
        post scores_path, params: { score: {
            points: 55, game_id: games(:one).id, team_id: teams(:one).id
          }
        }
      }
    end

    test 'should get edit if player' do
      get edit_score_path(@score)
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get edit_score_path(scores(:game_three_team_three))
      }
    end

    test 'should update if player' do
      points = rand(1..1000)
      patch score_path(@score), params: { score: {
          points: points
        }
      }
      assert_equal points, @score.reload.points

      assert_raises(Pundit::NotAuthorizedError) {
        patch score_path(scores(:game_three_team_three)), params: { score: {
            points: points
          }
        }
      }
    end

    test 'should not get destroy' do
      assert_raises(Pundit::NotAuthorizedError) {
        delete score_path(@score)
      }
    end
  end
end
