module EditsHelper
  def edit_action_name(edit)
    case edit.action
    when "creation" then "Created"
    when "revision" then "Revised"
    when "trash" then "Trashed"
    end
  end

  def format_diff_changes(changes)
    changes.map do |action, from, to|
      case action
      when "-" then content_tag(:del, from)
      when "+" then content_tag(:ins, to)
      when "!" then content_tag(:del, from) + content_tag(:ins, to)
      when "=" then from
      end
    end.join.html_safe
  end
end
