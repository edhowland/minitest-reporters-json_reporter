# fault_detail_spec.rb - specs for fault_detail

require_relative 'spec_helper'

# TODO: class documentation
class FaultyTest
  def name; 'juju'; end
end

describe MiniTest::Reporters::FaultDetail do
  describe 'to_h' do
    let(:exc) { RuntimeError.new 'bad juju' }
    let(:tst) { FaultyTest.new }
    let(:det) { MiniTest::Reporters::FaultDetail.new(tst, exc) }
    it 'should have hash with superclass' do
      det.to_h[:name].must_equal 'juju'
      det.to_h[:class].must_equal 'FaultyTest'
    end

    it 'should have exception stuff in hash' do
      det.to_h[:message].must_equal 'bad juju'
    end


end

end
