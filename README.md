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

Edite o arquivo gerado pela instalação em `config/global_navigation.rb`

Edite as cores da barra na folha de estilos gerado em `app/assets/stylesheets/global_navigation.css`
