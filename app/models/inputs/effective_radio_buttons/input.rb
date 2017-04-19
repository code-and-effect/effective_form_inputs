module Inputs
  module EffectiveRadioButtons
    class Input < Effective::FormInput
      delegate :collection_radio_buttons, :content_tag, :label_tag, :radio_button_tag, :image_tag, :to => :@template

      BOOLEAN_COLLECTION = [['Yes', true], ['No', false]]

      def default_options
        { label_method: :first, value_method: :last }
      end

      def default_input_html
        { class: 'effective_radio_buttons' }
      end

      def default_input_js
        {}
      end

      def to_html
        initialize_and_validate_images!
        collection_radio_buttons(@object_name, @method, collection, options[:value_method], options[:label_method], options.slice(:checked), item_html_options, &proc { |builder| render_item(builder) })
      end

      def render_item(builder)
        if options[:inline] || options[:buttons]
          item = builder.radio_button + item_image_or_text(builder)
        elsif options[:nested_boolean_style] == :nested
          item = builder.label { builder.radio_button + item_image_or_text(builder) }
        else
          item = builder.radio_button + builder.label { item_image_or_text(builder) }
        end

        if options[:buttons]
          @button_index ||= -1; @button_index += 1
        end

        if options[:item_wrapper_tag]
          active = (builder.object.send(options[:value_method]).to_s == value.to_s)

          content_tag(options[:item_wrapper_tag], item,
            class: [
              options[:item_wrapper_class],
              ('btn btn-default' if options[:buttons]),
              ('radio-first' if options[:buttons] && @button_index == 0),
              ('active' if active)
            ].flatten.compact.uniq.join(' ')
          )
        else
          item
        end
      end

      def item_image_or_text(builder)
        @images_index += 1

        if options[:images]
          image_tag(options[:images][@images_index], alt: builder.text)
        else
          builder.text
        end
      end

      def item_html_options
        @item_html_options ||= { class: tag_options[:class], name: tag_options[:name] }.delete_if { |k, v| v.blank? }
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

      def value
        options[:checked] || super
      end

      def options
        @effective_radio_buttons_options ||= super().tap do |options|
          options[:item_wrapper_class] = Array(options[:item_wrapper_class]).flatten.uniq

          if options[:inline] || options[:buttons]
            options[:item_wrapper_tag] = :label unless options[:buttons]
            options[:item_wrapper_class] = 'radio-inline'
          end

        end
      end

      private

      def initialize_and_validate_images!
        @images_index = -1
        return unless options[:images].present?

        unless options[:images].kind_of?(Array) && (options[:images].first || '').kind_of?(String)
          raise 'images must be an Array of Strings'
        end

        unless options[:images].length == collection.length
          raise "images length must match collection length (#{collection.length})"
        end
      end

    end
  end
end

