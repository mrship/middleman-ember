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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
