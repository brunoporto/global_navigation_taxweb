require 'simple-navigation'

module GlobalNavigation
  class Engine < ::Rails::Engine
    SimpleNavigation.config_file_paths << File.expand_path('../../config', __FILE__)
  end
end
