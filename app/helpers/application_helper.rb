module ApplicationHelper
  def required_span_with(text)
    "#{text} <span class='required'>*</span>".html_safe
  end
end
