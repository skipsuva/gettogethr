module GatheringsHelper
  def sort_by_suggestion(collection)
    collection.sort_by { |item| item.suggested? ? 0 : 1 }
  end
end
