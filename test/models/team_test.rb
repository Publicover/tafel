require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'should validate name' do
    team = Team.create
    assert_not team.save
    assert_not_nil team.errors[:line1]
  end

  test 'should know players' do
    assert teams(:one).players.size == User.where(team_id: teams(:one).id).count
  end
end
