module EffectiveFormInputsHelper
  def price_to_currency(price)
    price = price || 0
    raise 'price_to_currency expects an Integer representing the number of cents' unless price.kind_of?(Integer)
    number_to_currency(price / 100.0)
  end

  def simple_form_save(form, label = 'Save', options = {}, &block)
    wrapper_options = { class: 'form-actions' }.merge(options.delete(:wrapper_html) || {})
    options = { class: 'btn btn-primary', data: { disable_with: 'Saving...'} }.merge(options)

    content_tag(:div, wrapper_options) do
      form.button(:submit, label, options) + (capture(&block) if block_given?)
    end
  end

end
