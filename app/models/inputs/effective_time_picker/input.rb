module Inputs
  module EffectiveTimePicker
    class Input < Effective::FormInput
      delegate :content_tag, :text_field_tag, :to => :@template

      def default_input_js
        { format: 'LT', showClear: false, useCurrent: 'hour' }
      end

      def default_input_html
        {class: 'effective_time_picker time'}
      end

      def to_html
        if options[:input_group] == false
          return text_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, '', class: 'glyphicon glyphicon-time').html_safe
          end +
          text_field_tag(field_name, value, tag_options)
        end
      end

      def value
        val = super
        val.respond_to?(:strftime) ? val.strftime('%H:%M') : val
      end

      def html_options
        super.tap do |html_options|
          if js_options[:format] == default_input_js[:format] # Unless someone changed from the default
            html_options[:pattern] = '\d\d?:\d{2} \D{2}' # Match default pattern defined above
          end

          if options[:date_linked] == false
            html_options[:class] << 'not-date-linked'
          end

        end
      end
    end
  end
end

