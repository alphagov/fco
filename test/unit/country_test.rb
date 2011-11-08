require 'test_helper'

class CountryTest < ActiveSupport::TestCase

  def valid_attributes
    {
      :name => "Country Name",
      :fco_id => "country_name",
      :iso_3166_1 => "AA",
      :slug => "country_name"
    }
  end

  test 'valid with valid attributes' do
    assert Country.new(valid_attributes).valid?
  end

  test 'invalid without a name' do
    assert !Country.new(valid_attributes.except(:name)).valid?
  end

  test 'invalid without an fco_id' do
    assert !Country.new(valid_attributes.except(:fco_id)).valid?
  end

  test 'invalid without an iso_3166_1' do
    assert !Country.new(valid_attributes.except(:iso_3166_1)).valid?
  end

end
