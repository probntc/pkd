module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".base_title"
    title = page_title
    page_title.empty? ? base_title : title + " | " + base_title
  end
end
