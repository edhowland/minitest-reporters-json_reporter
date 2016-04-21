# Minitest::Reporters::JsonReporter

This is an extension  gem for the minitest-reporters gem. It adds JSON output as an output format.
You can use this gem to interface MiniTest output into automated tools like CI, CD or IDEs or code editors. An
example interface might be to the Atom editor: [https://atom.io](https://atom.io)
I originally wrote this gem to interface to the Viper audible  code editor for the blind community. See: [https://github.com/edhowland/viper](https://github.com/edhowland/viper)

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
The constructor accepts all the arguments as normal MiniTest::Reporters reporters. E.g. you can pass any IO object as the first arg to write the JSON to a file.
You can also set any options in your test_helper.rb such as :verbose => true.


There are 5 or 6   objects contained within this output: The 6th object: passes is only included if the --verbose option was passed to the test or set in the options parameter to the constructor.

1. status -  Status of the overall test run. Can be 'Success', 'Passed with skipped tests' or 'Failed'. There also a color attribute: green, yellow or red - respectfully.
2. metadata - General information about this test run. Includes generator name, version and the test run completion time in UTC formatted in ISO8601 format. Also include options object computed by super classes including command line arguments.
3. statistics - Contains counts of the status of test cases. Includes: Total, Skipped, Failed Errored and Passed.
4. fails - Array of failed or errored tests. Each object herein contains the information of each test, its name, class, error message and location of the test and the filtered backtrace array if an error type.
5. skips - Array of each skipped. Each object contains the information as a failed test, including the skip message, if any.
6. passes - Array of passing tests if the --verbose option was set . This object is normally absent otherwise.

Here is a sample output:

```
# Use jq to pretty print the JSON output
$  cd test/functional/
$ ruby report_spec.rb  --verbose | jq .
{
  "status": {
    "code": "Failed",
    "color": "red"
  },
  "metadata": {
    "generated_by": "Minitest::Reporters::JsonReporter",
    "version": "0.1.1",
    "time": "2016-04-15T14:51:27Z",
    "options": {
      "io": "STDOUT",
      "verbose": true,
      "seed": 43339,
      "args": "--verbose --seed 43339"
    }
  },
  "statistics": {
    "total": 5,
    "failed": 2,
    "errored": 1,
    "skipped": 1,
    "passed": 1
  },
  "fails": [
    {
      "type": "failure",
      "class": "second failure",
      "name": "test_0001_anonymous",
      "message": "Expected: 9\n  Actual: 3",
      "backtrace": [],
      "location": [
        "report_spec.rb:20",
        []
      ]
    },
    {
      "type": "failure",
      "class": "failure",
      "name": "test_0001_anonymous",
      "message": "Expected: 2\n  Actual: 1",
      "backtrace": [],
      "location": [
        "report_spec.rb:14",
        []
      ]
    },
    {
      "type": "error",
      "class": "Error",
      "name": "test_0001_anonymous",
      "message": "RuntimeError: should fail\n    report_spec.rb:6:in `block (2 levels) in <main>'",
      "backtrace": [
        "report_spec.rb:6:in `block (2 levels) in <main>'"
      ],
      "location": [
        "report_spec.rb:6",
        [
          "report_spec.rb:6:in `block (2 levels) in <main>'"
        ]
      ]
    }
  ],
  "skips": [
    {
      "type": "skipped",
      "class": "skipped test",
      "name": "test_0001_anonymous",
      "message": "what a layabout",
      "backtrace": [],
      "location": [
        "report_spec.rb:32",
        []
      ]
    }
  ],
  "passes": [
    {
      "type": "pass",
      "class": "working assertion",
      "name": "test_0001_anonymous"
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

^.