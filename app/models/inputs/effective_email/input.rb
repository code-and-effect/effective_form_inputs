module Inputs
  module EffectiveEmail
    class Input < Effective::FormInput
      delegate :content_tag, :email_field_tag, :to => :@template

      def default_input_html
        {
          class: 'effective_email email',
          placeholder: 'someone@example.com',
        }
      end

      def to_html
        if options[:input_group] == false
          return email_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, '', class: 'glyphicon glyphicon-envelope').html_safe
          end +
          email_field_tag(field_name, value, tag_options)
        end
      end
    end
  end
end

