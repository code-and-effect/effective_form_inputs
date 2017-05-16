# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      expandClass: 'expanded'
      selectedClass: 'selected'
      placeholder: 'Please choose'

    panel: null     # Our root node. the .panel element
    input: null     # The input[type=hidden] field where we keep the selected value
    selected: null  # Contains either a %span.selection-placeholder, or a %span.selection-clear and %span.selection-label
    selector: null  # Root node of the expanded container

    constructor: (el, options) ->
      @panel = $(el)
      @input = @panel.find("input[type='hidden']")
      @selected = @panel.find('span.selected')
      @selector = @panel.children('.panel-body').children('.selector')

      @options = $.extend({}, @defaults, options)

      @initEvents()
      true

    initEvents: ->
      @panel.on 'click', '.selection', (event) => @toggle()
      @panel.on 'click', '.selection-clear', (event) => @clear() and false
      @panel.on 'click', '[data-item-value]', (event) => @val($(event.currentTarget).data('item-value')) and false

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

      @selector.find("li.#{@options.selectedClass}").removeClass(@options.selectedClass)

      if value == null || value == undefined || value == ''
        @selected.html("<span class='selection-placeholder'>#{@options.placeholder}</span>")
        @selector.find('.active').removeClass('active')
      else
        $item = @selector.find("li[data-item-value='#{value}']")
        $item.addClass(@options.selectedClass)

        label = $item.find('a').html()

        # Make sure the tabs are correct
        $tab_pane = $item.closest('.tab-pane')

        if $tab_pane.length
          $tab = @selector.find("a[href='##{$tab_pane.attr('id')}']")

          unless ($tab.length && $tab.hasClass('active'))
            @selector.find('.active').removeClass('active')
            $tab.addClass('active')
            $tab_pane.addClass('active')

        @selected.html("<span class='selection-clear'>x</span> <span class='selection-label'>#{label}</span>")

      @panel.trigger 'change'
      true

    clear: -> @val(null)

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
