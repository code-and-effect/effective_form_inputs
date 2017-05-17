# Effective Form Inputs

Multiple custom Rails Form Helper and SimpleForm inputs in one Rails engine.

This gem contains numerous custom form inputs along with their Javascript/CSS assets.

Each included form input is available to both the default Rails Form Helper and SimpleForm.

Rails 3.2.x and 4.x

## Getting Started

Add to your Gemfile:

```ruby
gem 'effective_form_inputs'
```

Run the bundle command to install it:

```console
bundle install
```

### Install All Form Inputs

This gem packages the javascript/css assets for numerous form inputs.

The assets for these inputs may be included all at once or individually.

To install all available inputs, add the following to your application.js:

```ruby
//= require effective_form_inputs
```

and add the following to your application.css:

```ruby
*= require effective_form_inputs
```

All of the included form inputs will now be available with no additional installation tasks.

### Options Passing to JavaScript

All `:input_js => options` passed to any effective_form_input will be used to initialize the Javascript library

For example:

```ruby
= form_for @user do |f|
  = f.effective_date_time_picker :updated_at, :input_js => {:format => 'dddd, MMMM Do YYYY', :showTodayButton => true}
```

or

```ruby
= simple_form_for @user do |f|
  = f.input :updated_at, :as => :effective_date_time_picker, :input_js => {:format => 'dddd, MMMM Do YYYY', :showTodayButton => true}
```

will result in the following call to the Javascript library:

```coffee
$('input.effective_date_time_picker').datetimepicker
  format: 'dddd, MMMM Do YYYY',
  showTodayButton: true
```

Any options passed in this way will be used to initialize the underlying javascript libraries.


## Effective Date Time Picker

This custom form input is based on the following awesome project:

