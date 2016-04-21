# fail_equal_spec.rb - specs for fail_equal

require_relative 'spec_helper'

describe 'Non Working assert equals' do
  let(:num) { 4 }

  it 'should be 4' do
    num.must_equal 0
  end
end
