# = simple_form_for @thing do |f|
#   = f.input :breakfast, :as => :effective_radio_buttons, :collection => ['Eggs', 'Bacon']

if defined?(SimpleForm)

  class EffectiveRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
    def input(wrapper_options = nil)
      label_method, value_method = (detect_collection_methods rescue [:to_s, :to_s])

      options[:collection] = collection
      options[:label_method] = label_method
      options[:value_method] = value_method
      options[:nested_boolean_style] = :nested if nested_boolean_style?

      Inputs::EffectiveRadioButtons::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end

  end

end
