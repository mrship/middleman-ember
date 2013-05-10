require 'middleman-core'

module Middleman
  module Ember
    class << self
      def registered(app, options_hash={}, &block)
        app.send :include, InstanceMethods
        app.set  :ember_variant, :development

        @app = app
        app.after_configuration do
          FileUtils.mkdir_p(ember_asset_path)
          FileUtils.cp(::Ember::Source.bundled_path_for("ember.#{ember_version}js"), ember_asset_path.join("ember.js"))
          FileUtils.cp(::Ember::Data::Source.bundled_path_for("ember-data.#{ember_version}js"), ember_asset_path.join("ember-data.js"))
          sprockets.append_path(ember_asset_path)

          # allow for a local Ember variant
          sprockets.prepend_path(ember_local_path) unless ember_local_path.nil?

          # add in Handlebars path
          sprockets.append_path(handlebars_asset_path)
        end
      end

      private

      def ember_version
        @app.ember_variant == :production ? "prod." : ""
      end
      alias :included :registered
    end

    module InstanceMethods
      def ember_asset_path
        Pathname.new(File.join("#{@app.root}/tmp/middleman-ember"))
      end

      def handlebars_asset_path
        File.dirname(::Handlebars::Source.bundled_path)
      end

      def ember_local_path
        local_path = "#{root}/vendor/assets/ember/#{app.ember_variant}"     
        File.directory?(local_path) ? local_path : nil
      end
    end

  end
end