initialize = ->
  $inputs = $('textarea.effective_ckeditor_text_area:not(.initialized)')
  setupCkeditor($inputs)

  $inputs.each (i, element) ->
    element = $(element)
    element.addClass('initialized')
    initCkeditor(element)

# This is a one-time initialization that is done to check that all the scripts are properly set up
setupCkeditor = ($inputs) ->
  return unless $inputs.length > 0

  input_js_options = $inputs.first().data('input-js-options') || {}

  ckeditor_present = ((try CKEDITOR.version) || '').length > 0
  use_effective_assets = input_js_options['effective_assets'] == true
  $head = $('head')

  unless ckeditor_present
    $head.append("<link href='#{input_js_options['effective_ckeditor_css_path']}' type='text/css', media='screen' rel='stylesheet' />")
    jQuery.ajax({url: input_js_options['effective_ckeditor_js_path'], dataType: 'script', cache: true, async: false})

  if use_effective_assets
    $head.append("
      <script>
        try {
          CKEDITOR.config['effective_regions'] = {
            'snippets': {
              'effective_asset': {
                'dialog_url':'/assets/effective/snippets/effective_asset.js',
                'label':'Effective asset',
                'description':'Insert Effective asset',
                'inline':true,
                'editables':false,
                'tag':'span'
              }
            }
          };
        } catch(e) {};
      </script>
    ");

initCkeditor = (textarea) ->
  options =
    toolbar: 'full'
    effectiveRegionType: 'full'
    customConfig: ''
    enterMode: CKEDITOR.ENTER_P
    shiftEnterMode: CKEDITOR.ENTER_BR
    startupOutlineBlocks: true
    startupShowBorders: true
    disableNativeTableHandles: true
    disableNativeSpellChecker: false
    extraPlugins: 'effective_regions,effective_assets'
    removePlugins: 'elementspath'
    format_tags: 'p;h1;h2;h3;h4;h5;h6;pre;div'
    templates: 'effective_regions'
    templates_files: []
    templates_replaceContent: false
    filebrowserWindowHeight: 600
    filebrowserWindowWidth: 800
    filebrowserBrowseUrl: '/effective/assets'
    filebrowserImageBrowseUrl: '/effective/assets?only=images'
    toolbar_full: [
      { name: 'definedstyles', items: ['Format'] },
      { name: 'html', items: ['ShowBlocks'] },
      { name: 'justify', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight']}
      { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline'] },
      { name: 'insert', items: ['Link', 'Table', '-', 'Image', 'oembed', 'EffectiveAssets'] },
      { name: 'lists', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent'] },
    ],
    toolbar_simple: [
      { name: 'definedstyles', items: ['Format'] },
      { name: 'html', items: ['ShowBlocks'] },
      { name: 'justify', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight']}
      { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline'] },
      { name: 'insert', items: ['Link', 'Table'] },
      { name: 'lists', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent'] },
    ]

  options[k] = v for k, v of (textarea.data('input-js-options') || {})

  ckeditor = CKEDITOR.replace(textarea.attr('id'), options)

  ckeditor.on 'insertElement', (event) ->
    element = $(event.data.$)
    if element.is('table')
      element.removeAttr('style').addClass('table')

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
