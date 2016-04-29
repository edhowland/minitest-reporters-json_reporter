# Minitest::Reporters::JsonReporter

This is an extension  gem for the minitest-reporters gem. It adds JSON output as an output format.

[![Gem Version](https://badge.fury.io/rb/minitest-reporters-json_reporter.svg)][gem]

## Abstract

You can use this gem to interface Minitest output into automated tools like CI, CD or IDEs or code editors. An
example interface might be to the Atom editor: [https://atom.io](https://atom.io)
I originally wrote this gem to interface to the Viper audible  code editor for the blind community. See: [https://github.com/edhowland/viper](https://github.com/edhowland/viper)

## Version 0.2.1

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
Minitest::Reporters.use! [ Minitest::Reporters::JsonReporter.new ]
```

Then run your tests as normal. You will get a JSON formatted string in stdout.


## Object Summary


1. status -  Status of the overall test run. Can be 'Success', 'Passed with skipped tests' or 'Failed'. There also a color attribute: green, yellow or red - respectfully.
2. metadata - General information about this test run. Includes generator name, version and the test run completion time in UTC formatted in ISO8601 format. Also include options object computed by super classes including command line arguments.
3. statistics - Contains the total number of runs, the number of assertions, the number of fails, skips and passes.
4. Timings - Including total_seconds, runs_per_second and assertions_per_second in float format
5. fails - Array of failed or errored tests. Each object herein contains the information of each test, its name, class, error message, number of assertions, the timing and location of the test and the filtered backtrace array if an error type.

### Optional objects

If the '--verbose' flag was passed on the command line or the options[:verbose]  = true was passed to the constructor
you will get 2 additional objects: skips[] and passes[]

6. skips[] - Information about the skipped test including its message, number of assertions, the time to run the skip and location.
7. passes[] - Information for all passed test runs including the type, the test name, class, the number of assertions and timing.


### Sample output

```
# Use jq to pretty print the JSON output
$  cd test/functional/
$ ruby report_spec.rb | jq .
{
  "status": {
    "code": "Failed",
    "color": "red",
    "message": "You have skipped tests. Run with --verbose for details."
  },
  "metadata": {
    "generated_by": "Minitest::Reporters::JsonReporter",
    "version": "0.2.1",
    "time": "2016-04-29T20:29:55Z",
    "options": {
      "io": "STDOUT",
      "seed": 33711,
      "args": "--seed 33711",
      "total_count": 5
    }
  },
  "statistics": {
    "total": 5,
    "assertions": 4,
    "failures": 2,
    "errors": 1,
    "skips": 1,
    "passes": 1
  },
  "timings": {
    "total_seconds": 0.002952398994239047,
    "runs_per_second": 1693.5380379672235,
    "assertions_per_second": 1354.8304303737789
  },
  "fails": [
    {
      "type": "error",
      "class": "Error",
      "name": "test_0001_anonymous",
      "assertions": 0,
      "time": 9.57950105657801e-05,
      "message": "RuntimeError: should fail\n    report_spec.rb:6:in `block (2 levels) in <main>'",
      "location": "report_spec.rb:6",
      "backtrace": [
        "report_spec.rb:6:in `block (2 levels) in <main>'"
      ]
    },
    {
      "type": "failed",
      "class": "failure",
      "name": "test_0001_anonymous",
      "assertions": 1,
      "time": 0.00013120500079821795,
      "message": "Expected: 2\n  Actual: 1",
      "location": "report_spec.rb:14"
    },
    {
      "type": "failed",
      "class": "second failure",
      "name": "test_0001_anonymous",
      "assertions": 1,
      "time": 5.974200030323118e-05,
      "message": "Expected: 9\n  Actual: 3",
      "location": "report_spec.rb:20"
    }
  ]
}
```


## Contributing

1. Fork it ( https://github.com/edhowland/minitest-reporters-json_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Note: Extra credit if git flow feature branching was used.

