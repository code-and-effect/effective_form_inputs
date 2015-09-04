module Inputs
  module EffectiveSelect
    class Input < Effective::FormInput
      delegate :collection_select, :grouped_collection_select, :to => :@template

      def default_options
        {label_method: :to_s, value_method: :to_s, group_method: :second, group_label_method: :first, option_key_method: :second, option_value_method: :first}
      end

      def default_input_js
        {theme: 'bootstrap', minimumResultsForSearch: 6, tokenSeparators: [',', ' '], width: 'style', placeholder: 'Please choose'}
      end

      def default_input_html
        {class: 'effective_select', placeholder: 'Please choose'}
      end

      def to_html
        if options[:grouped]
          grouped_collection_select(@object_name, @method, collection, options[:group_method], options[:group_label_method], options[:option_key_method], options[:option_value_method], options, tag_options)
        else
          collection_select(@object_name, @method, collection, options[:value_method], options[:label_method], options, tag_options)
        end
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
          js_options[:tokenSeparators] = nil if options[:tags] != true
        end
      end
    end
  end
end