Bootstrap 3 Datepicker (https://github.com/Eonasdan/bootstrap-datetimepicker)


### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_date_time_picker/input
```

and add the following to your application.css:

```ruby
*= require effective_date_time_picker/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_date_time_picker :updated_at
```

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :updated_at, :as => :effective_date_time_picker
```

As a SimpleForm input without the input group (calendar glyphicon)

```ruby
= simple_form_for @user do |f|
  = f.input :updated_at, :as => :effective_date_time_picker, :input_group => false
```

### Options

The default `:input_js => options` used to initialize this form input are as follows:

```ruby
:input_js => {:format => 'YYYY-MM-DD h:mm A', :sideBySide => true}
```

For a full list of options, please refer to:

http://eonasdan.github.io/bootstrap-datetimepicker/Options/


## Effective Date Picker

This custom form input is based on the following awesome project:

Bootstrap 3 Datepicker (https://github.com/Eonasdan/bootstrap-datetimepicker)


### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_date_picker/input
```

and add the following to your application.css:

```ruby
*= require effective_date_picker/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_date_picker :started_on
```

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :started_on, :as => :effective_date_picker
```

As a SimpleForm input without the input group (calendar glyphicon)

```ruby
= simple_form_for @user do |f|
  = f.input :updated_at, :as => :effective_date_picker, :input_group => false
```

### Options

The default `:input_js => options` used to initialize this form input are as follows:

```ruby
:input_js => {:format => 'YYYY-MM-DD'}
```

For a full list of options, please refer to:

http://eonasdan.github.io/bootstrap-datetimepicker/Options/

### Set Date

Use the following JavaScript to programatically set the date:

```javascript
$('#start_at').data('DateTimePicker').date('2016-05-08')
```

## Effective Email

This custom form input makes sure the input is an email address.

### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_email/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_email :email
```

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :email, :as => :effective_email
```

As a SimpleForm input without the input group (envelope glyphicon)

```ruby
= simple_form_for @user do |f|
  = f.input :email, :as => :effective_email, :input_group => false
```

You should add a server side validation to enforce the format:

```ruby
validates :email, format: { with: /\A.+@.+\..+\Z/ }
validates :email, effective_email: true   # Enforces same format as above
```

### Options

There are no javascript options for this input.

## Effective Static Control

A bootstrap3 Static control input

Renders `<p class='form-control-static'>value</p>` with the appropriate SimpleForm wrappings.

### Installation

There are no installation steps required for this form input

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_static_control :member_id
```

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :member_id, :as => :effective_static_control
```

### Options

There are no default options for this form input


## Effective Select

This custom form input is based on the following awesome project:

Select2 (https://select2.github.io/)


### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_select/input
```

and add the following to your application.css:

```ruby
*= require effective_select/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_select :category, 10.times.map { |x| "Category #{x}"}
  = f.effective_select :categories, 10.times.map { |x| "Category #{x}"}, :multiple => true
  = f.effective_select :categories, 10.times.map { |x| "Category #{x}"}, :tags => true
```

and as a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :category, :as => :effective_select, :collection => 10.times.map { |x| "Category #{x}"}
  = f.input :categories, :as => :effective_select, :collection => 10.times.map { |x| "Category #{x}"}, :multiple => true
  = f.input :categories, :as => :effective_select, :collection => 10.times.map { |x| "Category #{x}"}, :tags => true
```

### Modes

The standard mode is a replacement for the default single select box.

Passing `:multiple => true` will allow multiple selections to be made.

Passing `:multiple => true, :tags => true` will allow multiple selections to be made, and new value options to be created.  This will allow you to both select existing tags and create new tags in the same form control.

Passing `:grouped => true` will enable optgroup support.  When in this mode, the collection should be a Hash of ActiveRecord Relations or Array of Arrays

```ruby
:collection => {'Active' => Post.active, 'Past' => Post.past}
:collection => {'Active' => [['Post A', 1], ['Post B', 2]], 'Past' => [['Post C', 3], ['Post D', 4]]}
```

Passing `:polymorphic => true` will enable polymorphic support.  In this mode, an additional 2 hidden input fields are created alongside the select field.

So calling

```ruby
= f.input :primary_contact, :polymorphic => true, :collection => User.all.to_a + Member.all.to_a
```

will internally translate the collection into:

```ruby
[['User 1', 'User_1'], ['User 2', 'User_2'], ['Member 100', 'Member_100']]
```

and instead of posting to the server with the parameter `:primary_contact`, it will intead post `{:primary_contact_id => 2, :primary_contact_type => 'User'}`.

Using both `:polymorphic => true` and `:grouped => true` is recommended.  In this case the expected collection is as follows:

```ruby
= f.input :primary_contact, :polymorphic => true, :grouped => true, :collection => {'Users' => User.all, 'Members' => 'Member.all'}
```

### Options

The default `:input_js => options` used to initialize this form input are as follows:

```ruby
{
  :theme => 'bootstrap',
  :minimumResultsForSearch => 6,
  :tokenSeparators => [',', ' '],
  :width => 'style',
  :placeholder => 'Please choose',
  :allowClear => !(options[:multiple])  # Only display the Clear 'x' on a single selection box
}
```

### Interesting Available Options

To limit the number of items that can be selected in a multiple select box:

```ruby
:maximumSelectionLength => 2
```

To hide the search box entirely:

```ruby
:minimumResultsForSearch => 'Infinity'
```

For a full list of options, please refer to: https://select2.github.io/options.html


The following `:input_js => options` are not part of the standard select2 API, and are custom `effective_select` functionality only:

To add a css class to the select2 container or dropdown:

```ruby
:containerClass => 'custom-container-class'
:dropdownClass => 'custom-dropdown-class'
```

### Additional

Call with `single_selected: true` to ensure only the first selected option tag will be `<option selected="selected">`.

This can be useful when displaying multiple options with an identical value.

### Working with dynamic options

The following information applies to `effective_select` only, and is not part of the standard select2 API.

To totally hide (instead of just grey out) any disabled options from the select2 dropdown, initialize the input with:

```ruby
= f.input :category, :as => :effective_select, :collection => ..., :hide_disabled => true
```

If you want to dynamically add/remove options from the select field after page load, you must use the `select2:reinitialize` event:

```coffeescript
# When something on my page changes
$(document).on 'change', '.something', (event) ->
  $select = $(event.target).closest('form').find('select.i-want-to-change')  # Find the select2 input to be updated

  # Go through its options, and modify some of them.
  # Using the above 'hide_disabled true' functionality, the following code hides the options from being displayed,
  # but you could actually remove the options, add new ones, or update the values/texts. whatever.
  $select.find('option').each (index, option) ->
    $(option).prop('disabled', true) if index > 10

  # Whenever the underlying options change, you need to manually trigger the following event:
  $select.select2().trigger('select2:reinitialize')
```

### AJAX Support

There is currently no support for using AJAX to load remote data.  This feature is supported by the underlying select2 library and will be implemented here at a future point.


## Effective Tel(ephone)

This custom form input uses a jQuery maskedInput plugin from the following awesome project:

jQuery Masked Input Plugin (https://github.com/digitalBush/jquery.maskedinput)


### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_tel/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_tel :phone
```

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :phone, :as => :effective_tel
```

As a SimpleForm input without the input group (phone glyphicon)

```ruby
= simple_form_for @user do |f|
  = f.input :phone, :as => :effective_tel, :input_group => false
```

You should add a server side validation to enforce the default "(123) 555-1234" with optional "x123" extension format:

```ruby
validates :phone, format: { with: /\A\(\d{3}\) \d{3}-\d{4}( x\d+)?\Z/ }
validates :phone, effective_tel: true   # Enforces same format as above
```

## Effective Panel Select

A new way to do grouped collection selects.

```javascript
$(document).on 'change', '.effective-panel-select', (event) ->
  console.log $(event.currentTarget).effectivePanelSelect('val')
```

Ajax

```javascript
      = f.input :exercise_id, as: :effective_panel_select, required: false, label: false,
        collection: exercise_collection,
        grouped: true,
        single_selected: true,
        input_js: { placeholder: 'Choose an exercise', ajax: { url: exercise_path(':id'), target: '.exercise' } },
        wrapper_html: { class: 'program_workouts_routine'}
```

or better,

```javascript
      = f.input :exercise_id, as: :effective_panel_select, required: false, label: false,
        collection: exercise_collection,
        grouped: true,
        single_selected: true,
        input_js: { placeholder: 'Choose an exercise', ajax: { url: exercise_path(':id') } },
        wrapper_html: { class: 'program_workouts_routine'}
```

but in your controller

```ruby
  def show
    @exercise = Exercise.find(params[:id])
    @page_title = @exercise.to_s

    authorize! :show, @exercise

    if params[:effective_panel_select]
      render layout: false
    end

  end
```


## Effective Price

This custom form input uses no 3rd party jQuery plugins.

It displays a currency formatted value `100.00` but posts the "price as integer" value of `10000` to the server.

Think about this value as "the number of cents".


### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_price/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @product do |f|
  = f.effective_price :price
```

As a SimpleForm input:

```ruby
= simple_form_for @product do |f|
  = f.input :price, :as => :effective_price
```

As a SimpleForm input without the input group (glyphicon-usd glyphicon)

```ruby
= simple_form_for @product do |f|
  = f.input :price, :as => :effective_price, :input_group => false
```

### Options

You can pass `include_blank: true` to allow `nil`.  By default `nil`s are convereted, displayed and submitted as `$0.00`.

```ruby
= f.input :price, :as => :effective_price, :include_blank => true
```


### Rails Helper

This input also installs a rails view helper `price_to_currency` that takes a value like `10000` and displays it as `$100.00`


## Effective URL

This custom form input enforces the url starts with http:// or https://

If font-awesome-rails gem is installed, a font-awesome icon for facebook, google, linkedin, twitter, vimeo and youtube will be inserted based on the field name.

### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_url/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @user do |f|
  = f.effective_url :website
```

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :website, :as => :effective_url
```

As a SimpleForm input without the input group (globe glyphicon)

```ruby
= simple_form_for @user do |f|
  = f.input :website, :as => :effective_url, :input_group => false
```

You should add a server side validation to enforce the url starts with http(s?)://

```ruby
validates :website, format: { with: /\Ahttps?:\/\/\w+.+\Z/ }
validates :website, effective_url: true   # Enforced same format as above
```

### Options

You can pass `fontawesome: false` and `glyphicon: false` to tweak the automatic social icon display behaviour.


## Effective CKEditor Text Area

This custom form input replaces a standard textarea with a CKEditor html rich text area.

It is based on the widely used:

CKEditor (http://ckeditor.com/)

and built ontop of

effective_ckeditor (https://github.com/code-and-effect/effective_ckeditor/)

### Installation

You must first install [effective_ckeditor](https://github.com/code-and-effect/effective_ckeditor/)

```ruby
gem 'effective_ckeditor'
```

Depending on how often you're going to display this form input, you now have two options:

- You can do nothing, and when this form input is displayed it will use javascript to load the ckeditor .js and .css file on $(ready).  It will make 2 additional requests, slowing down your page load by a moment.

- Or, when you intend to use the input quite a bit, it's faster to add the effective_ckeditor resources to the asset pipeline.  However, it will increase the asset payload by around 200kb.

To add it to the asset pipeline, put the following to your application.js:

```ruby
//= require effective_ckeditor
```

and in your application.css, add:

```ruby
*= require effective_ckeditor
```

There are no additional effective_ckeditor installation steps.


If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.js:

```ruby
//= require effective_ckeditor_text_area/input
```

### Usage

As a Rails Form Helper input:

```ruby
= form_for @post do |f|
  = f.effective_ckeditor_text_area :body
```

As a SimpleForm input:

```ruby
= simple_form_for @post do |f|
  = f.input :body, :as => :effective_ckeditor_text_area
```

### Options

You can specify the `toolbar` as `'full'` or `'simple'`:

The full toolbar includes Image, oEmbed and Assets, wheras simple does not.

```ruby
= f.input :body, :as => :effective_ckeditor_text_area, :toolbar => 'full'
= f.input :body, :as => :effective_ckeditor_text_area, :toolbar => 'simple'
```

You can specify the `height` and `width`:

```ruby
= f.input :body, :as => :effective_ckeditor_text_area, :height => '400px;', :width => '200px;'
```

And you can specify a `contentsCss` stylesheet:

By default, this loads the `asset_path('application.css')` file, you can also specify `:bootstrap`, `false`, a string url, or an array of urls.

When `:bootstrap`, this loads a CDN hosted bootstrap 3.3.7 stylesheet.

```ruby
= f.input :body, :as => :effective_ckeditor_text_area, :contentsCss => :bootstrap
```


## Effective Radio Buttons

This custom form input adds image support to the SimpleForm radio buttons. It doesn't really work as a regular rails form helper.

### Installation

If you've already installed the 'All Form Inputs' assets (see above), there are no additional installation steps.

To install this form input individually, add the following to your application.css:

```ruby
*= require effective_radio_buttons/input
```

There is no javascript.

### Bootstrap button group

Pass `buttons: true` to the input options to render as a bootstrap button group.

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :breakfast,
    :as => :effective_radio_buttons,
    :collection => ['eggs', 'toast', 'bacon'],
    :buttons => true
```

### Inline

Pass `inline: true` to the input options to render the radio buttons inline.

As a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :breakfast,
    :as => :effective_radio_buttons,
    :collection => ['eggs', 'toast', 'bacon'],
    :inline => true
```

### Images

Pass `images: []` as an array of strings with the same length as the collection to render image buttons.

```ruby
= simple_form_for @user do |f|
  = f.input :breakfast,
    :as => :effective_radio_buttons,
    :collection => ['eggs', 'toast', 'bacon'],
    :images => [asset_path('eggs.png'), asset_path('toast.png'), asset_path('bacon.png')]
```

## License

MIT License.  Copyright [Code and Effect Inc.](http://www.codeandeffect.com/)

## Credits

The authors of this gem are not associated with any of the awesome projects used by this gem.

We are just extending these existing community projects for ease of use with Rails Form Helper and SimpleForm.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Bonus points for test coverage
6. Create new Pull Request
