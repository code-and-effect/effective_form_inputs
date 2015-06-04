module Effective
  module FormBuilderInputs
    def effective_date_time_picker(method, options = {})
      Inputs::EffectiveDateTimePicker::Input.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_date_picker(method, options = {})
      Inputs::EffectiveDatePicker::Input.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_static_control(method, options = {})
      Inputs::EffectiveStaticControl::Input.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_select(method, options_tag = nil, options = {}, html_options = {})
      options[:collection] = options_tag
      options[:label_method] = :to_s if options[:label_method].nil?
      options[:value_method] = :to_s if options[:value_method].nil?
      Inputs::EffectiveSelect::Input.new(@object, @object_name, @template, method, options, html_options).to_html
    end

    # private

    # def merged_input_js_options(options)
    #   (options || {}).tap do |opts|
    #     js_options = opts.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }
    #     opts.reject! { |k, _| js_options.include?(k) }
    #     opts['data-input-js-options'] = js_options if js_options.present?
    #   end
    # end
  end
end
