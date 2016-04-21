# test_detail_spec.rb - specs for test_detail

require_relative 'spec_helper'

# TODO: class documentation
class TestFaker
  def initialize
    @name = 'FakeDouble'
  end

  attr_reader :name
end

describe Minitest::Reporters::TestDetail do
  let(:tst) { TestFaker.new }
  let(:det) { Minitest::Reporters::TestDetail.new(tst) }

  describe 'initialize' do
    it 'should have hash key name' do
      det.to_h[:name].wont_be_nil
      det.to_h[:name].wont_be_empty
      det.to_h[:name].must_equal 'FakeDouble'
    end

    it 'should have hash key class' do
      det.to_h[:class].wont_be_nil
      det.to_h[:class].wont_be_empty
      det.to_h[:class].must_equal 'TestFaker'
    end

    it 'should have hash key: type' do
      det.to_h[:type].wont_be_nil
      det.to_h[:type].wont_be_empty
    end

    it 'should have attr test_obj' do
      det.test_obj.wont_be_nil
    end

    it 'should have predicate :nil?' do
      det.predicate.wont_be_nil
      det.predicate.must_be_instance_of Symbol
    end
  end

  describe 'query' do
    it 'should return false' do
      det.query.must_equal false
    end
  end
end
