# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      placeholder: 'Please choose'
      invade: '.row'
      collapseOnSelect: true
      resetOnCollapse: true
      keepFetched: false    # Keep any fetched ajax pages in the dom. Otherwise they're freed on reset()
      ajax:
        url: ''       # /exercises/:id   The string ':id' will be replaced with the viewed item value
        target: ''    # #container       The string to pass to load

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
      @tabList = @selector.find('ul.nav').first()
      @tabContent = @selector.find('.tab-content').first()

      @options = $.extend({}, @defaults, options)

      @initTabs()
      @initEvents()
      @initInvade()
      @initAjax()
      true

    # So we need to assign unique IDs to all the group tabs so we can have multiple selectors per page
    # This should also handle cocoon gem

    initTabs: ->
      unique = new Date().getTime()

      @tabList.find("a[data-toggle='tab']").each (index, item) =>
        item = $(item)
        href = item.attr('href')
        tab = @tabContent.find(href)

        href = href + '-' + unique + index

        item.attr('href', href)
        tab.attr('id', href.substring(1))

    initEvents: ->
      @panel.on 'click', '.selection', (event) => @toggle()
      @panel.on 'click', '.selection-clear', (event) => @clear() and false
      @panel.on 'click', '[data-item-value]', (event) => @val($(event.currentTarget).data('item-value')) and false
      @panel.on 'click', '[data-fetch-item]', (event) => @fetch($(event.currentTarget).closest('[data-item-value]').data('item-value')) and false
      @panel.on 'click', '.fetched-clear', (event) => @reset() and false
      @panel.on 'click', '.fetched-select', (event) => @setVal($(event.currentTarget).data('item-value')) and false

    initInvade: ->
      return if @options.invade == false || @options.invade == 'false'
      @home = @panel.parent()
      @away = $("<div class='col-xs-12 effective_panel_select'></div>")

    initAjax: ->
      return unless @options.ajax && @options.ajax.url.length
      @fetched = @selector.find('.fetched')

    # Rest of these are commands

    # Expand / Collapse
    # $('.effective-panel-select').effectivePanelSelect('toggle')
    toggle: ->
      if @panel.hasClass('expanded') then @collapse() else @expand()

    expand: ->
      @panel.addClass('expanded')
      @invade() if @options.invade

    collapse: ->
      @panel.removeClass('expanded')
      @reset() if @options.resetOnCollapse
      @retreat() if @options.invade

    # Invade the nearest '.row'
    invade: ->
      target = @home.closest(@options.invade)
      return unless target.length && !@invading

      @panel.detach()
      target.children().hide()
      @away.append(@panel).show()

      target.append(@away)

      @invading = true

    # Reset to default position
    retreat: ->
      target = @away.closest(@options.invade)
      return unless target.length && @invading

      @panel.detach()
      target.children().show()
      @away.hide()

      hint = @home.children(':not(label)')
      if hint.length then @panel.insertBefore(hint) else @home.append(@panel)

      @invading = false

    # Get / Set / Clear selection
    val: (args...) ->
      if args.length == 0 then @input.val() else @setVal(args[0])

    title: (item) ->
      (item || @label).find('a').clone().children().remove().end().text()

    # Sets the input value, and the selected value text
    setVal: (value) ->
      @input.val(value)

      if value == null || value == undefined || value == ''
        @label.html("<span class='selection-placeholder'>#{@options.placeholder}</span>")
        @reset()
      else
        $item = @selector.find("li[data-item-value='#{value}']").first()
        label = @title($item)

        @label.html("<span class='selection-clear'>x</span> <span class='selection-label'>#{label}</span>")
        if @options.collapseOnSelect then @collapse() else @reset()

      @panel.trigger 'change'
      true

    # Syncs the tabs to the current value
    reset: ->
      value = @val()

      @fetched.children(':not(.top)').remove() if @fetched && @fetched.length && !@options.keepFetched

      @selector.find("li.selected").removeClass('selected')
      @selector.find('.active').removeClass('active')

      if (value == null || value == undefined || value == '') == false
        $item = @selector.find("li[data-item-value='#{value}']")
        $item.addClass('selected').addClass('active')

        $tab_pane = $item.closest('.tab-pane')

        if $tab_pane.length
          $tab = @selector.find("a[href='##{$tab_pane.attr('id')}']").parent('li')
          $tab.addClass('selected').addClass('active')
          $tab_pane.addClass('active')

    clear: -> @val(null)

    # Ajax fetch and view page
    fetch: (value) ->
      return unless @options.ajax && @options.ajax.url.length

      fetched = @fetched.children("div[data-fetch='#{value}']")

      if fetched.length == 0
        fetched = $("<div data-fetch='#{value}'></div>")

        fetched = fetched.load(@url(value), (response, status, xhr) =>
          fetched.append('<p>This item is unavailable (ajax error)</p>') if status == 'error'
        )

        @fetched.append(fetched)

      @fetched.parent().find('.active').removeClass('active')
      @fetched.addClass('active').children(':not(.top)').hide()
      fetched.show()
      @fetched.children('.top').find('.fetched-select').data('item-value', value)

    url: (value) ->
      return unless @options.ajax && @options.ajax.url.length

      url = @options.ajax.url.replace(':id', value)

      # Add a data param
      url = url + (if url.indexOf('?') == -1 then '?' else '&') + $.param(effective_panel_select: true)

      # Add target
      url = url + " #{@options.ajax.target}" if @options.ajax.target  # jQuery .load('/things/13 #thing')

      url

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
