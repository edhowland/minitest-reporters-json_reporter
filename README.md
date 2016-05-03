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


1. status -  Status of the overall test run.

    1.1 code - Success, Passed with skipped tests or Failed.  
    1.2 - color green, yellow or red.  

2. metadata

    2.1 generated_by Class name of the Minitest Reporter.  
    2.2 version - Version of the minitest-reporters-json_reporter gem.  
    2.3 ruby_version - RUBY_VERSION.  
    2.4 ruby_patchlevel - RUBY_PATCHLEVEL.  
    2.5 ruby_platform - RUBY_PLATFORM.  
    2.6 time - Time of test run in UTC and ISO-8601 format.  
    2.7 options - Options object as constructed by passed options, superclasses and command line args..  

        2.7.1 io - The class name of the IO object. Will be the string 'STDOUT' if equal to $stdout.  
        2.7.2 keys of the options hash, if any. ...  
        2.7.3 args Array of arguments passed to the program.  
          2.7.4 total_count - Total number of tests ran.  

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
  "status": {    "code": "Failed",    "color": "red"  },
  "metadata": {
    "generated_by": "Minitest::Reporters::JsonReporter",
    "version": "0.2.1",
    "ruby_version": "2.2.2",
    "ruby_patchlevel": 95,
    "ruby_platform": "x86_64-linux",
    "time": "2016-05-03T20:57:42Z",
    "options": {
      "io": "STDOUT",
      "verbose": true,
      "seed": 3023,
      "args": "--verbose --seed 3023",
      "total_count": 5
    }
  },
  "statistics": {    "total": 5,    "assertions": 4,    "failures": 2,
    "errors": 1,    "skips": 1,    "passes": 1  },
  "timings": {
    "total_seconds": 0.0014724910142831504,
    "runs_per_second": 3395.606459733908,
    "assertions_per_second": 2716.4851677871266
  },
  "fails": [
    {
      "type": "failed",      "class": "second failure",      "name": "test_0001_anonymous",
      "assertions": 1,      "time": 9.327399311587214e-05,
      "message": "Expected: 9\n  Actual: 3",
      "location": "report_spec.rb:20"
    },
    {
      "type": "failed",
      "class": "failure",      "name": "test_0001_anonymous",      "assertions": 1,
      "time": 3.400500281713903e-05,
      "message": "Expected: 2\n  Actual: 1",
      "location": "report_spec.rb:14"
    },
    {
      "type": "error",      "class": "Error",
      "name": "test_0001_anonymous",      "assertions": 0,
      "time": 2.1556013962253928e-05,
      "message": "RuntimeError: should fail\n    report_spec.rb:6:in `block (2 levels) in <main>'",
      "location": "report_spec.rb:6",
      "backtrace": [
        "report_spec.rb:6:in `block (2 levels) in <main>'"
      ]
    }
  ],
  "skips": [
    {
      "type": "skipped",      "class": "skipped test",      "name": "test_0001_anonymous",
      "assertions": 0,
      "time": 3.7049001548439264e-05,
      "message": "what a layabout",
      "location": "report_spec.rb:34"
    }
  ],
  "passes": [
    {
      "type": "passed",      "class": "working assertion",
      "name": "test_0001_should have 2 working assertions",      "assertions": 2,
      "time": 2.5684013962745667e-05
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

