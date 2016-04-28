# all_types_spec.rb - specs for 

require_relative 'spec_helper'
require_relative 'fake_tests'


describe Minitest::Reporters::JsonReporter do
  let(:rpt) { Minitest::Reporters::JsonReporter.new }
  before { rpt.io = StringIO.new(''); rpt.start }

  describe 'when running 1 skip, 1 failure, 1 error and 1 pass' do
    before do
      rpt.record(FakeSkipper.new)
      rpt.record(FakeFailer.new)
      rpt.record(FakeError.new)
      rpt.record(FakePasser.new)
    end
  subject { rpt.report; rpt.storage }

    it 'should have skips 1' do
  subject
      rpt.skips.must_equal 1
    end

    it 'should have failures 1' do
      subject
      rpt.failures.must_equal 1
    end

    it 'should have errors 1' do
      subject
      rpt.errors.must_equal 1
    end
end
end
