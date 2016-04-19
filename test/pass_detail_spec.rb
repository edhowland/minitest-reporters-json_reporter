# pass_detail_spec.rb - specs for pass_detail

require_relative 'spec_helper'

# TODO: class documentation
class InvalidTest
  def name;
    'invalid';
  end

  def passed?
    false
  end
end

class PassedTest
  def initialize
    @name = 'MyPassingTest'
end

  attr_reader :name

  def passed?
    true
  end
end

describe MiniTest::Reporters::PassDetail do
  let(:tst) { PassedTest.new }
  let(:det) { MiniTest::Reporters::PassDetail.new(tst) }

  describe 'predicate' do
    it 'should be :passed?' do
      det.predicate.must_equal :passed?
    end
  end

  describe 'query' do
    before { @value = 0 }

    it 'should return true' do
      det.query.must_equal true
    end

    it 'should call block' do
      det.query { |_d| @value += 1 }
      @value.must_equal 1
    end
  end

  describe 'to_h' do
    it 'should have hash key:type == pass' do
      det.to_h[:type].must_equal 'passed'
    end
  end

  describe 'with InvalidTest' do
    let(:inv) { InvalidTest.new }
    let(:det) { MiniTest::Reporters::PassDetail.new(inv) }
    before { @value = 0 }

    it 'should query be false' do
      det.query.must_equal false
    end

    it 'should not call block' do
      det.query { |_d| @value += 1 }
    end
  end
end
