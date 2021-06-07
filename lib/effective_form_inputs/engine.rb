module EffectiveFormInputs
  class Engine < ::Rails::Engine
    engine_name 'effective_form_inputs'

    config.autoload_paths += Dir["#{config.root}/lib/validators/"]
    config.eager_load_paths += Dir["#{config.root}/lib/validators/"]

    initializer 'effective_form_inputs.action_view' do |app|
      Rails.application.config.to_prepare do
        ActiveSupport.on_load :action_view do
          ActionView::Helpers::FormBuilder.send(:include, ::Effective::FormBuilderInputs)
        end
      end
    end

  end
end
