# https://select2.github.io/examples.html

initialize = ->
  $('select.effective_select:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    element.addClass('initialized').select2(options)

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()

# If we're working with a polymorphic select, split out the ID and assign the hidden _type and _id fields
$(document).on 'change', "select.effective_select.polymorphic", (event) ->
  $select = $(event.target)
  value = $select.val() || ''

  $select.siblings("input[type='hidden'][name$='_type]']").val(value.split('_')[0] || '')
  $select.siblings("input[type='hidden'][name$='_id]']").val(value.split('_')[1] || '')
