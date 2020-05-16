module ApplicationHelper
  def alert_name(key)
    {
      "notice" => "info",
      "alert"  => "danger"
    }.with_indifferent_access[key] || key
  end

  def heart_icon(blog)
    suffix = blog.has_favorites?(current_user) ? "s" : "r"
    content_tag :i, "", class: "fa#{suffix} fa-heart"
  end
end
