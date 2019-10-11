bin_path = ENV["BUNDLE_BIN"] || "./bin"

desc "Instala os arquivos básicos de configuração"
namespace :global_navigation do
  task :install do
    exec "#{RbConfig.ruby} #{bin_path}/rails generate global_navigation:install"
  end
end
