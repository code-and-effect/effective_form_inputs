# = simple_form_for @thing do |f|
#   = f.input :updated_at, :as => :effective_date_time_picker

if defined?(SimpleForm)

  class EffectiveDateTimePickerInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      options = merge_wrapper_options(input_html_options, wrapper_options) || {}
      options['data-input-js-options'] = input_options.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }

      Inputs::EffectiveDateTimePicker::Field.new(object, object_name, template, attribute_name, options).to_html
    end
  end

end
