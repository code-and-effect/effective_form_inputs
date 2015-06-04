module Effective
  class FormInput

    def initialize(object, object_name, template, method, opts, html_opts = {})
      @object = object
      @object_name = object_name
      @template = template
      @method = method

      # Initialize 3 options Hashes:  @opts, @html_opts, and @js_opts
      @js_opts = opts.delete(:input_js).presence || {}
      @html_opts = html_opts.presence || opts.delete(:input_html) || {}
      @opts = opts.presence || {}

      # Copy the following keys from options to html_options
      # To deal with SimpleForm being simple
      [:class, :readonly, :pattern, :disabled, :maxlength].each do |key|
        if !html_opts.key?(key) && @opts.key?(key)
          @html_opts[key] = @opts[:key] if @opts[:key]
        end
      end

      # Reverse merge in the defaults, so the current values take precedence over defaults
      @js_opts.reverse_merge!((default_input_js || {}))
      @html_opts.reverse_merge!((default_input_html || {}).except(:class))
      @opts.reverse_merge!((default_options || {}))

      # Take special procedure to ensure that @html_opts[:class] is an Array, and the proper merged values
      @html_opts[:class] = (arrayize_html_class_key(@html_opts[:class]) + arrayize_html_class_key(default_input_html)).compact.uniq

      # Set the value to avoid options craziness
      @value = (@opts.delete(:value) || @html_opts.delete(:value) || (@object.send(@method) if @object.respond_to?(@method)))
    end

    def field_name
      "#{@object_name}[#{@method}]"
    end

    def value
      @value
    end

    # Override these methods to change any options around
    # tag_options reads html_options and js_options
    def options; @opts end              # All options passed to the FormInput, merged with defaults
    def html_options; @html_opts end    # All :input_html => options, merged with defaults.  Could be everything (same as options) if coming from FormBuilder.
    def js_options; @js_opts end        # All :input_js => options, merged with defaults

    protected

    # Hook methods for an inheritting class to apply defaults
    def default_options; {} end         # All options passed to FormInput
    def default_input_html; {} end    # To merge with any :input_html => options
    def default_input_js; {} end      # to merge with any :input_js => options

    # This is what we want to send to a content_tag, text_area_tag, or whatever actual input we use
    # It serializes any js_options into JSON format
    # And turns html_options[:class] back into a string
    def tag_options
      html_options().tap do |html_options|
        html_options['data-input-js-options'] = (JSON.generate(js_options) rescue {})
        html_options[:class] = html_options[:class].join(' ')
      end
    end

    private

    # I'm passed something...I don't know what it is, but it needs to be an Array
    def arrayize_html_class_key(something)
      case something
      when Hash
        arrayize_html_class_key(something[:class])
      when Array
        something.compact.map(&:to_s)
      when String
        something.split(' ')
      when Symbol
        [something.to_s]
      else
        []
      end
    end

  end
end
