# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      expandClass: 'expanded'

    panel: null  # Our root node. the .panel element

    constructor: (el, options) ->
      @panel = $(el)
      @input = @panel.find("input[type='hidden']")
      @options = $.extend({}, @defaults, options)

      @initEvents()
      true

    initEvents: ->
      @panel.on 'click', '.selection', (event) => @toggle()
      @panel.on 'click', '.selection-clear', (event) => @clear()

    # Rest of these are commands

    # Expand / Collapse
    toggle: ->
      if @panel.hasClass(@options.expandClass) then @collapse() else @expand()

    expand: ->
      @panel.addClass(@options.expandClass)

    collapse: ->
      @panel.removeClass(@options.expandClass)

    # Get / Set / Clear selection
    val: (args...) ->
      if args.length == 0 then @input.val() else @setVal(args[0])

    setVal: (value) ->
      @input.val(value)
      @panel.trigger 'change'

    clear: ->
      @val(123)

  $.fn.extend effectivePanelSelect: (option, args...) ->
    retval = @each

    @each ->
      $this = $(this)
      data = $this.data('effectivePanelSelect')

      $this.data('effectivePanelSelect', (data = new EffectivePanelSelect(this, option))) if !data

      retval = data[option].apply(data, args) if typeof option == 'string'
      $this

    retval

) window.jQuery, window

$(document).on 'click', (event) ->
  if !$(event.target).closest('.effective-panel-select').length
    $('.effective-panel-select.initialized').effectivePanelSelect('collapse')
