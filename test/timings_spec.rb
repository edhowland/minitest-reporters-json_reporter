# timings_spec.rb - specs for timings
require_relative 'spec_helper'
require_relative 'fake_tests'

describe 'timings are accumulated for multiple tests' do
  let(:err) { FakeError.new }
  let(:bad) { FakeFailer.new }
  let(:ok) { FakePasser.new }
  let(:rpt) { Minitest::Reporters::JsonReporter.new }
  before do
    rpt.start
    rpt.record(bad)
    rpt.record(err)
    rpt.record(ok)
  end
  subject { rpt.report }

  it 'should have timings > 0' do
    subject

    rpt.storage[:timings][:total_seconds].must_be :>, 0.0
  end

  #  it 'should be near 0.3' do
  #    subject
  #    rpt.storage[:timings][:total_seconds].must_be :>=, 0.3
  #  end
end
