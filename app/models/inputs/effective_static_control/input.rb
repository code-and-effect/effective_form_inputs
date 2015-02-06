module Inputs
  module EffectiveStaticControl
    class Input < Effective::FormInput
      delegate :content_tag, :to => :@template

      def default_input_classes
        ['form-control-static']
      end

      def to_html
        content_tag(:p, value, options)
      end

      def options
        super do |options|
          options[:class].delete('form-control') if options[:class].kind_of?(Array)
          options[:class].delete!('form-control') if options[:class].kind_of?(String)
        end
      end

    end
  end
end

