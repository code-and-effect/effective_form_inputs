module Inputs
  module EffectivePrice
    class Input < Effective::FormInput
      delegate :content_tag, :number_to_currency, :text_field_tag, :hidden_field_tag, :to => :@template

      def default_input_html
        {class: 'effective_price numeric', maxlength: 14}
      end

      def to_html
        if options[:input_group] == false
          return text_field_tag(field_name, value, tag_options) + hidden_field_tag(field_name, price, id: price_field)
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
        val = (@value || 0) # This is 'super'
        val.kind_of?(Integer) ? ('%.2f' % (val / 100.0)) : ('%.2f' % val)
      end

      # These two are for the hidden input
      def price_field
        "#{field_name.parameterize.gsub('-', '_')}_value_as_integer"
      end

      def price
        val = (@value || 0) # This is 'super'
        val.kind_of?(Integer) ? val : (val * 100.0).to_i
      end

    end
  end
end

