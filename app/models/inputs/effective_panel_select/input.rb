# This is a unique form input
# Takes in the same collection as a grouped select
# Displays the groups on the left, and each of the items on the right panel
# Only supports one category, and one kind of objects
# No polymorphic stuff

module Inputs
  module EffectivePanelSelect
    class Input < Effective::FormInput
      delegate :grouped_collection_select, :hidden_field_tag, :text_field_tag, :to => :@template

      def default_options
        { label_method: :to_s, value_method: :to_s, group_label_method: :first, group_method: :last, option_value_method: :first, option_key_method: :second }
      end

      def default_input_js
        { }
      end

      def default_input_html
        { class: 'effective_panel_select', placeholder: 'Please choose' }
      end

      def to_html
        text_field_tag(field_name, value_label, tag_options) + hidden_field_tag(field_name, value_key)
        #grouped_collection_select(@object_name, @method, collection, options[:group_method], options[:group_label_method], options[:option_key_method], options[:option_value_method], options, tag_options)
      end

      # 163
      def value_key
        value
      end

      # Exercise Name
      def value_label
        return @value_label if @value_label

        collection.each do |_, items|
          items.each do |item|
            if item.send(options[:option_key_method]) == value
              @value_label = item.send(options[:option_value_method])
              return @value_label
            end
          end
        end

      end

      # This is a grouped polymorphic collection
      # [["Clinics", [["Clinc 50", "Clinic_50"], ["Clinic 43", "Clinic_43"]]], ["Contacts", [["Contact 544", "Contact_544"]]]]
      def collection
        @collection ||= begin
          collection = options.delete(:collection) || []
          grouped = collection[0].kind_of?(Array) && collection[0][0].kind_of?(String) && collection[0][1].respond_to?(:to_a) && (collection[0][1] != nil) # Array or ActiveRecord_Relation

          if !grouped && collection.present?
            raise "Grouped collection expecting a Hash {'Posts' => Post.all, 'Events' => Event.all} or a Hash {'Posts' => [['Post A', 1], ['Post B', 2]], 'Events' => [['Event A', 1], ['Event B', 2]]}"
          end

          collection.each_with_index do |(name, group), index|
            collection[index][1] = group.respond_to?(:call) ? group.call : group.to_a
          end

          collection.respond_to?(:call) ? collection.call : collection.to_a
        end
      end

    end
  end
end
