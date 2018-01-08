# http://digitalbush.com/projects/masked-input-plugin/

initialize = (target) ->
  $(target || document).find('input.effective_url:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    # We don't actually do anything with options
    element.addClass('initialized')

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
$(document).on 'effective-form-inputs:initialize', (event) -> initialize(event.currentTarget)
