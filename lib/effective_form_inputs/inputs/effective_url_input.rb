# = simple_form_for @thing do |f|
#   = f.input :website, :as => :effective_url
#   = f.input :website, :as => :effective_url, :glyphicon => false
#   = f.input :website, :as => :effective_url, :fontawesome => false

if defined?(SimpleForm)

  class EffectiveUrlInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Effective::FormBuilderInputs::EffectiveUrl.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
