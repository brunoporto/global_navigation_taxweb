SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = GlobalNavigationRenderer

  navigation.items do |navigation_bar|
    # Registro fixo, deve manter sempre esse nome, altere apenas a url e o :src para indicar uma imagem
    navigation_bar.item :logo, nil, root_path, src: asset_path("global_navigation/taxweb_icon_logo.png")

    # Registro fixo, deve manter sempre esse nome, altere apenas a url e o :src para indicar uma imagem
    navigation_bar.item :profile, nil, root_path, src: current_user&.avatar

    ## Icones
    ## fa_icon = atalho para ícone Fontawesome "fa fa-fw fa-*"
    ## icon_class = informe a classe para utilizar como ícone "icon icon-dashboard"

    ## Posição do ícone na barra principal (funciona apenas para itens do navigation_bar)
    ## position: :primary = topo
    ## position: :secondary = base

    ## Botão na parte superior da barra com sub-menus internos
    # navigation_bar.item :item_com_submenu, "Item com Sub-menu", item_com_submenu_path, fa_icon: 'star', position: :primary do |navigation_menu|
    #   # atributo 'position' não se aplica aos itens internos
    #   navigation_menu.item :sub_item, "Sub Item", sub_item_path
    # end

    ## Botão na parte inferior da barra sem sub-menus (link direto)
    # navigation_bar.item :item_sem_submenu, "Item sem Sub-menu", item_sem_submenu_path, fa_icon: 'plus', position: :secondary
  end
end
