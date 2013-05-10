require 'middleman-core'

module Middleman
  module Ember
    class << self
      def registered(app, options_hash={}, &block)
        app.send :include, InstanceMethods
        app.set  :ember_variant, :development

        @@options = OpenStruct.new(default_options.merge(options_hash))
        yield @@options if block_given?

        app.after_configuration do
          ember_version = 
            if ember_variant == :production
              "prod."
            else
              ""
            end

          # copy in the relevant version of Ember
          FileUtils.mkdir_p(ember_asset_path)
          FileUtils.cp("#{@@options.ember_path}/ember.#{ember_version}js", ember_asset_path.join("ember.js"))
          FileUtils.cp("#{@@options.ember_data_path}/ember-data.#{ember_version}js", ember_asset_path.join("ember-data.js"))
          sprockets.append_path(ember_asset_path)

          # add in Handlebars path
          sprockets.append_path(handlebars_asset_path)
        end
      end

      def ember_options
        @@options
      end

      private

      def default_options
        {
          ember_path: ::Ember::Source.bundled_path_for(""),
          ember_data_path: ::Ember::Data::Source.bundled_path_for(""),
          handlebars_path: File.dirname(::Handlebars::Source.bundled_path)
        }
      end
      alias :included :registered
    end

    module InstanceMethods
      def ember_asset_path
        Pathname.new(File.join("#{root}/tmp/middleman-ember"))
      end

      def handlebars_asset_path
        ::Middleman::Ember.ember_options.handlebars_path
      end
    end
  end
end
