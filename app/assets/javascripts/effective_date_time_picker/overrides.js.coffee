$(document).on 'dp.hide', (event) -> $(event.target).trigger('keyup')

# When an input with field named "start_*" is changed, set it's corresponding "end_*" minDate
$(document).on 'dp.change', (event) ->
  $obj = $(event.target)

  return if $obj.hasClass('not-date-linked')
  return if $obj.attr('name').indexOf('[start_') == -1

  end_date = $obj.attr('name').replace('[start_', '[end_')
  $end_date = $obj.closest('form').find("input[name='#{end_date}'].initialized:not(.not-date-linked)")

  try $end_date.data('DateTimePicker').minDate(event.date)
