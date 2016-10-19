module Inputs
  module EffectiveUrl
    class Input < Effective::FormInput
      delegate :content_tag, :url_field_tag, :to => :@template

      def default_input_html
        {
          class: 'effective_url url',
          pattern: 'https?://[A-Za-z]+.+',
          placeholder: 'http://www.example.com',
          title: 'A URL starting with http:// or https://'
        }
      end

      def to_html
        if options[:input_group] == false
          return url_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
            content_tag(:i, '', class: 'glyphicon glyphicon-globe').html_safe
          end +
          url_field_tag(field_name, value, tag_options)
        end
      end
    end
  end
end

