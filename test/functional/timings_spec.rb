# timings_spec.rb - specs for timings

require_relative 'spec_helper'

describe 'Timings Test' do
  it 'should be slow' do
    sleep(5)
    true.wont_equal false
  end

  it 'should be fast' do
    1.must_equal 1
  end

  it 'should be slightly faster' do
    sleep(1)
    4.must_be :>, 0
  end
end
