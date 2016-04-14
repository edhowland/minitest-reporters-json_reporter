# div_zero_spec.rb - specs for div_zero

require_relative 'spec_helper'

require_relative 'make_exception'

describe 'DivByZero' do
  describe 'make_exception' do
    subject { make_exception }

    specify { subject }
end
end
