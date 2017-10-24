# http://eonasdan.github.io/bootstrap-datetimepicker/Options/

initialize = ->
  $('input.effective_time_picker:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    element.addClass('initialized').datetimepicker(options)

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
$(document).on 'turbolinks:before-cache', ->
  $('input.effective_time_picker.initialized').datetimepicker('destroy')

