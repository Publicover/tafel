require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should validate f_name' do
    user = User.create(email: 'test@place.com', password: 'password', l_name: 'Tester', role: :captain)
    assert_not user.save
    assert_not_nil user.errors[:line1]
  end

  test 'should validate l_name' do
    user = User.create(email: 'test@place.com', password: 'password', f_name: 'Tester', role: :captain)
    assert_not user.save
    assert_not_nil user.errors[:line1]
  end

  test 'should validate role' do
    user = User.create(email: 'test@place.com', password: 'password', f_name: 'Tester', l_name: 'Tester')
    assert_not user.save
    assert_not_nil user.errors[:line1]
  end
end
