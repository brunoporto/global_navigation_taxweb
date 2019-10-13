class GlobalNavigationRenderer < SimpleNavigation::Renderer::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Context

  def render(item_container)
    SimpleNavigation.config.selected_class = 'selected'
    SimpleNavigation.config.active_leaf_class = 'selected'

    case item_container.level
    when 1
      master_items(item_container)
    else
      menu_items(item_container)
    end
  end

  def master_items(item_container)
    primary_items = []
    primary_item_first = nil
    secondary_items = []
    secondary_items_last = nil

    item_container.items.each do |item|
      item_options = item.send(:options) # private method
      item_options[:position] = :primary if item.key == :logo
      item_options[:position] = :secondary if item.key == :profile
      raise "Invalid Position" if item_options[:position].nil?

      if item_options[:position] == :secondary 
        if item.key == :profile
          secondary_items_last = master_navigation_item(item, item_options)
        else
          secondary_items << master_navigation_item(item, item_options)
        end
      else
        if item.key == :logo
          primary_item_first = master_navigation_item(item, item_options)
        else
          primary_items << master_navigation_item(item, item_options)
        end
      end
    end

    primary_items.unshift(primary_item_first) if primary_item_first
    secondary_items.push(secondary_items_last) if secondary_items_last

    content_tag(:div, class: 'items-list-container') do
      concat(content_tag(:div, content_list_to_html(primary_items), class: 'primary-items-list items-list')) if primary_items.present?
      concat(content_tag(:div, content_list_to_html(secondary_items), class: 'secondary-items-list items-list')) if secondary_items.present?
    end
  end

  def master_navigation_item(item, item_options)    
    float_menu = float_menu?(item)
    navigation_item_class = 'navigation-item'
    navigation_item_class = add_class(navigation_item_class, 'navigation-dropdown') if float_menu
    content_tag(:div, class: navigation_item_class) do
      concat(master_navigation_item_link(item, item_options))
      concat(master_navigation_dropdown(item)) if float_menu
    end
  end

  def master_navigation_dropdown(item)
    sub_items = []
    item.sub_navigation.items.each do |sub_item|
      sub_items << master_navigation_dropdown_item(sub_item)
    end
    return if sub_items.blank?

    content_tag(:div, class: 'navigation-dropdown-container') do
      content_tag(:div, class: 'navigation-dropdown-content') do
        content_list_to_html(sub_items)
      end
    end
  end

  def master_navigation_dropdown_item(item)
      item_options = item.send(:options) # private method
      if item_options[:group_title]
        content_tag(:div, class: 'navigation-dropdown-group-title') do
          content_tag(:span, item.name)
        end
      else
        link_options = link_options_for(item)
        link_options[:class] = add_class(link_options[:class], 'navigation-dropdown-item')        
        link_to(content_tag(:span, item.name), item.url, link_options)
      end
  end

  def master_navigation_item_link(item, item_options)
    position = item_options[:position]
    type = item_options[:type]
    link_options = link_options_for(item)
    link_options[:class] = add_class(link_options[:class], 'navigation-item-link')
    if item.key == :logo && position == :primary
      link_options[:class] = add_class(link_options[:class], 'first-item') 
      link_content = content_tag(:img, nil, src: item_options[:src], class: 'navigation-item-brand')
    elsif item.key == :profile && position == :secondary
      link_options[:class] = add_class(link_options[:class], 'last-item')
      link_content = content_tag(:img, nil, src: item_options[:src], class: 'profile-item-img')
    else
      link_content = content_tag(:i, nil, class: icon_class_from_options(item))
    end
    link_to(link_content, item.url, link_options)
  end

  def menu_items(item_container)
    menu_items = []
    return if float_menu?(item_container)

    item_container.items.each do |item|
      menu_items << menu_item(item)
    end
    content_list_to_html(menu_items)
  end

  def menu_item(item)
    item_options = item.send(:options) # private method
    if item_options[:group_title]
      content_tag(:div, class: 'navigation-menu-group-title') do
        content_tag(:span, item.name)
      end
    else
      menu_item_link(item)
    end
  end

  def menu_item_link(item)
    link_options = link_options_for(item)
    link_options[:class] = add_class(link_options[:class], 'navigation-menu-item')

    link_content = []
    link_content << content_tag(:div, class: 'navigation-menu-item-icon') do 
      icon_class = icon_class_from_options(item)
      # icon_class = 'far fa-fw fa-circle' if icon_class.blank? #Default icon
      content_tag(:i, nil, class: icon_class)
    end
    link_content << content_tag(:div, item.name, class: 'navigation-menu-item-label')

    link_to(content_list_to_html(link_content), item.url, link_options)
  end

  # Helper para adicionar novas classes a lista(string) de classes existentes
  def add_class(current_attributes, new_attributes)
    current_attributes ||= ''
    current_attributes.split(' ').push(new_attributes).join(' ')
  end

  def content_list_to_html(list_content = [])
    list_content.join.html_safe
  end

  def icon_class_from_options(item)
    item_options = item.send(:options) # private method
    item_options[:icon_class] if item_options[:icon_class].present?
  end

  def float_menu?(item)
    attrs = item.sub_navigation&.dom_attributes if item.is_a?(SimpleNavigation::Item)
    attrs = item.dom_attributes if item.is_a?(SimpleNavigation::ItemContainer)
    return false unless attrs

    attrs[:type] == :float_menu
  end
















  def render_primary_item(item)
    li_options = item.html_options.reject {|k, _| k == :link}

    link_options = link_options_for(item)
    link_options[:class] = add_class(link_options[:class], 'sidebar-menu-button')
    
    if include_sub_navigation?(item)
      link_options[:aria] = {controls: 'controls', selected: true}
      link_options[:data] = {toggle: "tab", target: "#sm_#{item.key}"}
      link_options[:role] = 'tab'
    end

    icon_classes = 'sidebar-menu-icon sidebar-menu-icon--left material-icons'
    if link_options[:icon]
      icon_class = link_options.delete(:icon)
      icon_element = content_tag(:i, icon_class, class: icon_classes)
    else
      icon_element = content_tag(:i, 'dvr', class: icon_classes)
    end

    text_element = content_tag(:span, item.name, class: 'sidebar-menu-text')

    link_content = content_list_to_html([icon_element, text_element])    
    link_element = content_tag(:a, link_content, link_options)

    li_options[:class] = add_class(li_options[:class], 'sidebar-menu-item')
    li_options[:data] = {boundary: :window, placement: :right, title: item.name, toggle: :tooltip}

    content_tag(:li, link_element, li_options)
  end

  def render_secondary_item(item)
    li_options = item.html_options.reject {|k, _| k == :link}
    li_options[:class] = add_class(li_options[:class], 'sidebar-menu-item')

    link_content = if include_sub_navigation?(item)
                     render_secondary_link_with_sub(item)
                   else
                     render_secondary_link(item)
                   end

    content_tag(:li, link_content, li_options)
  end

  def render_secondary_link(item)
    link_options = link_options_for(item)
    link_options[:class] = add_class(link_options[:class], 'sidebar-menu-button')

    link_text = content_tag(:span, item.name, class: 'sidebar-menu-text')
    link_to(link_text, item.url, link_options)
  end

  def render_secondary_link_with_sub(item)
    link_options = link_options_for(item)

    link_options[:class] = add_class(link_options[:class], 'sidebar-menu-button')
    link_options[:data] = {toggle: 'collapse', target: "#sm_#{item.key}"}

    link_text = content_tag(:span, item.name, class: 'sidebar-menu-text')

    link_toggle = content_tag(:span, nil, class: 'sidebar-menu-toggle-icon')
    link_badge = if link_options[:badge]
                   badge_text = link_options.delete(:badge)
                   content_tag(:span, badge_text, class: 'badge badge-primary')
                 else
                   ''
                 end

    link_toggle_badge = content_tag(:span,
                                    content_list_to_html([link_badge, link_toggle]),
                                    class: 'ml-auto d-flex align-items-center')

    link_content = content_list_to_html([link_text, link_toggle_badge])
    link_item = link_to(link_content, item.url, link_options)

    # SUB ITEMS
    sub_items = []
    item.sub_navigation.items.each do |sub_item|
      sub_items << render_secondary_item(sub_item)
    end

    ul_item = content_tag(:ul,
                          content_list_to_html(sub_items),
                          id: "sm_#{item.key}",
                          class: 'sidebar-submenu collapse')

    # LINK + SUB ITEMS
    content_list_to_html([link_item, ul_item])
  end

  def render_secondary_items(items, parent_item)
    ul_items = []

    items.each do |secondary_item|
      ul_items << render_secondary_item(secondary_item)
    end

    ul_content = content_tag(:ul, content_list_to_html(ul_items), class: 'sidebar-menu')

    drawer_block = content_tag(:div, ul_content, class: 'sidebar-block p-0')
    drawer_heading = content_tag(:div, parent_item.name, class: 'sidebar-heading')
    drawer_content = content_list_to_html([drawer_heading, drawer_block])
    drawer_options = {class: 'tab-pane fade', id: "sm_#{parent_item.key}"}

    if parent_item.selected?
      drawer_options[:class] = add_class(drawer_options[:class], 'active show')
    end

    content_tag(:div, drawer_content, drawer_options)
  end


end