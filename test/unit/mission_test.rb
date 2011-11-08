require 'test_helper'

class MissionTest < ActiveSupport::TestCase

  def valid_attributes
    {
      :country_fco_id => "country",
      :fco_id => "mission"
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

end
