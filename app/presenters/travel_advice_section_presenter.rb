class TravelAdviceSectionPresenter

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper

  def initialize(section)
    @section = section
    @plain_body = section['body']['plain']
    @html_body = section['body']['markup']
    @title = section['title']
  end

  def body
    build_body.to_html.html_safe
  end

  def title
    @title.html_safe
  end

  private

  def doc
    @doc ||= Nokogiri::HTML::Document.new
  end

  def build_body
    Nokogiri::XML::DocumentFragment.new(doc).tap do |fragment|
      fragment << body_node
    end
  end

  def body_node
    Loofah.fragment(@html_body).
      scrub!(style_scrubber).
      scrub!(useless_tag_scrubber)
  end

  def header_node(doc)
    Nokogiri::XML::Node.new("h2", doc).tap do |n|
      n.content = @section['title']
    end
  end

  def style_scrubber
    @style_scrubber ||= Loofah::Scrubber.new do |node|
      node.remove_attribute('style')
    end
  end

  def useless_tag_scrubber
    @useless_tag_scrubber ||= Loofah::Scrubber.new do |node|
      if node.name == 'a' && node['href'].blank?
        node.replace node.inner_html
      end
    end
  end

end