initialize = (target) ->
  $(target || document).find('div.effective-panel-select:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    $select = element.addClass('initialized').effectivePanelSelect(options)

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
$(document).on 'effective-form-inputs:initialize', (event) -> initialize(event.currentTarget)
