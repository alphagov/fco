module ApplicationHelper

  def news_item_path(news_item)
    date = news_item.published_at.to_date
    "/news/#{date.year}/#{"%02d" % date.month}/#{"%02d" % date.day}/#{news_item.slug}"
  end

  def long_format_date(time)
    "#{time.strftime("%A")} #{time.strftime("%d").to_i} #{time.strftime("%B %Y")}"
  end

end
