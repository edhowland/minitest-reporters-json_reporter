# skip_detail_spec.rb - specs for skip_detail

require_relative 'spec_helper'
require_relative 'detail_helper'

class SkipperTest < FaultyTest
  def initialize 
    super
    @name = 'AmBeingSkipped'
  end
  attr_reader :name

  def skipped?
    true
  end
end

## TODO: class documentation
#class MyException
#  
#end

describe MiniTest::Reporters::SkipDetail do
  let(:tst) { SkipperTest.new }
  let(:det) { MiniTest::Reporters::SkipDetail.new(tst) }

  describe 'initialize' do

    it 'should have predicate == :skipped?' do
      det.predicate.wont_be_nil
      det.predicate.must_equal :skipped?
    end

    it 'should have hash key type == skipped' do
      det.to_h[:type].must_equal 'skipped'
    end
  end

  describe 'query' do
    before { @value = 0 }
    it 'should return true' do
      det.query.must_equal true
    end

    it 'should call block' do
      det.query {|d| @value += 1 }
      @value.must_equal 1
    end
  end
end
