require 'rails/generators/base'

module GlobalNavigation
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Copia os arquivos necessários de configuração básica"

      def copy_stylesheets
        template "global_navigation.scss", "app/assets/stylesheets/global_navigation.scss"
      end

      def copy_navigation
        template "global_navigation.rb", "config/global_navigation.rb"
      end
    end
  end
end