class TravelAdviceSectionPresenter

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper

  def initialize(section)
    @section = section
    @plain_body = section['body']['plain']
    @html_body = section['body']['markup']
    @internal_link = section['original_url']
  end

  def html
    build_document.to_html.html_safe
  end

  private

  def build_document
    doc = Nokogiri::HTML::Document.new
    Nokogiri::XML::DocumentFragment.new(doc).tap do |fragment|
      fragment << header_node(doc)
      fragment << body_node(doc)
    end

  end

  def body_node(doc)
    Loofah.fragment(@html_body).scrub!(style_scrubber)
  end

  def header_node(doc)
    Nokogiri::XML::Node.new("h1", doc).tap do |n|
      n.content = @section['title']
    end
  end

  def style_scrubber
    @style_scrubber ||= Loofah::Scrubber.new do |node|
      node.remove_attribute('style')
    end
  end

end