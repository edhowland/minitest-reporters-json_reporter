# test_detail_spec.rb - specs for test_detail

require_relative 'spec_helper'

# TODO: class documentation
class TestDouble
    def initialize 
    @name = 'Fake'
  end
end

describe MiniTest::Reporters::TestDetail do
  describe 'initialize' do
    let(:tst) { TestDouble.new }
  let(:det) { MiniTest::Reporters::TestDetail.new(tst) }

    it 'should have hash key name' do
      det.to_h[:name].wont_be_nil
    end
  end
end
