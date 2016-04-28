# fake_tests.rb - methods, classes for  specs to simulate Minitest tests

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

class FailTest < FakeNonPasserBase
  def initialize
    super 'up creek, less paddle'
  end

  def failure
    begin
      make_assertion 'x does match y'
    rescue => err
      err
    end
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
