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
      @panel.on 'click', '.selection', (event) => @toggle()
      @panel.on 'click', '.selection-clear', (event) => @clear()

    expand: ->
      @panel.addClass(@options.expandClass)
      false

    collapse: ->
      @panel.removeClass(@options.expandClass)

    toggle: ->
      if @panel.hasClass(@options.expandClass) then @collapse() else @expand()

    clear: ->
      false

  $.fn.extend effectivePanelSelect: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('effectivePanelSelect')

      $this.data('effectivePanelSelect', (data = new EffectivePanelSelect(this, option))) if !data
      data[option].apply(data, args) if typeof option == 'string'
      $this

) window.jQuery, window

$(document).on 'click', (event) ->
  if !$(event.target).closest('.effective-panel-select').length
    $('.effective-panel-select.initialized').effectivePanelSelect('collapse')
