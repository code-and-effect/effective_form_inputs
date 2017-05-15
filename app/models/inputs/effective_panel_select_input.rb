# = simple_form_for @thing do |f|
#   = f.input :category, :as => :effective_panel_select

if defined?(SimpleForm)

  class EffectivePanelSelectInput < SimpleForm::Inputs::CollectionSelectInput
    def input(wrapper_options = nil)
      label_method, value_method = (detect_collection_methods rescue [:to_s, :to_s])

      options[:collection] = collection
      options[:label_method] = label_method unless options[:polymorphic]
      options[:value_method] = value_method unless options[:polymorphic]

      Inputs::EffectivePanelSelect::Input.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end
  end

end
