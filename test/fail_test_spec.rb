# fail_test_spec.rb - specs for fail_test

require_relative 'spec_helper'
require_relative 'fake_tests'


class TestFailEqual < Minitest::Test

  def test_1_is_equal_2
    assert_equal 1, 2
  end
end


describe Minitest::Reporters::JsonReporter do
    let(:rpt) { Minitest::Reporters::JsonReporter.new }
  before { rpt.io = StringIO.new(''); rpt.start }

  describe 'when running one failure' do
    subject {rpt.record( TestFailEqual.new('bad juju'));  rpt.report; rpt.storage }

    it 'should have 1 failure' do
      subject
      rpt.failures.must_equal 1
    end
  end

end
