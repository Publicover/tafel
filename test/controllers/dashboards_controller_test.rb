# frozen_string_literal: true

require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect if not logged in' do
    get root_path
    assert_redirected_to user_session_path
  end

  test 'should log in' do
    login_as users(:admin)
    get root_path
    assert_response :success
  end
end
