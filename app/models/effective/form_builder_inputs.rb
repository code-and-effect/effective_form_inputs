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
  end
end
