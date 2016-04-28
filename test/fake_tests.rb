# fake_tests.rb - methods, classes for  specs to simulate Minitest tests

# modify Minitest::Reporters::JsonReporter to override count of failures, errors and skips
class Minitest::Reporters::JsonReporter
  def failures
    tests.reject {|e| e.skipped? or e.error? or e.passed? }.length
  end

    def errors
    tests.select {|e| e.error? }.length
  end

    def skips
    tests.select {|s| s.skipped? }.length
  end
end



def make_assertion message
  raise Minitest::Assertion.new message
end

def assert(expr)
  fail('bad juju') unless expr
end

# mk_exc - create an exception for use in  these tests
def mk_exc(_message)
  assert false
rescue => err
  err
end

class FakeBaseTest
  def initialize(name)
    @name = name
    @assertions = 0
    @time = 0.1
  end

  attr_accessor :assertions
  attr_reader :time
  attr_reader :name

  def passed?
    false
  end

  def skipped?
    false
  end

  def error?
    false
  end

  def failure
    nil
  end
end

class FakePasser < FakeBaseTest
  def initialize
    super 'passer'
  end

  def passed?
    true
  end
end
class FakeNonPasserBase < FakeBaseTest
  def initialize(name = 'juju')
    super name
    @failure = mk_exc('bad juju')
  end

  attr_reader :failure
end

class FakeError < FakeNonPasserBase
  def error?
    true
  end
end

class FakeFailer < FakeNonPasserBase
  def initialize
    super 'up creek, less paddle'
  end

  def failure
    mk_exc 'bad assertion'
  end
end

class FakeSkipper < FakeNonPasserBase
  def initialize 
    super 'lazy S.O.G.'
  end

  def skipped?
    true
  end
end
