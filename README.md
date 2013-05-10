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
  activate: :ember
```

Set the production variant in your build configuration:
```ruby
configure :build do
  set :ember_variant, :production
end
```

The gem uses handlebars-source, ember-source and ember-data-source for the Ember assets. If you want to have specific versions of ember, ember-data or handlebars specify those in your Gemfile, e.g:

```ruby
gem "handlebars-source", "~> 1.0.0.rc3"
gem "ember-source", "~>1.0.0.rc3"
gem "ember-data-source", "~> 0.0.5"

```

There are 3 helpers that expose the asset paths of the ember assets used, namely:
* ember_asset_path
* handlebars_asset_path
* ember_local_path

These are useful if you're using the [middleman-jasmine](https://github.com/mrship/middleman-jasmine) gem to allow you to add the ember and handlebars assets to another sprockets instance. e.g.:
```ruby
after_configuration do
  jasmine_sprockets.append_path(ember_asset_path)
  jasmine_sprockets.append_path(handlebars_asset_path)
  jasmine_sprockets.prepend_path(ember_local_path) unless ember_local_path.nil?
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
