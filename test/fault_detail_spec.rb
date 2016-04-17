# fault_detail_spec.rb - specs for fault_detail

require_relative 'spec_helper'

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


# FaultyTest (apologies  to Jhon Cleese) A Minitest::Test fake
class FaultyTest
  def initialize 
    @failure = mk_exc('bad juju')
  end

  attr_reader :failure

  def name; 'juju'; end
end

describe MiniTest::Reporters::FaultDetail do
  describe 'to_h' do
    let(:tst) { FaultyTest.new }
    let(:det) { MiniTest::Reporters::FaultDetail.new(tst)  }
    it 'should have hash with superclass' do
      det.to_h[:name].must_equal 'juju'
      det.to_h[:class].must_equal 'FaultyTest'
    end

    it 'should have exception stuff in hash' do
      det.to_h[:message].must_equal 'bad juju'
    end

    it 'should have location: fault_detail_spec.rb' do
      det.to_h[:location].must_equal 'fault_detail_spec.rb:12'
end



end

end
