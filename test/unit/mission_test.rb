require 'test_helper'

class MissionTest < ActiveSupport::TestCase

  def valid_attributes
    {
      :latitude => 51.0,
      :longitude => 1.0,
      :fco_id => "country"
    }
  end

  test 'valid with valid attributes' do
    assert Mission.new(valid_attributes).valid?
  end

  test 'invalid without a latitude' do
    assert !Mission.new(valid_attributes.except(:latitude)).valid?
  end

  test 'invalid without a longitude' do
    assert !Mission.new(valid_attributes.except(:longitude)).valid?
  end

  test 'invalid without a fco_id' do
    assert !Mission.new(valid_attributes.except(:fco_id)).valid?
  end

end
