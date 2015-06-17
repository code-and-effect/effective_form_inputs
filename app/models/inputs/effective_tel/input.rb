module Inputs
  module EffectiveTel
    class Input < Effective::FormInput
      delegate :content_tag, :text_field_tag, :to => :@template

      def default_options
        { cellphone: false,  }
      end

      def default_input_html
        {class: 'effective_tel tel', pattern: '\d{3}-\d{3}-\d{4}'}
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
    end
  end
end

