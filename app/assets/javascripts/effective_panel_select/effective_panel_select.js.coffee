# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      expandClass: 'expanded'

    panel: null  # Our root node. the .panel element

    constructor: (el, options) ->
      @panel = $(el)
      @options = $.extend({}, @defaults, options)

      @initEvents()
      true

    initEvents: ->
      @panel.on 'click', '[data-effective-panel-select-toggle]', (event) => @toggle()

    toggle: ->
      if @panel.hasClass(@options.expandClass)
        @panel.removeClass(@options.expandClass)
      else
        @panel.addClass(@options.expandClass)


  $.fn.extend effectivePanelSelect: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('effectivePanelSelect')

      $this.data('effectivePanelSelect', (data = new EffectivePanelSelect(this, option))) if !data
      data[option].apply(data, args) if typeof option == 'string'
      $this

) window.jQuery, window






# $(document).on 'click', '[data-effective-panel-select-toggle]', (event) ->
#   toggle($(event.currentTarget).closest('.panel'))

# # Expand / Collapse
# toggle = ($panel) ->
#   if $panel.hasClass('expanded')
#     $panel.removeClass('expanded')
#   else
#     $panel.addClass('expanded')
#   false

  # else
  #   $panel.addClass('expanded')
  #   $('body').one 'click', (event) ->
  #     console.log 'body click'
  #     console.log event
  #     $('.effective_panel_select').find('.expanded').removeClass('expanded')

# $(document).on 'click', '[data-effective-panel-select-toggle]', (event) -> toggle($(event.currentTarget).closest('.panel'))

# $(document).on 'click', '.effective_panel_select', (event) ->
#   console.log 'clicked panel select'
#   event.preventDefault()
#   event.stopPropagation()
#   event.originalEvent.stopPropagation()
#   false

# # $(document).on 'focusout', '.effective_panel_select', (event) ->
# #   if $(event.relatedTarget).closest('.effective_panel_select').length == 0
# #     toggle($(event.currentTarget).find('.panel'))

# $(document).on 'click', 'a[data-effective-panel-select-id]', (event) ->
#   $obj = $(event.currentTarget)
#   val = $obj.data('effective-panel-select-id')
#   console.log "Clicked #{val}"
#   false

# $(document).on 'click', '[data-effective-panel-select-clear]', (event) ->
#   console.log "CLEAR"
#   false
