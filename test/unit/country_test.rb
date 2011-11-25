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

  test 'should include title of advice in indexable_content' do
    country = Country.new(raw_travel_advice: {
      "travel_advice_sections" => [{
        "title" => "SECTION_TITLE_1",
        "body"  => {"plain" => "SECTION_BODY_1"}
      }, {
        "title" => "SECTION_TITLE_2",
        "body"  => {"plain" => "SECTION_BODY_2"}
      }]
    })

    indexable_content = country.indexable_content
    assert_match %r{\bSECTION_TITLE_1\b}, indexable_content
    assert_match %r{\bSECTION_TITLE_2\b}, indexable_content
  end

  test 'should include plain text of advice in indexable_content' do
    country = Country.new(raw_travel_advice: {
      "travel_advice_sections" => [{
        "title" => "SECTION_TITLE_1",
        "body"  => {"plain" => "SECTION_BODY_1"}
      }, {
        "title" => "SECTION_TITLE_2",
        "body"  => {"plain" => "SECTION_BODY_2"}
      }]
    })

    indexable_content = country.indexable_content
    assert_match %r{\bSECTION_BODY_1\b}, indexable_content
    assert_match %r{\bSECTION_BODY_2\b}, indexable_content
  end

  test 'should include mission addresses in indexable_content' do
    country = Country.new(raw_travel_advice: {"travel_advice_sections" => []})
    country.missions.build(address: "ADDRESS")

    indexable_content = country.indexable_content
    assert_match %r{\bADDRESS\b}, indexable_content
  end

  test 'should return empty indexable_content if raw_travel_advice is nil' do
    country = Country.new(raw_travel_advice: nil)
    assert_equal "", country.indexable_content
  end

  test 'should return empty indexable_content if travel_advice_sections is missing' do
    country = Country.new(raw_travel_advice: {})
    assert_equal "", country.indexable_content
  end
end
