initialize = ->
  $('select.effective_panel_select:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    $select = element.addClass('initialized')

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'turbolinks:render', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()


$(document).on 'click', 'a[data-effective-panel-select-id]', (event) ->
  event.preventDefault()
  event.stopPropagation()

  $obj = $(event.currentTarget)
  val = $obj.data('effective-panel-select-id')

  console.log "Clicked #{val}"

  false
