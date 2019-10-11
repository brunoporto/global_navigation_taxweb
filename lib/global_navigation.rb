require 'simple-navigation'

require "global_navigation/global_navigation_renderer"
require "global_navigation/engine"

module GlobalNavigation
  SimpleNavigation.register_renderer global_navigration_renderer: GlobalNavigationRenderer
end
