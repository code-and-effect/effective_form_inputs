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

  ckeditor_present = ((try CKEDITOR.version) || '').length > 0
  use_effective_assets = ($inputs.first().data('input-js-options') || {})['effective_assets'] == true
  $head = $('head')

  unless ckeditor_present
    $head.append("<script src='/assets/effective_ckeditor.js' />")
    $head.append("<link href='/assets/effective_ckeditor.css' type='text/css', media='screen' rel='stylesheet' />")

  if use_effective_assets
    $head.append("
      <script>
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
      </script>
    ");

initCkeditor = (textarea) ->
  CKEDITOR.replace(textarea.attr('id'),
    toolbar: 'full'
    effectiveRegionType: 'full'
    customConfig: ''
    enterMode: CKEDITOR.ENTER_P
    shiftEnterMode: CKEDITOR.ENTER_BR
    startupOutlineBlocks: false
    startupShowBorders: true
    disableNativeTableHandles: true
    extraPlugins: 'effective_regions,effective_assets'
    removePlugins: 'elementspath'
    format_tags: 'p;h1;h2;h3;h4;h5;h6;pre;div'
    templates: 'effective_regions'
    templates_files: []
    templates_replaceContent: false
    filebrowserWindowHeight: 600
    filebrowserWindowWidth: 800
    filebrowserBrowseUrl: '/effective/assets?only=images'
    toolbar_full: [
      { name: 'definedstyles', items: ['Format'] },
      { name: 'html', items: ['ShowBlocks'] },
      { name: 'justify', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight']}
      { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline'] },
      { name: 'insert', items: ['Link', 'Table', '-', 'Image', 'oembed', 'EffectiveAssets'] },
      { name: 'lists', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent'] },
    ]
  )

$ -> initialize()
$(document).on 'page:change', -> initialize()
$(document).on 'cocoon:after-insert', -> initialize()
