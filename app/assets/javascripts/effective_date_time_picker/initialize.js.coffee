# http://eonasdan.github.io/bootstrap-datetimepicker/Options/

initialize = ->
  $('input.effective_date_time_picker:not(.initialized)').each (i, element) ->
    element = $(element)

    options = $.extend
      format: 'YYYY-MM-DD h:mm A'
      sideBySide: true
    , (element.data('input-js-options') || {})

    element.addClass('initialized').datetimepicker(options)

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
