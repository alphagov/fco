require 'test_helper'

class TravelNewsTest < ActiveSupport::TestCase

  def valid_attributes
    {
      :title => "Testing Title",
      :published_at => Time.now,
      :body_plain => "Hello world",
      :body_markup => "<p>Hello world</p>",
      :description => "Hello world",
      :url => "http://testing.com"
    }
  end

  test 'valid from the valid_attributes' do
    assert TravelNews.new(valid_attributes).valid?
  end

  test 'invalid without a title' do
    assert !TravelNews.new(valid_attributes.except(:title)).valid?
  end

  test 'invalid without a body_plain' do
    assert !TravelNews.new(valid_attributes.except(:body_plain)).valid?
  end

  test 'invalid without a body_markup' do
    assert !TravelNews.new(valid_attributes.except(:body_markup)).valid?
  end

  test 'invalid without a description' do
    assert !TravelNews.new(valid_attributes.except(:description)).valid?
  end

  test 'invalid without a url' do
    assert !TravelNews.new(valid_attributes.except(:url)).valid?
  end

  test 'setting the title also sets the slug' do
    tn = TravelNews.new
    tn.title = "Testing"
    assert_equal "testing", tn.slug
  end

  test 'the slug strips bad punctuation' do
    tn = TravelNews.new
    tn.title = "This isn't a test"
    assert_equal "this-isnt-a-test", tn.slug
  end

end
