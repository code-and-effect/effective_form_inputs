# https://select2.github.io/examples.html

initialize = ->
  $('select.effective_select:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    element.addClass('initialized').select2(options)

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
