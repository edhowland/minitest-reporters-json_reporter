# error_failure_spec.rb - specs for error_failure

require_relative 'spec_helper'
require_relative 'fake_tests'

describe 'two tests' do
  let(:rpt) { Minitest::Reporters::JsonReporter.new }
  let(:fawlty) { FakeFailer.new }
  let(:err) { FakeError.new }
  before { rpt.io = StringIO.new(''); rpt.start }
  subject { rpt.record(err); rpt.record(fawlty) }

  it 'should have 2 entries in storage[:fails]' do
    subject
    rpt.report
    rpt.storage[:fails].length.must_equal 2
  end
end
