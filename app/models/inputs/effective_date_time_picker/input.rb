module Inputs
  module EffectiveDateTimePicker
    class Input < Effective::FormInput
      delegate :content_tag, :text_field_tag, :to => :@template

      def default_input_js
        {format: 'YYYY-MM-DD HH:mm', sideBySide: true, showTodayButton: true, showClear: true}
      end

      def default_input_html
        {class: 'effective_date_time_picker datetime'}
      end

      def to_html
        if options[:input_group] == false
          return text_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, '', class: 'glyphicon glyphicon-calendar').html_safe
          end +
          text_field_tag(field_name, value, tag_options)
        end
      end

      def js_options
        opts = super
        return opts unless opts[:disabledDates]

        opts[:disabledDates] = Array(opts[:disabledDates]).map do |obj|
          if obj.respond_to?(:strftime)
            obj.strftime('%F')
          elsif obj.kind_of?(Range) && obj.first.respond_to?(:strftime)
            [obj.first].tap do |dates|
              dates << (dates.last + 1.day) until (dates.last + 1.day) > obj.last
            end
          elsif obj.kind_of?(String)
            obj
          elsif obj.nil?
            # Nothing
          else
            raise 'unexpected disabledDates data. Expected a DateTime, Range of DateTimes or String'
          end
        end.flatten.compact

        opts.delete(:disabledDates) unless opts[:disabledDates].present?

        opts
      end

      def html_options
        super.tap do |html_options|
          if js_options[:format] == default_input_js[:format] # Unless someone changed from the default
            html_options[:pattern] = '\d{4}(-\d{2})?-(\d{2})?( \d+)?(:\d{2})?' # Match default pattern defined above
          end
        end
      end
    end
  end
end

