# = simple_form_for @thing do |f|
#   = f.input :member_id, :as => :static

if defined?(SimpleForm)

  class EffectiveStaticControlInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      options = merge_wrapper_options(input_html_options, wrapper_options) || {}
      options.merge!(input_options.select { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) })
      options['data-input-js-options'] = input_options.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }

      Inputs::EffectiveStaticControl::Input.new(object, object_name, template, attribute_name, options).to_html
    end
  end

end
