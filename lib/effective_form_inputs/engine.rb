module EffectiveFormInputs
  class Engine < ::Rails::Engine
    engine_name 'effective_form_inputs'

    config.autoload_paths += Dir["#{config.root}/app/models/**/"]

    initializer 'effective_form_inputs.action_view' do |app|
      Rails.application.config.to_prepare do
        ActiveSupport.on_load :action_view do
          ActionView::Helpers::FormBuilder.send(:include, Effective::FormBuilderInputs)
        end
      end
    end

    # Include Helpers to base application
    initializer 'effective_form_inputs.action_controller' do |app|
      Rails.application.config.to_prepare do
        ActiveSupport.on_load :action_controller do
          helper EffectiveFormInputsHelper
        end
      end
    end


  end
end
