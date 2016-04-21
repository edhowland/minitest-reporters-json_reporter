# error_detail_spec.rb - specs for error_detail

require_relative 'spec_helper'
require_relative 'detail_helper'

describe Minitest::Reporters::ErrorDetail do
  describe 'query' do
    let(:tst) { FaultyTest.new }
    let(:det) { Minitest::Reporters::ErrorDetail.new(tst) }
    subject { det.query }

    it 'should tst.failure.backtrace exists and is not empty' do
      tst.failure.backtrace.wont_be_nil
    end

    it 'should return true' do
      subject.must_equal true
    end

    it 'should set message' do
      subject
      det.to_h[:message].wont_be_nil
      det.to_h[:message].wont_be_empty
    end

    it 'should set backtrace' do
      subject
      det.to_h[:backtrace].wont_be_nil
      det.to_h[:backtrace].wont_be_empty
    end
  end
end
