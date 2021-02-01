ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require 'devise'
require 'minitest/autorun'
require 'minitest/pride'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def fill_in_game_team_ids
    games(:one).update(team_ids: [teams(:one).id, teams(:two).id])
    games(:two).update(team_ids: [teams(:one).id, teams(:two).id])
    games(:three).update(team_ids: [teams(:three).id])
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end
