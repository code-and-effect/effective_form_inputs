# = simple_form_for @thing do |f|
#   = f.input :phone, :as => :effective_tel

if defined?(SimpleForm)

  class EffectiveTelInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Inputs::EffectiveTel::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
