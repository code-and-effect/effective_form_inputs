# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      placeholder: 'Please choose'
      invade: '.row'
      collapseOnSelect: false
      ajax:
        url: ''

    panel: null       # Our root node. the .panel element
    input: null       # The input[type=hidden] field where we keep the selected value
    label: null       # Contains either a %span.selection-placeholder, or a %span.selection-clear and %span.selection-label
    selector: null    # Root node of the container
    invading: false   # If we're currently invading the closest @options.invade selector

    constructor: (el, options) ->
      @panel = $(el)
      @input = @panel.find("input[type='hidden']")
      @label = @panel.find('span.selected')
      @selector = @panel.children('.selector')

      @options = $.extend({}, @defaults, options)

      @initEvents()
      @initInvade()
      @initAjax()
      true

    initEvents: ->
      @panel.on 'click', '.selection', (event) => @toggle()
      @panel.on 'click', '.selection-clear', (event) => @clear() and false
      @panel.on 'click', '[data-item-value]', (event) => @val($(event.currentTarget).data('item-value')) and false
      @panel.on 'click', '[data-fetch-item]', (event) => @fetch($(event.currentTarget).closest('[data-item-value]').data('item-value')) and false
      @panel.on 'click', '.fetched-clear', (event) => @setVal(@val(), true) and false
      @panel.on 'click', '.fetched-select', (event) => @setVal($(event.currentTarget).data('item-value')) and false

    initInvade: ->
      return if @options.invade == false || @options.invade == 'false'
      @home = @panel.parent()
      @away = $("<div class='col-xs-12 effective_panel_select'></div>")

    initAjax: ->
      return unless @options.ajax && @options.ajax.url
      @fetched = @selector.find('.fetched')

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

    setVal: (value, skipCollapse) ->
      @input.val(value)

      @selector.find("li.selected").removeClass('selected')
      @selector.find('.active').removeClass('active')

      if value == null || value == undefined || value == ''
        @label.html("<span class='selection-placeholder'>#{@options.placeholder}</span>")
      else
        $item = @selector.find("li[data-item-value='#{value}']")
        $item.addClass('selected').addClass('active')

        label = $item.find('a').clone().children().remove().end().text()

        # Make sure the tabs are correct
        $tab_pane = $item.closest('.tab-pane')

        if $tab_pane.length
          $tab = @selector.find("a[href='##{$tab_pane.attr('id')}']").parent('li')
          $tab.addClass('selected').addClass('active')
          $tab_pane.addClass('active')

        @label.html("<span class='selection-clear'>x</span> <span class='selection-label'>#{label}</span>")
        @collapse() if @options.collapseOnSelect && !skipCollapse

      @panel.trigger 'change'
      true

    clear: -> @val(null)

    # Ajax Stuff
    fetch: (value) ->
      return unless @options.ajax && @options.ajax.url
      url = @options.ajax.url.replace(':id', value)

      fetched = @fetched.children("div[data-fetch='#{url}']")

      if fetched.length == 0
        fetched = $("<div data-fetch='#{url}'></div>")

        fetched = fetched.load(url, (response, status, xhr) =>
          fetched.append('<p>This item is unavailable (ajax error)</p>') if status == 'error'
        )

        @fetched.append(fetched)

      @fetched.parent().find('.active').removeClass('active')
      @fetched.addClass('active').children(':not(.top)').hide()
      fetched.show()
      @fetched.children('.top').find('.fetched-select').data('item-value', value)

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
