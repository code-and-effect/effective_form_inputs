# = simple_form_for @thing do |f|
#   = f.input :category, :as => :effective_select

if defined?(SimpleForm)

  class EffectiveSelectInput < SimpleForm::Inputs::CollectionSelectInput
    def input(wrapper_options = nil)
      label_method, value_method = (detect_collection_methods rescue [:to_s, :to_s])

      options[:collection] = collection
      options[:label_method] = label_method unless options[:polymorphic]
      options[:value_method] = value_method unless options[:polymorphic]

      Effective::FormBuilderInputs::EffectiveSelect.new(object, object_name, template, attribute_name, input_options, (merge_wrapper_options(input_html_options, wrapper_options) || {})).to_html
    end

    # Apply ActsAsArchived behavior.
    def collection
      @collection ||= begin
        collection = translate(options.delete(:collection)) || self.class.boolean_collection
        collection.respond_to?(:call) ? collection.call : collection.to_a
      end
    end

    def translate(collection)
      return collection unless object.respond_to?(:new_record?)
      return collection unless collection.respond_to?(:klass) && collection.klass.respond_to?(:acts_as_archived?)

      if object.new_record?
        collection.unarchived
      else
        collection.unarchived.or(collection.archived.where(collection.klass.primary_key => object.send(attribute_name)))
      end
    end

  end

end
