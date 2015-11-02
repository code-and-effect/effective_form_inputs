# = simple_form_for @thing do |f|
#   = f.input :body_content, :as => :effective_ckeditor_text_area

if defined?(SimpleForm)

  class EffectiveCkeditorTextAreaInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Inputs::EffectiveCkeditorTextarea::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
