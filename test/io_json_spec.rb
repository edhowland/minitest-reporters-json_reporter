# io_json_spec.rb - specs for io_json

require_relative 'spec_helper'
require_relative 'fake_tests'

describe Minitest::Reporters::JsonReporter do
  let(:rpt) { Minitest::Reporters::JsonReporter.new(:verbose => true) }
  before { rpt.io = StringIO.new(''); rpt.start }

  describe 'io populates a JSON string' do
    before do
      rpt.record(FakeFailer.new)
      rpt.record(FakeError.new)
      rpt.record(FakeSkipper.new)
      rpt.record(FakePasser.new)
    end

    subject { rpt.report; rpt.io.string }

    it 'should be a valid JSON string' do
      JSON.load(subject).must_be_instance_of Hash
    end
  end
end
