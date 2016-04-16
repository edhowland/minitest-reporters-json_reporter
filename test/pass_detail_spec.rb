# pass_detail_spec.rb - specs for pass_detail

require_relative 'spec_helper'

# TODO: class documentation
class PassedTest
    def initialize 
    @name = 'MyPassingTest'
  end

  attr_reader :name
end


describe MiniTest::Reporters::PassDetail do
  describe 'to_h' do
    let(:tst) { PassedTest.new }
    let(:det) { MiniTest::Reporters::PassDetail.new(tst) }

    it 'should have hash key:type == pass' do
      det.to_h[:type].must_equal 'passed'
    end
  end
end
