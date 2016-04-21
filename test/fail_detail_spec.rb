# fail_detail_spec.rb - specs for fail_detail

require_relative 'spec_helper'
require_relative 'detail_helper'

describe Minitest::Reporters::FailDetail do
  describe 'query' do
    let(:tst) { FailTest.new }
    let(:det) { Minitest::Reporters::FailDetail.new(tst) }

    it 'should return true' do
      det.query.must_equal true
    end
  end
end
