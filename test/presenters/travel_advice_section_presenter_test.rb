# encoding: UTF-8

require 'test_helper'

class TravelAdviceSectionPresenterTest < ActiveSupport::TestCase

  test 'strips style atttibutes' do
    section = {
      'title' => "Hello World",
      'section_markup_id' => 'helloWorld',
      'body' => {
        'markup' => "<p>Hello <span style=\"color: red\">red</span> world.</p>"
      }
    }

    html = TravelAdviceSectionPresenter.new(section).html
    assert_equal "<h1>Hello World</h1><p>Hello <span>red</span> world.</p>", html
  end

  test 'strips style useless a tags' do
    section = {
      'title' => "Hello World",
      'section_markup_id' => 'helloWorld',
      'body' => {
        'markup' => "<p>Hello <a id=\"blah\">red</a> world. <a href=\"http://example.com\">Preserve this link</a>.</p>"
      }
    }

    html = TravelAdviceSectionPresenter.new(section).html
    assert_equal "<h1>Hello World</h1><p>Hello red world. <a href=\"http://example.com\">Preserve this link</a>.</p>", html
  end

end