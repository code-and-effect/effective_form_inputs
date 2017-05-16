# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      placeholder: 'Please choose'
      invade: '.row'
      collapseOnSelect: true

    panel: null       # Our root node. the .panel element
    input: null       # The input[type=hidden] field where we keep the selected value
    selected: null    # Contains either a %span.selection-placeholder, or a %span.selection-clear and %span.selection-label
    selector: null    # Root node of the container
    invading: false   # If we're currently invading the closest @options.invade selector

    constructor: (el, options) ->
      @panel = $(el)
      @input = @panel.find("input[type='hidden']")
      @selected = @panel.find('span.selected')
      @selector = @panel.children('.panel-body').children('.selector')

      @options = $.extend({}, @defaults, options)

      @initEvents()
      @initInvade()
      true

    initEvents: ->
      @panel.on 'click', '.selection', (event) => @toggle()
      @panel.on 'click', '.selection-clear', (event) => @clear() and false
      @panel.on 'click', '[data-item-value]', (event) => @val($(event.currentTarget).data('item-value')) and false

    initInvade: ->
      return if @options.invade == false || @options.invade == 'false'
      @home = @panel.parent()
      @away = $("<div class='col-xs-12 effective_panel_select'></div>")

    # Rest of these are commands

    # Expand / Collapse
    toggle: ->
      if @panel.hasClass('expanded') then @collapse() else @expand()

    expand: ->
      @panel.addClass('expanded')
      @invade() if @options.invade

    collapse: ->
      @panel.removeClass('expanded')
      @retreat() if @options.invade

    invade: ->
      target = @home.closest(@options.invade)
      return unless target.length && !@invading

      @panel.detach()
      target.children().hide()
      @away.append(@panel).show()
      target.append(@away)

      @invading = true

    retreat: ->
      target = @away.closest(@options.invade)
      return unless target.length && @invading

      @panel.detach()
      target.children().show()
      @away.hide()

      hint = @home.children('p')
      if hint.length then @panel.insertBefore(hint) else @home.append(@panel)

      @invading = false

    # Get / Set / Clear selection
    val: (args...) ->
      if args.length == 0 then @input.val() else @setVal(args[0])

    setVal: (value) ->
      @input.val(value)

      @selector.find("li.selected").removeClass('selected')
      @selector.find('.active').removeClass('active')

      if value == null || value == undefined || value == ''
        @selected.html("<span class='selection-placeholder'>#{@options.placeholder}</span>")
      else
        $item = @selector.find("li[data-item-value='#{value}']")
        $item.addClass('selected')

        label = $item.find('a').html()

        # Make sure the tabs are correct
        $tab_pane = $item.closest('.tab-pane')

        if $tab_pane.length
          $tab = @selector.find("a[href='##{$tab_pane.attr('id')}']").parent('li')
          $tab.addClass('selected').addClass('active')
          $tab_pane.addClass('active')

        @selected.html("<span class='selection-clear'>x</span> <span class='selection-label'>#{label}</span>")
        @collapse() if @options.collapseOnSelect

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
