initialize = ->
  $('input.effective_price:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    # We don't actually do anything
    element.addClass('initialized')

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()


# Prevent non-currency buttons from being pressed
$(document).on 'keydown', "input[type='text'].effective_price", (event) ->
  allowed = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-', ',', '.']

  if event.key && event.key.length == 1 && event.metaKey == false && allowed.indexOf(event.key) == -1
    event.preventDefault()

# Assign the hidden input a value of 100x value
$(document).on 'change keyup', "input[type='text'].effective_price", (event) ->
  value = parseFloat($(event.target).val().replace(/,/g, '') || 0.00) * 100.00
  $(event.target).siblings("input[type='hidden']").first().val(value.toFixed(0))

# Format the value for display as currency (USD)
$(document).on 'change', "input[type='text'].effective_price", (event) ->
  value = parseFloat($(event.target).val().replace(/,/g, ''))

  if isNaN(value) == false
    value = value.toFixed(2).toString()
    value = value.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2') while (/(\d+)(\d{3})/.test(value))
  else
    value = ''

  $(event.target).val(value)
