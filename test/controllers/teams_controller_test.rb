require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  class Admin < TeamsControllerTest
    setup do
      @user = users(:admin)
      login_as @user
    end

    test 'should get index' do
      get teams_path
      assert_response :success
    end

    test 'should get single record' do
      get team_path(teams(:one))
      assert_response :success
    end

    test 'should get new' do
      get new_team_path
      assert_response :success
    end

    test 'should create' do
      assert_difference('Team.count') do
        post teams_path, params: { team: {
            name: 'The Mighty Testers',
            logo: fixture_file_upload('jennifer_connelly.jpg', 'image/jpg')
          }
        }
      end
      assert_equal 'jennifer_connelly.jpg', Team.last.logo.filename.to_s
    end

    test 'should get edit' do
      get edit_team_path(teams(:one))
      assert_response :success
    end

    test 'should update' do
      name = Faker::Lorem.word
      patch team_path(teams(:one)), params: { team: {
          name: name
        }
      }
      assert_equal teams(:one).reload.name, name
    end

    test 'should destroy' do
      assert_difference('Team.count', -1) do
        delete team_path(teams(:one))
      end
    end
  end

  class Captain < TeamsControllerTest
    setup do
      @user = users(:captain)
      login_as @user
    end

    test 'should get index' do
      get teams_path
      assert_response :success
    end

    test 'should get single record' do
      get team_path(teams(:one))
      assert_response :success
    end

    test 'should get new' do
      get new_team_path
      assert_response :success
    end

    test 'should create' do
      assert_difference('Team.count') do
        post teams_path, params: { team: {
            name: 'The Yo Ho Hoes',
            logo: fixture_file_upload('t2_fire_thumbs_up.jpg', 'image/jpg')
          }
        }
      end
      assert_equal 't2_fire_thumbs_up.jpg', Team.last.logo.filename.to_s
    end

    test 'should get edit if own record' do
      get edit_team_path(teams(:one))
      assert_response :success

      assert_raises(Pundit::NotAuthorizedError) {
        get edit_team_path(teams(:two))
      }
    end

    test 'should update if own record' do
      name = Faker::Lorem.word

      patch team_path(teams(:one)), params: { team: {
          name: name
        }
      }
      assert_equal teams(:one).reload.name, name

      assert_raises(Pundit::NotAuthorizedError) {
        patch team_path(teams(:two)), params: { team: {
            name: name
          }
        }
      }
    end

    test 'should destroy if own record' do
      assert_difference('Team.count', -1) do
        delete team_path(teams(:one))
      end
    end

    test 'should not destroy if not record owner' do
      assert_raises(Pundit::NotAuthorizedError) {
        delete team_path(teams(:two))
      }
    end
  end

  class Player < TeamsControllerTest
    setup do
      @user = users(:player)
      login_as @user
    end

    test 'should get index' do
      get teams_path
      assert_response :success
    end

    test 'should get single record' do
      get team_path(teams(:one))
      assert_response :success
    end

    test 'should not get new as player' do
      assert_raises(Pundit::NotAuthorizedError) {
        get new_team_path
      }
    end

    test 'should not create as player' do
      login_as users(:player)
      assert_raises(Pundit::NotAuthorizedError) {
        post teams_path, params: { team: {
            name: 'Payer Pianos',
            logo: fixture_file_upload('t2_fire_thumbs_up.jpg', 'image/jpg')
          }
        }
      }
    end

    test 'should not get edit' do
      assert_raises(Pundit::NotAuthorizedError) {
        get edit_team_path(teams(:one))
      }
    end

    test 'should not update' do
      assert_raises(Pundit::NotAuthorizedError) {
        patch team_path(teams(:one)), params: { team: {
            name: 'Gonna Flunk'
          }
        }
      }
    end

    test 'should not destroy' do
      assert_raises(Pundit::NotAuthorizedError) {
        delete team_path(teams(:one))
      }
    end
  end
end
