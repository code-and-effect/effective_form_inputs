module Inputs
  module EffectiveDatePicker
    class Input < Effective::FormInput
      delegate :content_tag, :text_field_tag, :to => :@template

      def default_input_js_options
        {:format => 'YYYY-MM-DD'}
      end

      def default_input_classes
        [:effective_date_picker, :date]
      end

      def to_html
        content_tag(:div, :class => 'input-group') do
          content_tag(:span, :class => 'input-group-addon') do
            content_tag(:i, '', :class => 'glyphicon glyphicon-calendar').html_safe
          end +
          text_field_tag(field_name, value, options)
        end
      end

      def options
        super do |options|
          unless options['data-input-js-options'][:format].present?
            options[:pattern] = '\d{4}-\d{2}-\d{2}'
          end
        end
      end

    end
  end
end

