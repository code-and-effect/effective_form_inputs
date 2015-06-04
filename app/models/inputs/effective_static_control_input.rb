# = simple_form_for @thing do |f|
#   = f.input :member_id, :as => :static

if defined?(SimpleForm)

  class EffectiveStaticControlInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Inputs::EffectiveStaticControl::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
