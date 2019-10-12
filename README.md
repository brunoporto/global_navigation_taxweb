# GlobalNavigation

Navegação Global

## Dependências

- rails-sass
- simple-navigation

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

`app/assets/javascripts/application.js`:

```js
//= require global_navigation
```

`app/assets/stylesheets/application.js`:

```css
/*
*= require global_navigation/global_navigation
*/
```

## Configuração

### ITEMS DO MENU

Edite o arquivo gerado pela instalação em `config/global_navigation.rb`
:logo :src
:profile :src

fa_icon:
icon_class:

position: :primary
position: :secondary

type: :float_menu
group_title: true

### CORES DO TEMA

Edite as cores da barra na folha de estilos gerado em `app/assets/stylesheets/global_navigation.css`

### HTML (VIEW)

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
