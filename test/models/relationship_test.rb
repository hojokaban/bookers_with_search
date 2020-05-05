require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  
  def setup
  	@relationship = Relationship.new(follower_id: users(:luffy).id,
  		                             followed_id: users(:zoro).id)
  end

  test "should be valid" do
  	assert @relationship.valid?
  end

  test "should have follower" do
  	@relationship.follower_id = nil
  	assert_not @relationship.valid?
  end

  test "should have followed" do
  	@relationship.followed_id = nil
  	assert_not @relationship.valid?
  end

end
