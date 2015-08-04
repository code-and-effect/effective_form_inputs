# Disable dropdown opening when clicking the clear button
# http://stackoverflow.com/questions/29618382/disable-dropdown-opening-on-select2-clear

$(document).on 'select2:unselecting', (event) -> $(event.target).data('state', 'unselected')

$(document).on 'select2:open', (event) ->
  obj = $(event.target)

  if obj.data('state') == 'unselected'
    obj.removeData('state')
    setTimeout ( => obj.select2('close') ), 0
