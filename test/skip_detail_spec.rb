# skip_detail_spec.rb - specs for skip_detail

require_relative 'spec_helper'
require_relative 'detail_helper'


# TODO: class documentation
class SkipperTest < FaultyTest
    def initialize 
    super
    @name = 'AmBeingSkipped'
  end
  attr_reader :name
end

# TODO: class documentation
class MyException
  
end


describe MiniTest::Reporters::SkipDetail do
  describe 'initialize' do
    let(:tst) { SkipperTest.new }
    let(:det) { MiniTest::Reporters::SkipDetail.new(tst) }

    it 'should have hash key type == skipped' do
      det.to_h[:type].must_equal 'skipped'
end
end
end
