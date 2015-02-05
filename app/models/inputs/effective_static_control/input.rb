module Inputs
  module EffectiveStaticControl
    class Input < Effective::FormInput
      delegate :content_tag, :to => :@template

      def to_html
        content_tag(:p, value, :class => 'form-control-static')
      end

    end
  end
end

