# error_failure_spec.rb - specs for error_failure

require_relative 'detail_helper'

require_relative 'spec_helper'

describe 'two tests' do
  let(:rpt) { Minitest::Reporters::JsonReporter.new }
  let(:fawlty) { FailTest.new }
  let(:err) { FaultyTest.new }
  before { $stdout = StringIO.new(''); rpt.start }
  subject { rpt.record(err); rpt.record(fawlty) }

  it 'should have 2 entries in storage[:fails]' do
    subject
    rpt.report
    rpt.storage[:fails].length.must_equal 2
  end
end
