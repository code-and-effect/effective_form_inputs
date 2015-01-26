module EffectiveFormInputs
  class Engine < ::Rails::Engine
    engine_name 'effective_form_inputs'

    config.autoload_paths += Dir["#{config.root}/app/models/**/"]

    initializer 'effective_orders.action_view' do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Helpers::FormBuilder.send(:include, EffectiveFormInputs::FormInputs)

        # Going to have to add each custom namespace to SimpleForm
        SimpleForm.setup do |config|
          config.custom_inputs_namespaces << 'EffectiveDateTimePicker'
        end

      end
    end

  end
end
