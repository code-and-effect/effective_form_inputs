# Disable dropdown opening when clicking the clear button
# http://stackoverflow.com/questions/29618382/disable-dropdown-opening-on-select2-clear

$(document).on 'select2:unselecting', (event) -> $(event.target).data('state', 'unselected')

$(document).on 'select2:open', (event) ->
  $select = $(event.target)

  if $select.data('state') == 'unselected'
    $select.removeData('state')
    setTimeout ( => $select.select2('close') ), 0


# effective_select custom reinitialization functionality
# This is a custom event intended to be manually triggered when the underlying options change
# You can use this to dynamically disable options (with or without the effective_select hide_disabled: true)
# https://github.com/select2/select2/issues/2830

# To trigger this event,
# $(document).on 'change', "select[name$='[something_id]']", (event) ->
#   ...add/remove/disable this select field's options...
#   $(event.target).select2().trigger('select2:reinitialize')

$(document).on 'select2:reinitialize', (event) ->
  $select = $(event.target)

  # Get the existing options and value
  options = $select.data('select2').options.options['inputJsOptions'] || {}
  value = $select.find('option:selected').val()

  # Clear/Restore the value appropriately
  if value && $select.find("option:enabled[value='#{value}']").length > 0
    $select.val(value)
  else
    $select.val('')

  # Reinitialize select2
  $select.select2('destroy').select2(options)

  # Restore effective_select custom class functionality
  $select.data('select2').$container.addClass(options['containerClass']) if options['containerClass']
  $select.data('select2').$dropdown.addClass(options['dropdownClass']) if options['dropdownClass']


