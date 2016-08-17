module Inputs
  module EffectivePrice
    class Input < Effective::FormInput
      delegate :content_tag, :number_to_currency, :text_field_tag, :hidden_field_tag, :to => :@template

      def default_options
        { include_blank: false }
      end

      def default_input_html
        { class: 'effective_price numeric', maxlength: 14, autocomplete: 'off' }
      end

      def to_html
        if options[:input_group] == false
          return text_field_tag(field_name, number_to_currency(value, unit: ''), tag_options) + hidden_field_tag(field_name, price, id: price_field)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, '$', class: 'input-group-addon') do
            content_tag(:i, '', class: 'glyphicon glyphicon-usd').html_safe
          end +
          text_field_tag(field_name, number_to_currency(value, unit: ''), tag_options) +
          hidden_field_tag(field_name, price, id: price_field)
        end
      end

      def value
        return nil if (@value == nil && options[:include_blank])

        val = (@value || 0) # This is 'super'
        val.kind_of?(Integer) ? ('%.2f' % (val / 100.0)) : ('%.2f' % val)
      end

      # These two are for the hidden input
      def price_field
        "#{field_name.parameterize.gsub('-', '_')}_value_as_integer"
      end

      def price
        return nil if (@value == nil && options[:include_blank])

        val = (@value || 0) # This is 'super'
        val.kind_of?(Integer) ? val : (val * 100.0).to_i
      end

      def html_options
        super().tap do |html_options|
          html_options['data-include-blank'] = options[:include_blank]
        end
      end

    end
  end
end

