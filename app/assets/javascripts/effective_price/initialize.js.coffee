initialize = ->
  $('input.effective_price:not(.initialized)').each (i, element) ->
    element = $(element)
    options = element.data('input-js-options') || {}

    # We don't actually do anything
    element.addClass('initialized')

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'turbolinks:load', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()


# Prevent non-currency buttons from being pressed
$(document).on 'keydown', "input[type='text'].effective_price", (event) ->
  allowed = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-', ',', '.']

  if event.key && event.key.length == 1 && event.metaKey == false && allowed.indexOf(event.key) == -1
    event.preventDefault()

# Assign the hidden input a value of 100x value
$(document).on 'change keyup', "input[type='text'].effective_price", (event) ->
  $input = $(event.target)
  value = $input.val().replace(/,/g, '')

  unless $input.data('include-blank') && value == ''
    value = (parseFloat(value || 0.00) * 100.00).toFixed(0)

  $input.siblings("input[type='hidden']").first().val(value)

# Format the value for display as currency (USD)
$(document).on 'change', "input[type='text'].effective_price", (event) ->
  $input = $(event.target)
  value = $input.siblings("input[type='hidden']").first().val()

  unless $input.data('include-blank') && value == ''
    value = parseInt(value || 0)

  if isNaN(value) == false && value != ''
    value = (value / 100.0) if value != 0

    value = value.toFixed(2).toString()
    value = value.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2') while (/(\d+)(\d{3})/.test(value))
  else
    value = ''

  $input.val(value)
