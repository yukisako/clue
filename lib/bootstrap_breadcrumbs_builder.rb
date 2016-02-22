class BootstrapBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    if @elements.present?
      @context.content_tag(:ol, class: 'breadcrumb', "vocab" => "http://schema.org/", "typeof" => "BreadcrumbList") do
        @elements.collect.with_index do |element, index|
          render_element(element, index)
        end.join.html_safe
      end
    else
      ''
    end
  end

  def render_element(element, index)
    current = @context.current_page?(compute_path(element))

    li = @context.content_tag(:li, :class => ('active' if current), "property" => "itemListElement", "typeof" => "ListItem") do
      link_or_text = @context.link_to_unless_current(@context.content_tag(:span, compute_name(element), "property" => "name"), compute_path(element), element.options.merge("property" => "item", "typeof" => "WebPage", "rel" => "nofollow") )
      meta = @context.content_tag(:meta, "", "property" => "position", "content" => index+1)
      link_or_text + meta
    end
    divider = @context.content_tag(:span, (@options[:separator]  || '/').html_safe, :class => 'divider') unless current
    li + (divider || '')
  end
end