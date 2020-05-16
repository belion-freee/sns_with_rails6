module ApplicationHelper
  def alert_name(key)
    {
      "notice" => "info",
      "alert"  => "danger"
    }.with_indifferent_access[key] || key
  end
end
