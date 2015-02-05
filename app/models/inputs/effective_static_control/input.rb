module Inputs
  module EffectiveStaticControl
    class Input < Effective::FormInput
      delegate :content_tag, :to => :@template

      def default_input_classes
        ['form-control-static']
      end

      def to_html
        if options[:class].kind_of?(Array)
          options[:class].delete('form-control')
        elsif options[:class].kind_of?(String)
          options[:class].gsub!('form-control', '')
        end

        content_tag(:p, value, options)
      end

    end
  end
end

