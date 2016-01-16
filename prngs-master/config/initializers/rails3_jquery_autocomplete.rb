Rails3JQueryAutocomplete::Helpers.module_eval do
  def json_for_autocomplete(items, targets)

    def class_name(item)
      item.class.name.downcase
    end

    def link(item)
      "#{class_name(item)}_url(#{item.id})"
    end

    items = items.collect do |item|
      { "id" => item.id,
        "label" => item.send( targets[ class_name(item).to_sym ][0] ),
        "value" => item.send( targets[ class_name(item).to_sym ][0] ),
        "url" => eval(link(item)),
        "category" => item.class.name.pluralize
      }
    end

    if items.length == 0
      [{ "nothing" => "No Results Found" }]
    else
      all_results_link = { "link" => "<a href='#'>Show all results...</a>".html_safe }
      items.unshift(all_results_link)
    end
  end
end