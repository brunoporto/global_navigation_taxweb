# GlobalNavigation

Navegação Global

## Dependências

- [sass-rails](https://github.com/rails/sass-rails)
- [simple-navigation](https://github.com/codeplant/simple-navigation)
- [haml](https://github.com/haml/haml)

A gem não atribuiu dependência de versão ao arquivo gemspec para que você possa instalar a melhor versão de acordo com o seu Rails.

## Instalação

Adicione ao Gemfile do seu aplicativo:

```ruby
gem 'global_navigation', :git => 'https://OAUTH_TOKEN:x-oauth-basic@github.com/taxweb/global_navigation'
```

Depois execute:

```bash
$ bundle install
$ rake global_navigation:install
```

Adicione os assets:

**JS**

```js
//= require global_navigation/global_navigation
```

**SCSS**

```scss
/*
*= require global_navigation
*/
```

## ITEMS DO MENU

Edite o arquivo gerado pela instalação em `config/global_navigation.rb`

Siga as regras e configurações do simple_navigation.

Para identificar a rota atual e escolher o bloco ativo, o simples_navigation utiliza a url atual, portanto itens com a mesma URL ou com urls encadeadas podem gerar conflitos e identificar mais de um item como ativo. Exemplo:

```
Admin:
  Usuários -> /users

Usuário:
  Editar -> /users/xxxxxxx/edit
```

Nesse caso, estando na roda /users, ele irá ativar também o /users/xxxxx/edit pois ele identifica o segundo item como sub-item do primeiro.

O comportamento de seleção do item ativo é feito pelo simple_navigation, portanto caso encontre problemas de conflito entre as rotas, utilize o atributo `highlights_on`.

Estude bem a GEM simple_navigation e seus comportamentos para que possa evitar conflitos de rotas e entender como ele funcina para criar um arquivo de configuração do Menu bem definido.

A gem global_navigation é um **renderizador** do menu e utiliza o simple_navigation como base em todo seu comportamento de exibição e atribuição dos itens do menu.

### ITEM PARA EXIBIR O LOGOTIPO

Possui a posição fixa sempre como o primeiro item da barra, não importa em qual ordem você informe ele no arquivo.

Essa linha deve ter sempre o `ID :logo` e o atributo `:src` para informar a imagem do logo.

```ruby
navigation_bar.item :logo, "Taxconsole", root_path, src: asset_pat("logo.png")
```

![Item tipo Logotipo](docs/item_logotipo.png)

### ITEM PARA EXIBIR O USUÁRIO

Possui a posição fixa sempre como o último item da barra, não importa em qual ordem você informe ele no arquivo.

Essa linha deve ter sempre o `ID :profile` e o atributo `:src` para informar a imagem do perfil do usuário.

```ruby
navigation_bar.item :profile, "Seu perfil", user_path(current_user), src: asset_path(current_user.avatar)
```

![Item tipo Usuário](docs/item_usuario.png)

### CONFIGURAR ICONES DOS ITENS

Os ícones do menu devem ser utilizados como classe de estilo, exemplo do uso do Fontawesome : `fa fa-user`

Para informar a classe você deve utilizar o atributo `icon_class` no item que deseja exibir o ícone.

Exemplo:

```ruby
navigation_bar.item :apps, "Aplicativos", apps_path, icon_class: 'fa fa-fw fa-star'
```

![Ícones](docs/icones.png)

Items de menu flutuante não aceitam configurações de ícone, caso o atributo `icon_class` seja informado em um item de menu flutuante, ele será ignorado.

### CONFIGURAR POSICAO DO ITEM NA BARRA

A barra de menu lateral possui dois grupos de ícones, o grupo primarios `primary`, posicionados no topo da barra e o grupo secundário `secondary` posicionado na parte inferior da barra.

Informe o atributo `position` e os valores `primary` ou `secondary` para indicar onde deseja exibir o item.

Exemplo:

```ruby
navigation_bar.item :plus, "Plus", root_path, icon_class: 'fa fa-fw fa-plus', position: :primary
navigation_bar.item :bell, "Bell", root_path, icon_class: 'fa fa-fw fa-bell', position: :secondary
```

![Posições na Barra](docs/posicoes.png)

Ele segue a ordem no qual os ícones são informados no arquivo de configuração.

### CRIAR ITEM COM SUB-ITENS

Você pode criar itens de submenu para os itens da barra principal, sendo esses itens exibidos em um menu lateral dentro da página ou através de um menu flutuante.

Para utilizar o menu lateral da página, basta informar os itens e acessar os endereços filhos do menu superior. Exemplo:

```ruby
  navigation_bar.item :admin, "Admin", admin_path, icon_class: 'fa fa-fw fa-star', position: :secondary do |navigation_menu|
    navigation_menu.item :apps, "Apps", apps_path
    navigation_menu.item :users, "Users", users_path
  end
```

![Subitens laterais](docs/subitens_lateral.png)

Para ativar o menu flututante, você deve seguir o mesmo procedimento do menu lateral, porém deve informar no contexto do menu que ele é flutuante através do atributo `:type` passado no `dom_attributes`. Exemplo:

```ruby
  navigation_bar.item :admin, "Admin", admin_path, icon_class: 'fa fa-fw fa-star', position: :secondary do |navigation_menu|
    navigation_menu.dom_attributes = {type: :float_menu} # Menu Flutuante
    navigation_menu.item :apps, "Apps", apps_path
    navigation_menu.item :users, "Users", users_path
  end
```

![Subitens Flutuantes](docs/subitens_flutuantes.png)

### ADICIONAR TITULO AO MENU LATERAL

Para adicionar um item de título no menu lateral para criar grupos dentro do menu, informe o atributo `group_title: true` no item. Exemplo:

```ruby
  navigation_bar.item :admin, "Admin", admin_path, icon_class: 'fa fa-fw fa-star', position: :secondary do |navigation_menu|
    navigation_menu.item :title1, "Administração", nil, group_title: true
    navigation_menu.item :apps, "Apps", apps_path
    navigation_menu.item :users, "Users", users_path
  end
```

![Título Menu Lateral](docs/titulo_menu_lateral.png)

### ADICIONAR TITULO AO MENU FLUTUANTE

Para adicionar um item de título no menu flutuante para criar grupos dentro do menu, informe o atributo `group_title: true` no item. Exemplo:

```ruby
  navigation_bar.item :admin, "Admin", admin_path, icon_class: 'fa fa-fw fa-star', position: :secondary do |navigation_menu|
    navigation_menu.dom_attributes = {type: :float_menu} # Menu Flutuante

    navigation_menu.item :title1, "Cadastros", nil, group_title: true
    navigation_menu.item :apps, "Apps", apps_path
    navigation_menu.item :users, "Users", users_path

    navigation_menu.item :title2, "Configurações", nil, group_title: true
    navigation_menu.item :config, "Minha Conta", admin_account_path
  end
```

![Títulos Menu Flutuante](docs/titulos_menu_flutuante.png)

## CONFIGURAR CORES DE TEMA DA BARRA

Edite as cores da barra na folha de estilos gerado em `app/assets/stylesheets/global_navigation.scss`

## ADICIONAR LEIAUTE DA BARRA DO APLICATIVO

Coloque o conteúdo das suas páginas dentro do escopo do layout do Global Navigation, adicionando ao seu arquivo de leiaute (`app/views/layouts/application.html.erb` dessa forma:

**ANTES:**

```erb
  <body>
    <main>
      <%= yield %>
    </main>
  </body>
```

**DEPOIS**

```erb
  <body>
    <%= render layout: 'layouts/global_navigation/layout' do -%>
      <main>
        <%= yield %>
      </main>
    <% end %>
  </body>
```

## ADICIONAR CONTEUDO NO CABEÇALHO DO MENU LATERAL

Para adicionar um cabeçalho no menu lateral atual, utilize o helper `content_for`. Você pode informar HTML. Exemplo:

```erb
<%= content_for :global_navigation_menu_top do %>
  <h1>Título do Menu lateral!</h1>
<% end %>
```

![Cabeçalhos do Menu Lateral](docs/cabecalho_menu_lateral.png)

## ADICIONAR CONTEUDO NO RODAPÉ DO MENU LATERAL

Para adicionar um rodapé no menu lateral atual, utilize o helper `content_for`. Você pode informar HTML. Exemplo:

```erb
<%= content_for :global_navigation_menu_bottom do %>
  <i>Rodapé do Menu lateral!</i>
<% end %>
```

![Rodapé do Menu Lateral](docs/rodape_menu_lateral.png)
