module Inputs
  module EffectiveStaticControl
    class Input < Effective::FormInput
      delegate :content_tag, :to => :@template

      def default_input_html
        {class: 'form-control-static'}
      end

      def to_html
        if value.kind_of?(String) && value.start_with?('<p>') && value.end_with?('</p>')
          content_tag(:p, value[3...-4].html_safe, tag_options)
        else
          content_tag(:p, (value.html_safe? ? value : value.to_s.html_safe), tag_options)
        end

      end

      def html_options
        super.tap do |html_options|
          html_options[:class].delete('form-control')
        end
      end

    end
  end
end

