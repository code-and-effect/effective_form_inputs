module Inputs
  module EffectiveSelect
    class Input < Effective::FormInput
      delegate :collection_select, :to => :@template

      def default_input_js_options
        {:minimumResultsForSearch => 6, :tokenSeparators => [',', ' '], :width => 'style'}
      end

      def default_input_classes
        [:effective_select]
      end

      def to_html
        collection_select(@object_name, @method, options.delete(:collection), options.delete(:label_method), options.delete(:value_method), options.merge({:selected => value}), options)
      end

      def options
        super do |options|
          options[:multiple] = true if options[:tags]

          # If multiple...
          options['data-input-js-options'][:allowClear] = (!options[:multiple])
          options[:include_blank] = false if options[:multiple]
        end
      end
    end
  end
end

