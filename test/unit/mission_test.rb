require 'test_helper'

class MissionTest < ActiveSupport::TestCase

  def valid_attributes
    {
      :country_fco_id => "country",
      :fco_id => "mission",
      :slug => "mission",
      :location_name => "Test Place",
      :designation => "Testing"
    }
  end

  test 'valid with valid attributes' do
    assert Mission.new(valid_attributes).valid?
  end

  test 'invalid without a fco_id' do
    assert !Mission.new(valid_attributes.except(:fco_id)).valid?
  end

  test 'invalid without a country_fco_id' do
    assert !Mission.new(valid_attributes.except(:country_fco_id)).valid?
  end

  test 'invalid without a location_name' do
    assert !Mission.new(valid_attributes.except(:location_name)).valid?
  end

  test 'generate_slug with a location_name and designation' do
    mission = Mission.new
    mission.location_name = "Test Place"
    mission.designation = "British Embassy"
    mission.generate_slug
    assert_equal "test-place-british-embassy", mission.slug
  end

  test 'generate_slug with a location_name but no designation' do
    mission = Mission.new
    mission.location_name = "Test Place"
    mission.generate_slug
    assert_equal "test-place", mission.slug
  end

end
