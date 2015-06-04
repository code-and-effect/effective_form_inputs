module Inputs
  module EffectiveSelect
    class Input < Effective::FormInput
      delegate :collection_select, :to => :@template

      # def default_options
      #   {label_method: :to_s, value_method: :to_s}

      def default_input_js
        {:theme => 'bootstrap', :minimumResultsForSearch => 6, :tokenSeparators => [',', ' '], :width => 'style'}
      end

      def default_input_html
        {class: :effective_select}
      end

      def to_html
        #collection_select(@object_name, @method, options[:collection], options[:label_method], options[:value_method], options.merge({:selected => value}), options)
        collection_select(@object_name, @method, options[:collection], options[:label_method], options[:value_method], options, tag_options)
      end

      def options
        super().tap do |options|
          options[:multiple] = true if options[:tags]
          options[:include_blank] = false if options[:multiple]
          options[:selected] = value
        end
      end

      def js_options
        super().tap do |js_options|
          js_options[:allowClear] = (!options[:multiple])
        end
      end
    end
  end
end
