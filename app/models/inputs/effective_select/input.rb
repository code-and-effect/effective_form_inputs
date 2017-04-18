module Inputs
  module EffectiveSelect
    class Input < Effective::FormInput
      delegate :collection_select, :grouped_collection_select, :hidden_field, :to => :@template

      def default_options
        {label_method: :to_s, value_method: :to_s, group_label_method: :first, group_method: :last, option_value_method: :first, option_key_method: :second }
      end

      def default_input_js
        { theme: 'bootstrap', minimumResultsForSearch: 6, tokenSeparators: [',', ';', '\n', '\t'], width: 'style', placeholder: 'Please choose' }
      end

      def default_input_html
        {class: 'effective_select', placeholder: 'Please choose'}
      end

      def to_html
        html = if options[:grouped] && options[:polymorphic]
          grouped_collection_select(@object_name, polymorphic_id_method, collection, options[:group_method], options[:group_label_method], options[:option_key_method], options[:option_value_method], options, tag_options)
        elsif options[:grouped]
          grouped_collection_select(@object_name, @method, collection, options[:group_method], options[:group_label_method], options[:option_key_method], options[:option_value_method], options, tag_options)
        elsif options[:polymorphic]
          collection_select(@object_name, polymorphic_id_method, collection, :second, :first, options, tag_options)
        else
          collection_select(@object_name, @method, collection, options[:value_method], options[:label_method], options, tag_options)
        end

        if options[:polymorphic]
          html += hidden_field(@object_name, polymorphic_type_method, value: polymorphic_type_value)
          html += hidden_field(@object_name, polymorphic_id_method, value: polymorphic_id_value)
        end

        html
      end

      # This is a grouped polymorphic collection
      # [["Clinics", [["Clinc 50", "Clinic_50"], ["Clinic 43", "Clinic_43"]]], ["Contacts", [["Contact 544", "Contact_544"]]]]
      def collection
        @collection ||= begin
          collection = options.delete(:collection) || []
          grouped = collection[0].kind_of?(Array) && collection[0][0].kind_of?(String) && collection[0][1].respond_to?(:to_a) && (collection[0][1] != nil) # Array or ActiveRecord_Relation

          if options[:grouped] && !grouped && collection.present?
            raise "Grouped collection expecting a Hash {'Posts' => Post.all, 'Events' => Event.all} or a Hash {'Posts' => [['Post A', 1], ['Post B', 2]], 'Events' => [['Event A', 1], ['Event B', 2]]}"
          end

          if grouped
            collection.each_with_index do |(name, group), index|
              collection[index][1] = group.respond_to?(:call) ? group.call : group.to_a
            end
          else
            collection = collection.respond_to?(:call) ? collection.call : collection.to_a
          end

          if options[:polymorphic]
            if grouped
              collection.each { |_, group| polymorphize_collection!(group) }
            else
              polymorphize_collection!(collection)
            end
          end

          collection.respond_to?(:call) ? collection.call : collection.to_a
        end
      end

      # Translate our Collection into a polymorphic collection
      def polymorphize_collection!(collection)
        unless options[:grouped] || collection[0].kind_of?(ActiveRecord::Base) || (collection[0].kind_of?(Array) && collection[0].length >= 2)
          raise "Polymorphic collection expecting a flat Array of mixed ActiveRecord::Base objects, or an Array of Arrays like [['Post A', 'Post_1'], ['Event B', 'Event_2']]"
        end

        collection.each_with_index do |obj, index|
          if obj.kind_of?(ActiveRecord::Base)
            collection[index] = [obj.public_send(options[:label_method]), "#{obj.class.model_name}_#{obj.to_param}"]
          end
        end
      end

      def polymorphic_type_method
        @method.to_s.sub('_id', '') + '_type'
      end

      def polymorphic_id_method
        @method.to_s.sub('_id', '') + '_id'
      end

      def polymorphic_value(obj)
        "#{obj.class.model_name}_#{obj.to_param}" if obj.present?
      end

      def polymorphic_type_value
        value.try(:class).try(:model_name)
      end

      def polymorphic_id_value
        value.try(:to_param)
      end

      def options
        @effective_select_options ||= super().tap do |options|
          options[:multiple] = true if (options[:tags] == true)
          options[:include_blank] = (options[:multiple] != true)

          # Fix the selected value, depending on our use case
          unless value.nil?
            case value
            when Array
              if options[:polymorphic]
                options[:selected] = value.map { |value| (polymorhpic_value(value) rescue value) }
              elsif value.first.respond_to?(options[:value_method])  # This is probably a belongs_to ActiveRecord object
                options[:selected] = value.map { |value| (value.public_send(options[:value_method]) rescue value) }
              end
            else  # Value is not an Array
              if options[:polymorphic]
                options[:selected] = polymorphic_value(value)
              elsif value.respond_to?(options[:value_method])  # This is probably a belongs_to ActiveRecord object
                options[:selected] = value.public_send(options[:value_method])
              end
            end

            options[:selected] ||= value
          end

        end
      end

      def html_options
        super().tap do |html_options|
          html_options[:multiple] = options[:multiple]
          html_options[:class] << 'polymorphic' if options[:polymorphic]
          html_options[:class] << 'grouped' if options[:grouped]
          html_options[:class] << 'hide-disabled' if options[:hide_disabled]
        end
      end

      def js_options
        @effective_select_js_options ||= super().tap do |js_options|
          js_options[:allowClear] = (options[:multiple] != true)
          js_options[:tags] = (options[:tags] == true)
          js_options[:tokenSeparators] = nil if options[:tags] != true

          # select2 doesn't support adding css classes to its input, so we support it through the
          # js_options[:containerClass] and js_options[:dropdownClass] methods
          # When we use options[:hide_disabled], we add the 'hide-disabled' class to both the container and the dropdown
          if options[:hide_disabled]
            js_options[:containerClass] = (arrayize_html_class_key(js_options[:containerClass]) + ['hide-disabled']).join(' ')
            js_options[:dropdownClass] = (arrayize_html_class_key(js_options[:dropdownClass]) + ['hide-disabled']).join(' ')
          end
        end
      end
    end
  end
end
