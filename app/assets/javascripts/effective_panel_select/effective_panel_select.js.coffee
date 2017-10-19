# We initialize this on the .panel

(($, window) ->
  class EffectivePanelSelect
    defaults:
      placeholder: 'Please choose'
      invade: '.row'
      collapseOnSelect: true
      resetOnCollapse: true
      keepFetched: false    # Keep any fetched ajax pages in the dom. Otherwise they're removed on reset()
      showSearch: true
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
      @label = @panel.find('.selection-title')
      @selector = @panel.children('.selector')
      @searchVal = @panel.children('.search').find('.search-value')
      @searchResults = @panel.children('.search').find('.search-results')
      @tabList = @selector.find('ul.nav').first()
      @tabContent = @selector.find('.tab-content').first()

      @options = $.extend({}, @defaults, options)

      @initTabs()
      @initEvents()
      @initInvade()
      @initAjax()
      @reset()
      true

    # So we need to assign unique IDs to all the group tabs so we can have multiple selectors per page
    # This should also handle cocoon gem

    initTabs: ->
      unique = new Date().getTime()

      @tabList.find("a[data-toggle='tab']").each (index, item) =>
        item = $(item)
        href = item.attr('href')
        tab = @tabContent.children(href)

        href = href + '-' + unique + index

        item.attr('href', href)
        tab.attr('id', href.substring(1))

    initEvents: ->
      @panel.on 'click', '.selection', (event) => @toggle() and true
      @panel.on 'click', '.selection-clear', (event) => @clear() and false
      @panel.on 'click', '[data-item-value]', (event) => @val($(event.currentTarget).data('item-value')) and false
      @panel.on 'click', '[data-fetch-item]', (event) => @fetch($(event.currentTarget).closest('[data-item-value]').data('item-value')) and false
      @panel.on 'click', '.fetched-clear', (event) => @reset() and false
      @panel.on 'click', '.fetched-select', (event) => @setVal($(event.currentTarget).data('item-value')) and false
      @panel.on 'keyup', '.search-value', (event) => @search($(event.currentTarget).val()) and true
      @panel.on 'keydown', (event) => @searchVal.focus() and true

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
      @invade() if @options.invade
      @selector.slideDown 'fast', =>
        @panel.addClass('expanded')
        @searchVal.focus()

    collapse: ->
      @selector.slideUp 'fast', =>
        @panel.removeClass('expanded')
        @reset() if @options.resetOnCollapse
        @search('') if @options.resetOnCollapse
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

    title: (item) ->
      (item || @label).find('a').clone().children().remove().end().text()

    # Get / Set / Clear selection
    val: (args...) ->
      if args.length == 0 then @input.val() else @setVal(args[0])

    # Sets the input value, and the selected value text
    setVal: (value) ->
      @input.val(value)

      if value == null || value == undefined || value == ''
        @label.html("<span class='selection-placeholder'>#{@options.placeholder}</span>")
        @reset()
      else
        $item = @tabContent.find("li[data-item-value='#{value}']").first()
        label = @title($item)

        @label.html("<span class='selection-clear'>x</span> <span class='selection-label'>#{label}</span>")
        if @options.collapseOnSelect then @collapse() else @reset()

      @panel.trigger 'change'
      true

    search: (value) ->
      # Set html input value, incase this is called from api
      @searchVal.val(value) unless @searchVal.val() == value

      # Reset existing search
      @selector.find('.excluded').removeClass('excluded')

      value = "#{value}".toLowerCase()
      results = []

      if value == ''
        @searchResults.html('')
        return results

      @tabContent.children(':not(.fetched)').each (_, tabPane) =>
        $tabPane = $(tabPane)
        tabPaneExcluded = true

        $tabPane.find('li').each (_, item) =>
          $item = $(item)

          if $item.text().toLowerCase().indexOf(value) > -1
            results.push($item.data('item-value'))
            tabPaneExcluded = false
          else
            $item.addClass('excluded')

          true

        if tabPaneExcluded
          @tabList.find("a[href='##{$tabPane.attr('id')}']").parent('li').addClass('excluded')

      if results.length > 0 && @options.showSearch
        @searchResults.html("#{results.length} result#{if results.length > 1 then 's' else ''} for '#{value}'")
        @activateTab(results[0]) if @tabList.find('li.active:not(.excluded)').length == 0 # activate first tab if no tab is displayed
      else
        @searchResults.html('')

      results

    activateTab: (value) ->
      $item = @tabContent.find("li[data-item-value='#{value}']").first()
      return false unless $item.length > 0

      @selector.find('.active').removeClass('active')

      $tab_pane = $item.closest('.tab-pane')
      $tab = @tabList.find("a[href='##{$tab_pane.attr('id')}']").parent('li')

      $tab_pane.addClass('active')
      $tab.addClass('active')

    # Syncs the tabs to the current value
    reset: ->
      value = @val()

      @fetched.children(':not(.effective-panel-select-actions)').remove() if @fetched && @fetched.length && !@options.keepFetched

      @selector.find('li.selected').removeClass('selected')
      @selector.find('.active').removeClass('active')

      if (value == null || value == undefined || value == '') == false
        $item = @tabContent.find("li[data-item-value='#{value}']").first()
        $item.addClass('selected').addClass('active')

        $tab_pane = $item.closest('.tab-pane')

        if $tab_pane.length
          $tab = @tabList.find("a[href='##{$tab_pane.attr('id')}']").parent('li')
          $tab.addClass('selected').addClass('active')
          $tab_pane.addClass('active')

    clear: ->
        @val(null)
        @search('')
        @searchVal.focus()
        false

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
      @fetched.addClass('active').children(':not(.effective-panel-select-actions)').hide()
      fetched.show()
      @fetched.children('.effective-panel-select-actions').find('.fetched-select').data('item-value', value)

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
    $('.effective-panel-select.initialized.expanded').effectivePanelSelect('collapse')
