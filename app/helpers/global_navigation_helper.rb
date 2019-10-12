module GlobalNavigationHelper
  def show_navigation_menu?
    content_for?(:global_navigation_menu_top) ||
      content_for?(:global_navigation_menu_bottom) || 
      (
        active_navigation_item_container(context: :global, level: 2)&.items&.count&.positive? && 
        active_navigation_item_container(context: :global, level: 2)&.dom_attributes.try(:[], :type) != :float_menu
      )
  end
end