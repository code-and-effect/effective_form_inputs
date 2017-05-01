# http://digitalbush.com/projects/masked-input-plugin/

initialize = ->
  $('input.effective_url:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    # We don't actually do anything with options
    element.addClass('initialized')

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
