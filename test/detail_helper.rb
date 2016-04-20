# detail_helper.rb - methods, classes for *_detail_spec.rb specs
def assert(expr)
  fail('bad juju') unless expr
end

# mk_exc - create an exception for use in  these tests
def mk_exc(_message)
  assert false
rescue => err
  err
end

# TODO: class documentation
class FakeBaseTest
  def initialize(name)
    @name = name
    @assertions = 0
  end

  attr_accessor :assertions
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

# TODO: class documentation
class FakePasser < FakeBaseTest
  def initialize
    super 'passer'
  end

  def passed?
    true
  end
end

class FaultyTest < FakeBaseTest
  def initialize
    super 'juju'
    @failure = mk_exc('bad juju')
  end

  attr_reader :failure

  def error?
    true
  end
end

# TODO: class documentation
class FailTest < FakeBaseTest
  def initialize
    super 'up creek, less paddle'
  end

  def failure
    mk_exc 'crap'
  end
end

# TODO: class documentation
class FakeSkipper < FakeBaseTest
  def skipped?
    true
  end

  def failure
    mk_exc 'skipped'
  end

end
