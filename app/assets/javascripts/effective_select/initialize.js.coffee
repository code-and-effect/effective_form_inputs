# https://select2.github.io/examples.html

initialize = ->
  $('select.effective_select:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    $select = element.addClass('initialized').select2(options)

    # effective_select custom class functionality
    # select2 doesn't provide an initializer to add css classes to its input, so we manually support this feature
    # js_options[:containerClass] and js_options[:dropdownClass]
    $select.data('select2').$container.addClass(options['containerClass']) if options['containerClass']
    $select.data('select2').$dropdown.addClass(options['dropdownClass']) if options['dropdownClass']

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()

# If we're working with a polymorphic select, split out the ID and assign the hidden _type and _id fields
$(document).on 'change', "select.effective_select.polymorphic", (event) ->
  $select = $(event.target)
  value = $select.val() || ''

  $select.siblings("input[type='hidden'][name$='_type]']").val(value.split('_')[0] || '')
  $select.siblings("input[type='hidden'][name$='_id]']").val(value.split('_')[1] || '')
