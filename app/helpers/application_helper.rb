module ApplicationHelper

  def news_item_path(news_item)
    date = news_item.published_at.to_date
    "/news/#{date.year}/#{"%02d" % date.month}/#{"%02d" % date.day}/#{news_item.slug}"
  end

end
