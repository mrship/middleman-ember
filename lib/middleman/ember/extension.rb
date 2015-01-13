require 'middleman-core'

require 'ember/source'
require 'handlebars/source'
begin
  require 'ember/data/source'
rescue LoadError
  # ember-data was not installed.
end

module Middleman
  module Ember
    class << self
      def registered(app, options_hash={}, &block)
        app.send :include, InstanceMethods
        app.set  :ember_variant, :development

        @@options = OpenStruct.new(default_options.merge(options_hash))
        yield @@options if block_given?

        app.after_configuration do
          # Create destination directory
          FileUtils.mkdir_p(ember_asset_path)

          # Generate ember source and destination paths
          ember_source_path = "#{@@options.ember_path}/ember"
          ember_destination_path = ember_asset_path.join("ember.js")

          # Copy the relevant version of ember
          if ember_variant == :production
            FileUtils.cp("#{ember_source_path}.prod.js", ember_destination_path)
          elsif FileTest.file?("#{ember_source_path}.debug.js")
            FileUtils.cp("#{ember_source_path}.debug.js", ember_destination_path)
          else
            FileUtils.cp("#{ember_source_path}.js", ember_destination_path)
          end


          # Only copy ember_data_path if defined. Allows you to just use Ember.
          if @@options.ember_data_path
            # Generate ember-data source and destination paths
            ember_data_source_path = "#{@@options.ember_data_path}/ember-data"
            ember_data_destination_path = ember_asset_path.join("ember-data.js")

            # Copy the relevant version of ember-data
            if ember_variant == :production
              FileUtils.cp("#{ember_data_source_path}.prod.js", ember_data_destination_path)
            else
              FileUtils.cp("#{ember_data_source_path}.js", ember_data_destination_path)
              # Copy ember-data map file if it exists
              if FileTest.file?("#{ember_data_source_path}.js.map")
                FileUtils.cp("#{ember_data_source_path}.js.map", ember_asset_path.join("ember-data.js.map"))
              end
            end
          end

          # Register ember path with sprockets
          sprockets.append_path(ember_asset_path)

          # Register handlebars path with sprockets
          sprockets.append_path(handlebars_asset_path)
        end
      end

      def ember_options
        @@options
      end

      private

      def default_options
        ember_data_path = defined?(::Ember::Data) ? ::Ember::Data::Source.bundled_path_for("") : nil
        {
          ember_path: ::Ember::Source.bundled_path_for(""),
          ember_data_path: ember_data_path,
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
