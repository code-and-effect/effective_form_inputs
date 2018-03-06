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

    initializer 'effective_form_inputs.check_for_effective_bootstrap' do |app|
      Rails.application.config.to_prepare do
        if defined?(EffectiveBootstrap)
          raise 'effective_form_inputs and effective_bootstrap cannot be run alongside eachother. Sorry.'
        end
      end
    end
  end
end
