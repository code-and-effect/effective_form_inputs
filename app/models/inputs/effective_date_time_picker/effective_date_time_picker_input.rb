# In simple_form:
#
# = f.input :updated_at, :as => :effective_date_time_picker

module EffectiveDateTimePicker
  class EffectiveDateTimePickerInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      options = merge_wrapper_options(input_html_options, wrapper_options) || {}

      js_options = input_options.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }
      options['data-input-js-options'] = js_options if js_options.present?

      Inputs::EffectiveDateTimePicker::Field.new(object, object_name, template, attribute_name, options).to_html
    end
  end
end
