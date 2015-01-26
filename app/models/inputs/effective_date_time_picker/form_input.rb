# In a standard Rails form:
#
# = f.effective_date_time_picker :updated_at

module Inputs
  module EffectiveDateTimePicker

    extend ActiveSupport::Autoload
    autoload :FormInput

    module FormInput
      def effective_date_time_picker(method, options = {})
        options['data-input-js-options'] = options.reject { |k, _| EffectiveFormInputs::REJECTED_INPUT_JS_OPTIONS.include?(k) }
        Inputs::EffectiveDateTimePicker::Field.new(@object, @object_name, @template, method, options).to_html
      end
    end
  end
end
