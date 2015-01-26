# Effective Form Inputs

The purpose of this gem is to house a whole bunch of Javascript form inputs that can then be all at once brought into a Rails app

Each form input will be a Rails FormBuilder and a simple_form input

Right now there's just one form input -- the bootstrap3 datepicker

## Installation

bundle install the gem

No rails generater to run

If you want to use all inputs:

//= require effective_form_inputs
@import 'effective_form_inputs';

Or just one:

//= require effective_date_time_picker/input
@import 'effective_date_time_picker/input';

## Bootstrap3 Datepicker

https://github.com/Eonasdan/bootstrap-datetimepicker

As a rails FormBuilder

= f.effective_date_time_picker :updated_at

As a SimpleForm input

= f.input :updated_at, :as => :effective_date_time_picker

## TODO

Write a proper README.

## License

MIT License.  Copyright [Code and Effect Inc.](http://www.codeandeffect.com/)

Code and Effect is the product arm of [AgileStyle](http://www.agilestyle.com/), an Edmonton-based shop that specializes in building custom web applications with Ruby on Rails.


## Credits


## Testing

The test suite for this gem is unfortunately not yet complete.

Run tests by:

```ruby
rake spec
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Bonus points for test coverage
6. Create new Pull Request

