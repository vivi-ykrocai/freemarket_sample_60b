module ApplicationHelper
  def sidebar_link(name, path)
    class_name = 'side--list--item'
    class_name << ' active' if current_page?(path)

    content_tag :div, class: class_name do
      link_to name, path, class: 'side--list--item--link'
    end
  end
end
