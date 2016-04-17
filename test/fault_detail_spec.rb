# fault_detail_spec.rb - specs for fault_detail

require_relative 'spec_helper'
require_relative 'detail_helper'



# FaultyTest (apologies  to Jhon Cleese) A Minitest::Test fake

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
      det.to_h[:location].wont_be_nil
      det.to_h[:location].wont_be_empty
end
end
end
