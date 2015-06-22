module Inputs
  module EffectiveSelect
    class Input < Effective::FormInput
      delegate :collection_select, :to => :@template

      def default_options
        {:label_method => :to_s, :value_method => :to_s}
      end

      def default_input_js
        {theme: 'bootstrap', minimumResultsForSearch: 6, tokenSeparators: [',', ' '], width: 'style', placeholder: 'Please choose'}
      end

      def default_input_html
        {class: 'effective_select', placeholder: 'Please choose'}
      end

      def to_html
        collection_select(@object_name, @method, collection, options[:value_method], options[:label_method], options, tag_options)
      end

      def collection
        @collection ||= begin
          collection = options.delete(:collection)
          collection.respond_to?(:call) ? collection.call : collection.to_a
        end
      end

      def options
        super().tap do |options|
          options[:selected] = value if value

          options[:multiple] = true if (options[:tags] == true)
          options[:include_blank] = (options[:multiple] != true)
        end
      end

      def html_options
        super().tap do |html_options|
          html_options[:multiple] = options[:multiple]
        end
      end

      def js_options
        super().tap do |js_options|
          js_options[:allowClear] = (options[:multiple] != true)
          js_options[:tags] = (options[:tags] == true)
        end
      end
    end
  end
end
