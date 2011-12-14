require "slimmer/headers"

class ApplicationController < ActionController::Base
  include Slimmer::Headers
  before_filter :set_analytics_headers

protected
  def set_analytics_headers
    set_slimmer_headers(
      section:     "FCO",
      need_id:     133,
      format:      "fco",
      proposition: "citizen"
    )
  end
end
