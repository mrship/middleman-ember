# Middleman::Ember

Adds Ember assets to a Middleman project. Support for production version of Ember when building.

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-ember'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-ember

## Usage

Add the following code to your `config.rb` file:
```ruby
activate :ember
```

Set the production variant in your build configuration:
```ruby
configure :build do
  set :ember_variant, :production
end
```

By default, the gem uses handlebars-source and ember-source for the Ember assets. If you want to have specific gem versions of ember or handlebars or to add ember-data specify those in your Gemfile, e.g:

```ruby
gem "handlebars-source", "~> 1.0.0.rc6"
gem "ember-source", "~>1.0.0.rc6"
gem "ember-data-source", "~> 0.13"

```

If you want to use a local version of ember, ember-data or handlebars, set that in the configuration, i.e.
```ruby
activate :ember do |ember|
  ember.ember_path      = "/path/to/ember_js/dist"
  ember.ember_data_path = "/path/to/ember_data/dist"
  ember.handlebars_path = "/path/to/handlebars/dist"
end
```

There are also 2 helpers that expose the asset paths of the ember assets used, namely:
* ember_asset_path
* handlebars_asset_path

These are useful if you're using the [middleman-jasmine](https://github.com/mrship/middleman-jasmine) gem to allow you to add the ember and handlebars assets to another sprockets instance. e.g.:
```ruby
after_configuration do
  jasmine_sprockets.append_path(ember_asset_path)
  jasmine_sprockets.append_path(handlebars_asset_path)
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
