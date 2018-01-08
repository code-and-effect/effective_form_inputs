# http://eonasdan.github.io/bootstrap-datetimepicker/Options/

initialize = (target) ->
  $(target || document).find('input.effective_date_time_picker:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    element.addClass('initialized').datetimepicker(options)
    element.trigger('dp.end_date_initialized') if (element.attr('name') || '').indexOf('[end_') != -1

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
$(document).on 'effective-form-inputs:initialize', (event) -> initialize(event.currentTarget)

$(document).on 'turbolinks:before-cache', ->
  $('input.effective_date_time_picker.initialized').each (i, element) ->
    $input = $(element)
    $input.datetimepicker('destroy') if $input.data('datetimepicker')
