# Minitest::Reporters::JsonReporter

This is an extension  gem for the minitest-reporters gem. It adds JSON output as an output format.

[![Gem Version](https://badge.fury.io/rb/minitest-reporters-json_reporter.svg)][gem]
[![Build Status](https://travis-ci.org/edhowland/minitest-reporters-json_reporter.png?branch=master)](https://travis-ci.org/edhowland/minitest-reporters-json_reporter)
[![Coverage Status](https://coveralls.io/repos/github/edhowland/minitest-reporters-json_reporter/badge.svg?branch=master)](https://coveralls.io/github/edhowland/minitest-reporters-json_reporter?branch=master)
[![Code Climate](https://codeclimate.com/github/edhowland/minitest-reporters-json_reporter/badges/gpa.svg)](https://codeclimate.com/github/edhowland/minitest-reporters-json_reporter)
[![Inline docs](http://inch-ci.org/github/edhowland/minitest-reporters-json_reporter.svg?style=shields)](http://inch-ci.org/github/edhowland/minitest-reporters-json_reporter)




## Abstract

You can use this gem to interface Minitest output into automated tools like CI, CD or IDEs or code editors. An
example interface might be to the Atom editor: [https://atom.io](https://atom.io)
I originally wrote this gem to interface to the Viper audible  code editor for the blind community. See: [https://github.com/edhowland/viper](https://github.com/edhowland/viper)
Using this gem with Viper also requires the 'viper_ruby' package. See [https://github.com/edhowland/viper_ruby](https://github.com/edhowland/viper_ruby)

## Version 0.9.9

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


* status of the overall test run. Object.
  * code - Success, Passed with skipped tests or Failed. String.
  * color green, yellow or red. String.
* metadata The metadata of this particular test run. Object.
  * generated_by Class name of the Minitest Reporter. Will usually be Minitest::Reporters::JsonReporter. String.
  * version - Version of the minitest-reporters-json_reporter gem. String.
  * ruby_version - RUBY_VERSION. String.
  * ruby_patchlevel - RUBY_PATCHLEVEL. Integer.
  * ruby_platform - RUBY_PLATFORM. String.
  * time - Time of test run in UTC and ISO-8601 format. String.
  * options - Options object as constructed by passed options, superclasses and command line args. Object.
    * io - The class name of the IO object. Will be the string 'STDOUT' if equal to $stdout. String.
    * keys of the options hash, if any. Various key/value pairs.
    * args Array of arguments passed to the program. Array of String.
    * total_count - Total number of tests ran. Integer.
* statisticsThe accumulated counts for this test run.   Object.
  * total Number of total runs. Integer.
  * assertions Count of assertions performed. Integer.
  * failures Number of failed tests. Integer.
  * errors Number of errors encountered. Integer.
  * skips Number of skipped tests. Integer.
  * passes Number of passed tests. Integer.
* timings Object containing the computed timing information for the entire test run. Object.
  * total_seconds total number of seconds for the entire test run. Float.
  * runs_per_second Averaged number of runs per second. Float.
  * assertions_per_second Averaged number of assertions per second. Float.
* fails - Array of failed or errored tests. Array of Object.
  * type Type of the failure. Either 'failure' or 'error'. String.
  * classClass name of the test. String.
  * name Name of the test. String.
  * assertions Number of the assertions for this test. Integer.
  * time Time in seconds for this test. Float.
  * message Message reported by this failure or error. String.
  * location File name and line number. file:line. String.
  * backtrace (exists only if type is 'error') Array of backtrace paths and line numbers. Array of String.
* skips Array of skipped tests. Array of Object.
  * type The string 'skipped'. String.
  * class Class name of the test. String.
  * name The name of the test. String.
  * assertions The count of the assertions for this test. Integer.
  * time The time of this test in seconds. Float.
  * message The message string passed to the 'skip()' method. String.
  * location File name and line number. file:line. String.
* passes Array of passed test runs. Array of Object.
  * type The string 'passed'. String.
  * class Class name of the test. String.
  * name The name of the test. String.
  * assertions The count of the assertions for this test. Integer.
  * time The time of this test in seconds. Float.

The last 2 objects: skips[] and passes[] are absent unless the --verbose command
line flag was passed or if the options[:verbose] value is true.



### Sample output

```
# Use jq to pretty print the JSON output
$  cd test/functional/
$ ruby report_spec.rb | jq .
{
  "status": {    "code": "Failed",    "color": "red"  },
  "metadata": {
    "generated_by": "Minitest::Reporters::JsonReporter",
    "version": "0.9.9",
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

## Customizing the JSON format

You can adjust the contents of the returned JSON by sub-classing the Minitest::Reporters::JsonReporter class.
Override the 'to_h' method and delete or modifythe hash it returns.

Here is a simple example that eliminates the 'metadata' and 'timmings' components:

```
# example spec_helper.rb:

class Minitest::Reporters::SlimJsonReporter < Minitest::Reporters::JsonReporter
    def to_h
    h = super
    h.delete(:metadata)
    h.delete(:timings)
    h
  end
end

Minitest::Reporters.use!( Minitest::Reporters::SlimJsonReporter.new )
```



## Contributing

1. Fork it ( https://github.com/edhowland/minitest-reporters-json_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Note: Extra credit if git flow feature branching was used.


## Resources

* Code: [https://github.com/edhowland/minitest-reporters-json_reporter](https://github.com/edhowland/minitest-reporters-json_reporter)
* Bugs: [https://github.com/edhowland/minitest-reporters-json_reporter/issues](https://github.com/edhowland/minitest-reporters-json_reporter/issues)
* Docs: [http://www.rubydoc.info/gems/minitest-reporters-json_reporter/0.9.5](http://www.rubydoc.info/gems/minitest-reporters-json_reporter/0.9.5)
* Gem: [https://rubygems.org/gems/minitest-reporters-json_reporter](https://rubygems.org/gems/minitest-reporters-json_reporter)

###### Feedback

If you find this gem helpful, please slip me a note via e-mail: ed.howland@gmail.com


I would like to know if anyone has used this approach to interface Minitest to any automated framework or editor.

Thanks, Ed.

