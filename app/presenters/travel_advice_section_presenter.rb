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
    Loofah.fragment(@html_body).scrub!(style_scrubber).scrub!(remove_anchor_tags)
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

  def make_internal_links_relative
    @style_scrubber ||= Loofah::Scrubber.new do |node|
      node.remove_attribute('style')
    end
  end

  def remove_anchor_tags
    @remove_anchor_tags ||= Loofah::Scrubber.new do |node|
    #   if node.name == 'a' && node['href'].blank?
    #    node.children.each do |child|
    #      node.parent << child
    #     end
    #     node.remove
    #   end
    end
  end

end