$(document).on 'dp.hide', (event) -> $(event.target).trigger('keyup')

# When an input with field named "start_*" is changed, set it's corresponding "end_*" minDate
$(document).on 'dp.change', (event) ->
  $start_date = $(event.target)

  return if $start_date.hasClass('not-date-linked')

  name = $start_date.attr('name') || ''
  return if name.indexOf('start_') == -1 && name.indexOf('_start') == -1

  end_date = name.replace('start_', 'end_').replace('_start', '_end')
  $end_date = $start_date.closest('form').find("input[name='#{end_date}'].initialized")

  return if $end_date.length == 0
  return if $end_date.hasClass('not-date-linked')

  try $end_date.data('DateTimePicker').minDate(event.date)

  try
    if $end_date.data('DateTimePicker').date() <= event.date
      $end_date.data('DateTimePicker').date(moment(event.date.format()).add(1, 'hour'))

# When an input with field named "end_*" is initialized, set it's corresponding "start_*" minDate
$(document).on 'dp.end_date_initialized', (event) ->
  $end_date = $(event.target)

  return if $end_date.hasClass('not-date-linked')

  name = $end_date.attr('name') || ''
  return if name.indexOf('end_') == -1 && name.indexOf('_start') == -1

  start_date = name.replace('end_', 'start_').replace('_end', '_start')
  $start_date = $end_date.closest('form').find("input[name='#{start_date}'].initialized")

  return if $start_date.length == 0
  return if $start_date.hasClass('not-date-linked')

  try
    date = $start_date.data('DateTimePicker').date()
    $end_date.data('DateTimePicker').minDate(date) if date
