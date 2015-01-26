module Inputs
  module EffectiveDateTimePicker
    class Field
      delegate :content_tag, :text_field_tag, :to => :@template

      def initialize(object, object_name, template, method, opts)
        @object = object
        @object_name = object_name
        @template = template
        @method = method
        @opts = opts
      end

      def default_js_options
        {:format => 'YYYY-MM-DD h:mm A', :sideBySide => true}
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

      # These two are for the text field

      def field_name
        @object_name + "[#{@method}]"
      end

      def value
        @object.send(@method)
      end

      def options
        @field_options ||= (@opts || {}).tap do |options|

          # Add appropriate classes
          [:effective_date_time_picker, :datetime].each do |c|
            if options[:class].blank?
              options[:class] = c.to_s
            elsif options[:class].kind_of?(Array)
              options[:class] << c unless options[:class].include?(c)
            elsif options[:class].kind_of?(String)
              options[:class] << (' ' + c.to_s) unless options[:class].include?(c.to_s)
            end
          end

          unless (options['data-input-js-options'][:format].present? rescue false)
            options[:pattern] = '\d{4}-\d{2}-\d{2} \d+:\d{2} [A-Z]{2}'
          end

          merged_input_js_options(options)
        end
      end

      def merged_class_options(*classes)

      end

      def merged_input_js_options(opts)
        (opts || {}).tap do |options|
          options['data-input-js-options'] = (
            JSON.generate((default_js_options || {}).merge(options['data-input-js-options'] || {})) rescue {}
          )
        end
      end

    end
  end
end

