# This is a unique form input
# Takes in the same collection as a grouped select
# Displays the groups on the left, and each of the items on the right panel
# Only supports one category, and one kind of objects
# No polymorphic stuff

module Inputs
  module EffectivePanelSelect
    class Input < Effective::FormInput
      delegate :grouped_collection_select, :hidden_field_tag, :text_field_tag, :render, to: :@template

      def default_options
        { label_method: :to_s, value_method: :to_s, group_label_method: :first, group_method: :second, option_value_method: :first, option_key_method: :second, sidebar_class: 'nav-stacked' }
      end

      def default_input_js
        { placeholder: 'Please choose', invade: '.row', collapseOnSelect: true, resetOnCollapse: true, showCount: false }
      end

      def default_input_html
        { class: 'effective_panel_select' }
      end

      def to_html
        render('effective/effective_panel_select/input', input: self)
      end

      def method_name
        @method_name ||= @method.to_s.titleize.downcase
      end

      def ajax?
        return true if js_options[:ajax]
      end

      def show_count?
        return true if js_options[:showCount]
      end

      # option_value           1
      # option_label           Post A
      # group_label            Active

      # 163
      def option_value
        value
      end

      # Post A
      def option_label
        return nil unless value.present?
        @option_label || (_initialize_group_and_option; @option_label)
      end

      # Active
      def group_label
        return nil unless value.present?
        @group_label || (_initialize_group_and_option; @group_label)
      end

      # Active
      def group_value
        return nil unless value.present?
        @group_value || (_initialize_group_and_option; @group_value)
      end

      def _initialize_group_and_option
        collection.each do |group, items|
          items.each do |item|
            if item.send(options[:option_key_method]) == value
              @group_label = group.send(options[:group_label_method])
              @group_value = group.send(options[:group_method])
              @option_label = item.send(options[:option_value_method])
              return
            end
          end
        end

      end

      # This is a grouped polymorphic collection
      # [['Active', [['Post A', 1], ['Post B', 2]]], ['Past', [['Post C', 3], ['Post D', 4]]]
      def collection
        @collection ||= begin
          collection = options.delete(:collection) || []
          grouped = collection[0].kind_of?(Array) && collection[0][1].respond_to?(:to_a) && (collection[0][1] != nil) # Array or ActiveRecord_Relation

          if !grouped && collection.present?
            raise "Grouped collection expecting a Hash {'Posts' => Post.all, 'Events' => Event.all} or a Hash {'Posts' => [['Post A', 1], ['Post B', 2]], 'Events' => [['Event A', 1], ['Event B', 2]]}"
          end

          collection.each_with_index do |(name, group), index|
            collection[index][1] = group.respond_to?(:call) ? group.call : group.to_a
          end

          if collection[0][0].kind_of?(String)
            options[:group_label_method] = :to_s
            options[:group_method] = :to_s
          end

          collection.respond_to?(:call) ? collection.call : collection.to_a
        end
      end
    end
  end
end
