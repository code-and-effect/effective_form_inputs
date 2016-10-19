module Inputs
  module EffectiveUrl
    class Input < Effective::FormInput
      FA_FIELD_NAMES = ['facebook', 'google', 'linkedin', 'twitter', 'vimeo', 'youtube']

      delegate :content_tag, :url_field_tag, :to => :@template

      def default_input_html
        {
          class: 'effective_url url',
          pattern: 'https?://[A-Za-z0-9]+.+',
          placeholder: placeholder,
          title: 'A URL starting with http:// or https://'
        }
      end

      def to_html
        if options[:input_group] == false
          return url_field_tag(field_name, value, tag_options)
        end

        content_tag(:div, class: 'input-group') do
          content_tag(:span, class: 'input-group-addon') do
             glyphicon + fontawesome
          end +
          url_field_tag(field_name, value, tag_options)
        end
      end

      def placeholder
        if field_name.include?('facebook')
          'https://www.facebook.com/MyProfile'
        elsif field_name.include?('google')
          'https://plus.google.com/+MyProfile'
        elsif field_name.include?('linkedin')
          'https://www.linkedin.com/in/MyProfile'
        elsif field_name.include?('twitter')
          'https://twitter.com/MyProfile'
        elsif field_name.include?('vimeo')
          'https://vimeo.com/MyProfile'
        elsif field_name.include?('youtube')
          'https://www.youtube.com/user/MyProfile'
        else
          'http://www.example.com'
        end
      end

      def glyphicon
        if options[:glyphicon] == false
          ''.html_safe
        elsif options[:glyphicon] == true
          content_tag(:i, '', class: 'glyphicon glyphicon-globe')
        elsif options[:glyphicon].present?
          content_tag(:i, '', class: "glyphicon glyphicon-#{options[:glyphicon].to_s.gsub('glyphicon-', '')}")
        elsif defined?(FontAwesome) && FA_FIELD_NAMES.any? { |name| field_name.include?(name) } && options[:fontawesome] != false
          ''.html_safe
        else
          content_tag(:i, '', class: 'glyphicon glyphicon-globe')
        end
      end

      def fontawesome
        if options[:fontawesome] == false
          ''.html_safe
        elsif options[:fontawesome].present? && options[:fontawesome] != true
          content_tag(:i, '', class: "fa fa-#{options[:fontawesome].to_s.gsub('fa-', '')}")
        elsif field_name.include?('facebook')
          content_tag(:i, '', class: 'fa fa-facebook')
        elsif field_name.include?('google')
          content_tag(:i, '', class: 'fa fa-google')
        elsif field_name.include?('linkedin')
          content_tag(:i, '', class: 'fa fa-linkedin')
        elsif field_name.include?('twitter')
          content_tag(:i, '', class: 'fa fa-twitter')
        elsif field_name.include?('vimeo')
          content_tag(:i, '', class: 'fa fa-vimeo')
        elsif field_name.include?('youtube')
          content_tag(:i, '', class: 'fa fa-youtube')
        else
          ''.html_safe
        end
      end

    end
  end
end

