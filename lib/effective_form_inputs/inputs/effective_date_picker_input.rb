# = simple_form_for @thing do |f|
#   = f.input :updated_at, :as => :effective_date_picker

if defined?(SimpleForm)

  class EffectiveDatePickerInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Effective::FormBuilderInputs::EffectiveDatePicker.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
