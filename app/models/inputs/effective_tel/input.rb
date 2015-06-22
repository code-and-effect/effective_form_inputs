module Inputs
  module EffectiveTel
    class Input < Effective::FormInput
      delegate :content_tag, :telephone_field_tag, :to => :@template

      DEFAULT_TEL_MASK = '(999) 999-9999? x99999'
      DEFAULT_CELL_MASK = '(999) 999-9999'

      def default_options
        {cellphone: false, fax: false}
      end

      def default_input_html
        {class: 'effective_tel tel'}
      end

      def default_input_js
        {mask: DEFAULT_TEL_MASK, placeholder: '_'}
      end

      def to_html
        if options[:input_group] == false
          return telephone_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, '', class: "glyphicon glyphicon-#{glyphicon}").html_safe
          end +
          telephone_field_tag(field_name, value, tag_options)
        end
      end

      def fax?
        field_name.include?('fax') || options[:fax]
      end

      def cellphone?
        field_name.include?('cell') || options[:cellphone]
      end

      def glyphicon
        icon = 'earphone' # default

        icon = 'phone' if field_name.include?('cell')
        icon = 'phone-alt' if field_name.include?('fax')

        icon = 'phone' if options[:cellphone]
        icon = 'phone-alt' if options[:fax]

        icon
      end

      def js_options
        super.tap do |js_options|
          if (fax? || cellphone?) && js_options[:mask] == DEFAULT_TEL_MASK
            js_options[:mask] = DEFAULT_CELL_MASK
          end
        end
      end

    end
  end
end

