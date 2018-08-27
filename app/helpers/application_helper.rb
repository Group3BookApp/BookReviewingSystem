module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def image_link_to(image_path, url, image_tag_options = { }, link_to_options = { })
    link_to url, link_to_options do
      image_tag image_path, image_tag_options
    end
  end
end
