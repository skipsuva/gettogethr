module GatheringsHelper

  def sort_by_suggestion(collection)
    collection.sort_by { |item| item.suggested? ? 0 : 1 }
  end

  def row_class(gathering)
    case gathering.aasm_state
    when "open"
      "open"
    when "finalized"
      "finalized"
    else
      ""
    end
  end

  def render_time(time)
    time.strftime('%A, %e %B at %l %P')
  end

end
