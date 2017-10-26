$(document).on 'dp.hide', (event) -> $(event.target).trigger('keyup')

# When an input with field named "start_*" is changed, set it's corresponding "end_*" minDate
$(document).on 'dp.change', (event) ->
  $start_date = $(event.target)

  return if $start_date.hasClass('not-date-linked')
  return if ($start_date.attr('name') || '').indexOf('[start_') == -1

  end_date = $start_date.attr('name').replace('[start_', '[end_')
  $end_date = $start_date.closest('form').find("input[name='#{end_date}'].initialized")

  return if $end_date.length == 0
  return if $end_date.hasClass('not-date-linked')

  try $end_date.data('DateTimePicker').minDate(event.date)

# When an input with field named "end_*" is initialized, set it's corresponding "start_*" minDate
$(document).on 'dp.end_date_initialized', (event) ->
  $end_date = $(event.target)

  return if $end_date.hasClass('not-date-linked')
  return if ($end_date.attr('name') || '').indexOf('[end_') == -1

  start_date = $end_date.attr('name').replace('[end_', '[start_')
  $start_date = $end_date.closest('form').find("input[name='#{start_date}'].initialized")

  return if $start_date.length == 0
  return if $start_date.hasClass('not-date-linked')

  try
    date = $start_date.data('DateTimePicker').date()
    $end_date.data('DateTimePicker').minDate(date) if date
