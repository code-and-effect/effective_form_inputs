module Effective
  module FormBuilderInputs
    def effective_date_time_picker(method, options = {})
      Inputs::EffectiveDateTimePicker::Input.new(@object, @object_name, @template, method, merged_input_js_options(options)).to_html
    end

    def effective_date_picker(method, options = {})
      Inputs::EffectiveDatePicker::Input.new(@object, @object_name, @template, method, merged_input_js_options(options)).to_html
    end

    def effective_static_control(method, options = {})
      Inputs::EffectiveStaticControl::Input.new(@object, @object_name, @template, method, merged_input_js_options(options)).to_html
    end

    private

    def merged_input_js_options(options)
      (options || {}).tap do |opts|
        js_options = opts.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }
        opts.reject! { |k, _| js_options.include?(k) }
        opts['data-input-js-options'] = js_options if js_options.present?
      end
    end
  end
end
