# = simple_form_for @thing do |f|
#   = f.input :price, :as => :effective_price

if defined?(SimpleForm)

  class EffectivePriceInput < SimpleForm::Inputs::StringInput
    def input(wrapper_options = nil)
      Inputs::EffectivePrice::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
