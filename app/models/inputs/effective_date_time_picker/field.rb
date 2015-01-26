module Inputs
  module EffectiveDateTimePicker
    class Field < Effective::FormField
      delegate :content_tag, :text_field_tag, :to => :@template

      def default_input_js_options
        {:format => 'YYYY-MM-DD h:mm A', :sideBySide => true}
      end

      def default_input_classes
        [:effective_date_time_picker, :datetime]
      end

      def to_html
        content_tag(:div, :class => 'input-group') do
          content_tag(:span, :class => 'input-group-addon') do
            content_tag(:i, '', :class => 'glyphicon glyphicon-calendar').html_safe
          end +
          text_field_tag(field_name, value, options)
        end
      end

      private

      def options
        (@opts || {}).tap do |options|

          unless (options['data-input-js-options'][:format].present? rescue false)
            options[:pattern] = '\d{4}-\d{2}-\d{2} \d+:\d{2} [A-Z]{2}'
          end

          merge_class_options!(options)
          merge_input_js_options!(options)
        end
      end

    end
  end
end

