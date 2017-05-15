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

# Expand / Collapse
$(document).on 'click', '[data-effective-panel-select-toggle]', (event) ->
  $panel = $(event.currentTarget).closest('.panel')

  if $panel.hasClass('expanded')
    $panel.removeClass('expanded')
  else
    $panel.addClass('expanded').find('.selector').find('.nav').find('a').first().focus()

  false

# $(document).on 'focusout', '.effective_panel_select', (event) ->
#   console.log 'focusout'
#   $(event.currentTarget).find('.panel').removeClass('expanded')
#   false


# $(document).on 'click', 'a[data-effective-panel-select-id]', (event) ->
#   event.preventDefault()
#   event.stopPropagation()

#   $obj = $(event.currentTarget)
#   val = $obj.data('effective-panel-select-id')

#   console.log "Clicked #{val}"

#   false


# $(document).on 'click', '[data-effective-panel-select-clear]', (event) ->
#   console.log "CLEAR"
#   false
