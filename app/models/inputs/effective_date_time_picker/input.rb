module Inputs
  module EffectiveDateTimePicker
    class Input < Effective::FormInput
      delegate :content_tag, :text_field_tag, :to => :@template

      def default_input_js
        {:format => 'YYYY-MM-DD h:mm A', :sideBySide => true}
      end

      def default_input_html
        {class: 'effective_date_time_picker datetime'}
      end

      def to_html
        if options[:input_group] == false
          return text_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, :class => 'input-group') do
          content_tag(:span, :class => 'input-group-addon') do
            content_tag(:i, '', :class => 'glyphicon glyphicon-calendar').html_safe
          end +
          text_field_tag(field_name, value, tag_options)
        end
      end

      def options
        super.tap do |options|
          unless js_options[:format].present?
            options[:pattern] = '\d{4}-\d{2}-\d{2} \d+:\d{2} [A-Z]{2}' # Match default pattern defined above
          end
        end
      end

      # def options
      #   super do |options|
      #     unless options['data-input-js-options'][:format].present?
      #       options[:pattern] = '\d{4}-\d{2}-\d{2} \d+:\d{2} [A-Z]{2}'
      #     end
      #   end
      # end

    end
  end
end

