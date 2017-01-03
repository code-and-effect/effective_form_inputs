module Inputs
  module EffectiveRadioButtons
    class Input < Effective::FormInput
      delegate :collection_radio_buttons, :content_tag, :label_tag, :radio_button_tag, :to => :@template

      BOOLEAN_COLLECTION = [['Yes', true], ['No', false]]

      def default_options
        {label_method: :to_s, value_method: :to_s}
      end

      def default_input_html
        {class: 'effective_radio_buttons'}
      end

      def default_input_js
        {}
      end

      def to_html
        collection_radio_buttons(@object_name, @method, collection, options[:value_method], options[:label_method], {}, item_html_options, &proc { |builder| render_item(builder) })
      end

      def render_item(builder)
        if options[:nested_boolean_style] == :nested
          item = builder.label { builder.radio_button + builder.value }
        else
          item = builder.radio_button + builder.label { builder.value }
        end

        if options[:item_wrapper_tag]
          content_tag(options[:item_wrapper_tag], item, class: options[:item_wrapper_class])
        else
          item
        end
      end

      def item_html_options
        @item_html_options ||= { class: tag_options[:class] }
      end

      def html_options
        super.tap do |html_options|
          html_options[:class].delete('form-control')
        end
      end

      def collection
        @collection ||= begin
          collection = options.delete(:collection) || BOOLEAN_COLLECTION
          collection.respond_to?(:call) ? collection.call : collection.to_a
        end
      end

    end
  end
end

