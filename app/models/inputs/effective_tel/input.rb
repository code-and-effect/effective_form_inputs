module Inputs
  module EffectiveTel
    class Input < Effective::FormInput
      delegate :content_tag, :text_field_tag, :to => :@template

      DEFAULT_TEL_MASK = '(999) 999-9999? x99999'
      DEFAULT_CELL_MASK = '(999) 999-9999'

      def default_options
        {cellphone: false}
      end

      def default_input_html
        {class: 'effective_tel tel'}
      end

      def default_input_js
        {mask: DEFAULT_TEL_MASK, placeholder: '_'}
      end

      def to_html
        if options[:input_group] == false
          return text_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, '', class: "glyphicon glyphicon-#{options[:cellphone] ? 'phone' : 'earphone'}").html_safe
          end +
          text_field_tag(field_name, value, tag_options)
        end
      end

      def js_options
        super.tap do |js_options|
          if options[:cellphone] == true && js_options[:mask] == DEFAULT_TEL_MASK
            js_options[:mask] = DEFAULT_CELL_MASK
          end
        end
      end

    end
  end
end

