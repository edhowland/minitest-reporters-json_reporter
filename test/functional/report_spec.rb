# report_spec.rb - specs for report

require_relative 'spec_helper'

describe 'Error' do
  subject { fail 'should fail' }

  specify { subject }
end

describe 'failure' do
  subject { 1 }

  specify { subject.must_equal 2 }
end

describe 'second failure' do
  subject { 3 }

  specify { subject.must_equal 9 }
end

describe 'working assertion' do
  subject { true }

  specify { subject.must_equal true }
end

describe 'skipped test' do
  subject { 1 }

  specify { skip('what a layabout') }
end
