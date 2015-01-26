module Effective
  class FormField

    def initialize(object, object_name, template, method, opts)
      @object = object
      @object_name = object_name
      @template = template
      @method = method
      @opts = opts
    end

    def field_name
      @object_name + "[#{@method}]"
    end

    def value
      @object.send(@method)
    end

    def default_input_js_options; {} end
    def default_input_classes; [] end

    def options(&block)
      @form_field_options ||= (
        (@opts || {}).tap do |options|
          options['data-input-js-options'] = {} unless options['data-input-js-options'].kind_of?(Hash)

          yield(options) if block_given?

          merge_class_options!(options)
          merge_input_js_options!(options)
        end
      )
    end

    private

    def merge_class_options!(options)
      (default_input_classes || []).each do |c|
        if options[:class].blank?
          options[:class] = c.to_s
        elsif options[:class].kind_of?(Array)
          options[:class] << c unless options[:class].include?(c)
        elsif options[:class].kind_of?(String)
          options[:class] << (' ' + c.to_s) unless options[:class].include?(c.to_s)
        end
      end
    end

    def merge_input_js_options!(options)
      options['data-input-js-options'] = JSON.generate((default_input_js_options || {}).merge(options['data-input-js-options'] || {})) rescue {}
    end

  end
end
