# = simple_form_for @thing do |f|
#   = f.input :email, :as => :effective_email

if defined?(SimpleForm)

  class EffectiveEmailInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Inputs::EffectiveEmail::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
