# skipped_spec.rb - specs for skipped

require_relative 'spec_helper'

describe 'skipped test' do
  specify { skip('will be skipped') }
end
