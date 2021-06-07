module Effective
  module FormBuilderInputs
    def effective_ckeditor_text_area(method, options_tag = nil, options = {}, html_options = {})
      EffectiveCkeditorTextArea.new(@object, @object_name, @template, method, options, html_options).to_html
    end

    def effective_date_time_picker(method, options = {})
      EffectiveDateTimePicker.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_date_picker(method, options = {})
      EffectiveDatePicker.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_panel_select(method, options_tag = nil, options = {}, html_options = {})
      options[:collection] = options_tag
      EffectivePanelSelect.new(@object, @object_name, @template, method, options, html_options).to_html
    end

    def effective_price(method, options = {})
      EffectivePrice.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_radio_buttons(method, options = {})
      EffectiveRadioButtons.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_static_control(method, options = {})
      EffectiveStaticControl.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_select(method, options_tag = nil, options = {}, html_options = {})
      options[:collection] = options_tag
      EffectiveSelect.new(@object, @object_name, @template, method, options, html_options).to_html
    end

    def effective_tel(method, options_tag = nil, options = {}, html_options = {})
      EffectiveTel.new(@object, @object_name, @template, method, options, html_options).to_html
    end

    def effective_time_picker(method, options = {})
      EffectiveTimePicker.new(@object, @object_name, @template, method, options, options).to_html
    end

    def effective_url(method, options_tag = nil, options = {}, html_options = {})
      EffectiveUrl.new(@object, @object_name, @template, method, options, html_options).to_html
    end

  end
end
