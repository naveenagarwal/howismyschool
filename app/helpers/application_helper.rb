module ApplicationHelper
  def required_span_with(text)
    "#{text} <span class='required'>*</span>".html_safe
  end

  def answer_choices_for(object)
    return nil if object.answer_type.blank?

    case QuesAndAns::ANSWER_TYPE[object.answer_type]
    when "Mulitple Choice"
    end

  end
end
