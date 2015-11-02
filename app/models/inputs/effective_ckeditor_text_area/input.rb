module Inputs
  module EffectiveCkeditorTextArea
    class Input < Effective::FormInput
      delegate :content_tag, :text_area_tag, :to => :@template

      def default_input_js
        {effective_assets: defined?(EffectiveAssets).present? }
      end

      def default_input_html
        {class: 'effective_ckeditor_text_area text'}
      end

      def to_html
        text_area_tag(field_name, value, tag_options)
      end
    end
  end
end

