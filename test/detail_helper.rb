# detail_helper.rb - methods, classes for *_detail_spec.rb specs
def assert expr
  fail('bad juju') unless expr
end

#binding.pry
# mk_exc - create an exception for use in  these tests
def mk_exc message
  assert false
  rescue => err
    err
end

class FaultyTest
  def initialize 
    @failure = mk_exc('bad juju')
  end

  attr_reader :failure

  def name; 'juju'; end
end
