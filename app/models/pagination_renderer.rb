class PaginationRenderer < WillPaginate::ActionView::LinkRenderer
    
    ELLIPSIS = "&hellip;"
    
    def to_html
        list_items = pagination.map do |item|
            case item
            when Fixnum
                page_number(item)
            else
                send(item)
            end
        end.join(@options[:link_separator])

        tag("div", list_items, class: 'ui pagination menu')
    end

    def container_attributes
        super.except(*[:link_options])
    end

    protected

    def page_number(page)
        link_options = @options[:link_options] || {}

        if page == current_page
            tag("a", page, class: "active item")
        else
            link(page, page, link_options.merge(rel: rel_value(page), class: "item"))
        end
    end

    def previous_or_next_page(page, text, classname)
        link_options = @options[:link_options] || {}

        if page
            link("<i class='" + classname + " arrow icon'></i>", page, link_options.merge(class: "icon item"))
        else
            link("<i class='" + classname + " arrow icon'></i>", page, link_options.merge(class: "icon item disabled"))
            tag("li", tag("span", text), class: "%s disabled" % classname)
        end
    end

    def gap
        tag("li", link(ELLIPSIS, "#"), class: "disabled")
    end

    def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], "left")
    end

    def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], "right")
    end

    def ul_class
        ["pagination", @options[:class]].compact.join(" ")
    end

end