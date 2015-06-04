module Inputs
  module EffectiveStaticControl
    class Input < Effective::FormInput
      delegate :content_tag, :to => :@template

      def default_input_html
        {class: 'form-control-static'}
      end

      def to_html
        content_tag(:p, value, tag_options)
      end

      def html_options
        super.tap do |html_options|
          html_options[:class].delete('form-control')
        end
      end

    end
  end
end

