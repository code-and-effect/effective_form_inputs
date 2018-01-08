# http://digitalbush.com/projects/masked-input-plugin/

initialize = (target) ->
  $(target || document).find('input.effective_tel:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    mask = options['mask']
    delete options['mask']

    element.addClass('initialized').mask(mask, options)

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
$(document).on 'effective-form-inputs:initialize', (event) -> initialize(event.currentTarget)
