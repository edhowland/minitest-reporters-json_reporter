# json_reporter_spec.rb - specs for json_reporter

require_relative 'spec_helper'
require_relative 'fake_tests'

describe Minitest::Reporters::JsonReporter do
  let(:rpt) { Minitest::Reporters::JsonReporter.new }
  before { rpt.io = StringIO.new(''); rpt.start }
  describe 'when running no tests' do
  subject { rpt.report; rpt.storage }
    it 'should have non-nil fails[]' do
  subject[:fails].wont_be_nil
    end

    it 'should have no fails' do
      subject[:fails].must_be_empty
    end

    it 'should have non-nil skips' do
      subject[:skips].wont_be_nil
    end

    it 'should have empty skips[]' do
      subject[:skips].must_be_empty
    end

    it 'should have nil passes[]' do
      subject[:passes].must_be_nil
    end

    it 'should have status:color green' do
      subject[:status][:color].must_equal 'green'
    end

    it 'should have status:code Success' do
      subject[:status][:code].must_equal 'Success'
    end

    it 'should havemetadata:generated_by Minitest::Reporters::JsonReporter ' do
      subject[:metadata][:generated_by].must_equal 'Minitest::Reporters::JsonReporter'
    end

    it 'should have metadata:version non-empty' do
      subject[:metadata][:version].wont_be_empty
    end

    it 'should have metadata:time non-empty' do
      subject[:metadata][:time].wont_be_empty
    end

    it 'should have metadata:options be instance of Hash' do
      subject[:metadata][:options].must_be_instance_of Hash
    end

    it 'should have metadata:options non_empty' do
      subject[:metadata][:options].wont_be_empty
    end

    it 'should have statistics:total 0' do
      subject[:statistics][:total].must_equal 0
    end

    it 'should have statistics:assertions 0' do
      subject[:statistics][:assertions].must_equal 0
    end

    it 'should have statistics:failures 0' do
      subject[:statistics][:failures].must_equal 0
    end

    it 'should have statistics:errors 0' do
      subject[:statistics][:errors].must_equal 0
    end

    it 'should have statistics:skips 0' do
      subject[:statistics][:skips].must_equal 0
    end

    it 'should have statistics:passes 0' do
      subject[:statistics][:passes].must_equal 0
    end

    it 'should have timings:total_seconds be float' do
      subject[:timings][:total_seconds].must_be_instance_of Float
    end

    it 'should have timings:runs_per_second be Float' do
      subject[:timings][:runs_per_second].must_be_instance_of Float
    end

    it 'should have timings:assertions_per_second be Float' do
      subject[:timings][:assertions_per_second].must_be_instance_of Float
    end
  end

  describe 'when running one failure' do
    subject {rpt.record(FailTest.new);  rpt.report; rpt.storage }

    it 'should have 1 failure' do
      rpt.failures.must_equal 1
    end
  end

  describe 'when running 1 skip, 2 passes in verbose mode' do
    let(:rpt) { Minitest::Reporters::JsonReporter.new :verbose => true }
    let(:skipper) { FakeSkipper.new }
    let(:passer) { FakePasser.new }
    before do
      rpt.io = StringIO.new('')
      rpt.start

      # begin running tests
      # binding.pry
      rpt.record skipper
      rpt.record passer
      rpt.record passer
    end

    subject { rpt.report; rpt.storage }

    it 'should be yellow' do
      skip('do later')
      subject[:status][:color].must_equal 'yellow'
    end

    it 'should have statistics:total > 0' do
      skip('do later')

      subject[:statistics][:total].must_be :>, 0
    end

    it 'should have statistics:skips 1' do
      skip('do later')

      subject[:statistics][:skips].must_equal 1
    end

    it 'should have statistics:passes 2' do
      skip('do later')

      subject[:statistics][:passes].must_equal 2
    end
  end
end
