# = simple_form_for @thing do |f|
#   = f.input :category, :as => :effective_select

if defined?(SimpleForm)

  class EffectiveSelectInput < SimpleForm::Inputs::CollectionSelectInput
    def input(wrapper_options = nil)
      label_method, value_method = detect_collection_methods

      options = merge_wrapper_options(input_html_options, wrapper_options) || {}

      # This gives us multiple and include_blank properly
      options.merge!(input_options.select { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) })

      options['data-input-js-options'] = input_options.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }

      options[:collection] = collection
      options[:label_method] = label_method
      options[:value_method] = value_method
      Inputs::EffectiveSelect::Input.new(object, object_name, template, attribute_name, options).to_html
    end
  end

end
