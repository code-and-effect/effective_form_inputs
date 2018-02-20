module EffectiveBootstrap3Helper

  # An effective Bootstrap3 menu DSL
  # Automatically puts in the 'active' class based on request path

  # %ul.nav.navbar-nav.navbar-right
  #   = nav_link_to 'Sign In', new_user_session_path
  #   = nav_dropdown 'Settings' do
  #     = nav_link_to 'Account Settings', user_settings_path
  #     %li.divider
  #     = nav_link_to 'Sign In', new_user_session_path, method: :delete
  def nav_link_to(label, path, opts = {})
    content_tag(:li, class: ('active' if request.fullpath.include?(path))) do
      link_to(label, path, opts)
    end
  end

  def nav_dropdown(label, link_class: [], list_class: [], &block)
    raise 'expected a block' unless block_given?

    content_tag(:li, class: 'dropdown') do
      content_tag(:a, class: 'dropdown-toggle', href: '#', 'data-toggle': 'dropdown', role: 'button', 'aria-haspopup': 'true', 'aria-expanded': 'false') do
        label.html_safe + content_tag(:span, '', class: 'caret')
      end + content_tag(:ul, class: 'dropdown-menu') { yield }
    end
  end

  # An effective Bootstrap3 tabpanel DSL
  # Inserts both the tablist and the tabpanel

  # = tabs do
  #   = tab 'Imports' do
  #     %p Imports

  #   = tab 'Exports' do
  #     %p Exports

  # If you pass active 'label' it will make that tab active. Otherwise first.
  def tabs(active: nil, panel: {}, list: {}, content: {}, &block)
    raise 'expected a block' unless block_given?

    @_tab_mode = :panel
    @_tab_active = (active || :first)

    content_tag(:div, {role: 'tabpanel'}.merge(panel)) do
      content_tag(:ul, {class: 'nav nav-tabs', role: 'tablist'}.merge(list)) { yield } # Yield to tab the first time
    end + content_tag(:div, {class: 'tab-content'}.merge(content)) do
      @_tab_mode = :content
      @_tab_active = (active || :first)
      yield # Yield tot ab the second time
    end
  end

  def tab(label, controls = nil, &block)
    controls ||= label.to_s.parameterize.gsub('_', '-')
    controls = controls[1..-1] if controls[0] == '#'

    active = (@_tab_active == :first || @_tab_active == label)

    @_tab_active = nil if @_tab_active == :first

    if @_tab_mode == :panel # Inserting the label into the tabpanel top
      content_tag(:li, role: 'presentation', class: ('active' if active)) do
        content_tag(:a, href: '#' + controls, 'aria-controls': controls, 'data-toggle': 'tab', role: 'tab') do
          label
        end
      end
    else # Inserting the content into the tab itself
      content_tag(:div, id: controls, class: "tab-pane#{' active' if active}", role: 'tabpanel') do
        yield
      end
    end
  end

  ### Icon Helpers for actions_column or elsewhere
  def show_icon_to(path, options = {})
    glyphicon_to('eye-open', path, {title: 'Show'}.merge(options))
  end

  def edit_icon_to(path, options = {})
    glyphicon_to('edit', path, {title: 'Edit'}.merge(options))
  end

  def destroy_icon_to(path, options = {})
    defaults = {title: 'Destroy', data: {method: :delete, confirm: 'Delete this item?'}}
    glyphicon_to('trash', path, defaults.merge(options))
  end

  def settings_icon_to(path, options = {})
    glyphicon_to('cog', path, {title: 'Settings'}.merge(options))
  end

  def ok_icon_to(path, options = {})
    glyphicon_to('ok', path, {title: 'OK'}.merge(options))
  end

  def approve_icon_to(path, options = {})
    glyphicon_to('ok', path, {title: 'Approve'}.merge(options))
  end

  def remove_icon_to(path, options = {})
    glyphicon_to('remove', path, {title: 'Remove'}.merge(options))
  end

  def glyphicon_tag(icon, options = {})
    if icon.to_s.start_with?('glyphicon-')
      content_tag(:span, '', {class: "glyphicon #{icon}"}.merge(options))
    else
      content_tag(:span, '', {class: "glyphicon glyphicon-#{icon}"}.merge(options))
    end
  end

  def glyphicon_to(icon, path, options = {})
    content_tag(:a, options.merge(href: path)) do
      glyphicon_tag(icon)
    end
  end
  alias_method :bootstrap_icon_to, :glyphicon_to
  alias_method :glyph_icon_to, :glyphicon_to

end
