# = simple_form_for @thing do |f|
#   = f.input :breakfast, :as => :effective_radio_buttons, :collection => ['Eggs', 'Bacon'], images => [asset_path('eggs.png'), asset_path('bacon.png')]

if defined?(SimpleForm)

  class EffectiveRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
    def input(wrapper_options = nil)
      label_method, value_method = (detect_collection_methods rescue [:first, :last])

      options[:collection] = collection
      options[:label_method] = label_method
      options[:value_method] = value_method
      options[:nested_boolean_style] = :nested if nested_boolean_style?

      # Wrapper
      options[:wrapper_html] ||= {}
      options[:wrapper_html][:class] = Array(options[:wrapper_html][:class])

      if options[:images]
        options[:wrapper_html][:class] << 'image_radio_buttons'
      end

      if options[:buttons]
        options[:wrapper_html][:class] << 'button_radio_buttons btn-group inline_radio_buttons'
        options[:wrapper_html][:data] = { toggle: 'buttons' }
      end

      if options[:inline] && !options[:buttons]
        options[:wrapper_html][:class] << 'inline_radio_buttons'
      end

      options[:wrapper_html][:class] = options[:wrapper_html][:class].join(' ')

      Inputs::EffectiveRadioButtons::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end

  end

end
