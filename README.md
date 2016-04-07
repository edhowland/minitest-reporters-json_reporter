# Minitest::Reporters::JsonReporter

This is an extension  gem for the minitest-reporters gem. It adds JSON output as an output format.
You can use this gem to interface MiniTest output into automated tools or IDEs or programmer's editors. An
example interface might be to the Atom editor: [https://atom.io](https://atom.io)
I originally wrote this gem to interface to the Viper audible  Programmer's editor for the blind programmer community. See: [https://github.com/edhowland/viper](https://github.com/edhowland/viper)

## Version 0.1.1



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-reporters-json_reporter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-reporters-json_reporter

## Usage

Add this line to your 'spec_helper.rb' or 'test_helper.rb':

```
require 'minitest/reporters/json_reporter'
```

In that same file, add something like this near the bottom of the file:

```
MiniTest::Reporters.use! [ MiniTest::Reporters::JsonReporter.new ]
```

Then run your tests as normal. You will get a JSON formatted string in stdout.
There are 5 objects contained within this output:

1. metadata - General information about this test run. Includes generator name, version and the test run completion time in UTC formatted in ISO8601 format.
2. status -  Status of the overall test run. Can be 'Success', 'Passed with skipped tests' or 'Failed'. There also a color attribute: green, yellow or red - respectfully.
3. statistics - Contains counts of the status of test cases. Includes: Total, Skipped, Failed Errored and Passed.
4. fails - Array of failed or errored tests. Each object herein contains the information of each test, its name, class, error message and location of the test.
5. skips - Array of each skipped. Each object contains the information as a failed test, including the skip message, if any.


## Contributing

1. Fork it ( https://github.com/edhowland/minitest-reporters-json_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
