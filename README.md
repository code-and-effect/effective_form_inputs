# Effective Form Inputs

Multiple custom Rails Form Helper and SimpleForm inputs in one Rails engine.

This gem contains numerous custom form inputs along with their Javascript/CSS assets.

Each included form input is available to both the default Rails Form Helper and SimpleForm.

Rails 3.2.x and 4.x

Right now there's just one form input.  This will grow.

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


## Bootstrap3 DateTimePicker

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

and as a SimpleForm input:

```ruby
= simple_form_for @user do |f|
  = f.input :updated_at, :as => :effective_date_time_picker
```

### Passing Options to JavaScript

Any options passed to the form input will be used to initialize the Bootstrap3 DateTimePicker

For example (and this works just the same with the SimpleForm input):

```ruby
= form_for @user do |f|
  = f.effective_date_time_picker :updated_at, :format => 'YYYY-MM-DD', :showTodayButton => true
```

For a full list of options, please refer to:

http://eonasdan.github.io/bootstrap-datetimepicker/Options/


## License

MIT License.  Copyright [Code and Effect Inc.](http://www.codeandeffect.com/)

Code and Effect is the product arm of [AgileStyle](http://www.agilestyle.com/), an Edmonton-based shop that specializes in building custom web applications with Ruby on Rails.


## Credits

The authors of this gem are not associated with any of the awesome projects used in this gem.

We are just extending these existing community projects for ease of use with Rails Form Helper and SimpleForm


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Bonus points for test coverage
6. Create new Pull Request

