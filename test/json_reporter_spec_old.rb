# json_reporter_spec.rb - specs for json_reporter

require_relative 'spec_helper'
require_relative 'detail_helper'

def setup_rpt rpt, &blk
  rpt.io = StringIO.new('')
  rpt.start
  yield rpt
end

describe Minitest::Reporters::JsonReporter do
  let(:obj) { Minitest::Reporters::JsonReporter.new }

  describe 'initialize' do
    it 'should be an instance of Minitest::Reporters::JsonReporter' do
      obj.must_be_instance_of Minitest::Reporters::JsonReporter
    end

    it 'should have default initial hash' do
      obj.storage[:status][:code].must_equal 'Success'
    end

    it 'should have 0 tests' do
      obj.storage[:statistics][:total].must_equal 0
    end

    it 'should have 0 fails' do
      obj.storage[:statistics][:failed].must_equal 0
    end

    it 'should have 0 errors' do
      obj.storage[:statistics][:errored].must_equal 0
    end

    it 'should have 0 skips' do
      obj.storage[:statistics][:skipped].must_equal 0
    end

    it 'should have 0 passes' do
      obj.storage[:statistics][:passed].must_equal 0
    end

    it 'should have empty fails' do
      obj.storage[:fails].must_be_empty
    end

    it 'should have empty skips' do
      obj.storage[:skips].must_be_empty
    end

    it 'should not be red?' do
      obj.red?.wont_equal true
    end

    it 'should not be yellow?' do
      obj.yellow?.wont_equal true
    end
    it 'should be green?' do
      obj.green?.must_equal true
    end

    it 'should be status.color "green"' do
      obj.storage[:status][:color].must_equal 'green'
    end

    it 'should have metadata.generated_by == Minitest::Reporters::JsonReporter' do
      obj.storage[:metadata][:generated_by].must_equal 'Minitest::Reporters::JsonReporter'
    end

    it 'should have metadata.version == [correct version]' do
      obj.storage[:metadata][:version].must_equal Minitest::Reporters::JsonReporter::VERSION
    end

    it 'should have metadata.time of length 20' do
      obj.storage[:metadata][:time].length.must_equal 20
    end
  end

  describe 'record' do
    let(:rpt) { Minitest::Reporters::JsonReporter.new }
    describe 'when running a passing test' do
      let(:passer) { FakePasser.new }
      before { setup_rpt(rpt) {|r| r.record(passer) } }
      subject { rpt.report; rpt.storage }

      it 'should be green' do
        subject[:status][:color].must_equal 'green'
      end

      it 'should have empty skips, fails' do
        subject[:fails].must_be_empty
        subject[:skips].must_be_empty
      end
    end

    describe 'when running a skipped test' do
      let(:skipper) { FakeSkipper.new('will be skipped') }
      before { $stdout = StringIO.new(''); rpt.start }

      subject { rpt.record(skipper); rpt.report; rpt }
      it 'should be yellow' do
        subject.yellow?.must_equal true
      end

      it 'should have color : yellow' do
        subject
        rpt.storage[:status][:color].must_equal 'yellow'
      end

      it 'should have non empty skips' do
        subject.storage[:skips].wont_be_empty
      end

      it 'should have empty fails' do
        subject.storage[:fails].must_be_empty
      end

      describe 'skips[0]' do
        let(:skips) { rpt.record(skipper); rpt.storage[:skips] }
        it 'should have type: skipped' do
          skips[0][:type].must_equal 'skipped'
        end

        it 'should have name.length > 0' do
          skips[0][:name].length.must_be :>, 0
        end

        it 'should have class: SkipTest' do
          skips[0][:class].must_equal 'FakeSkipper'
        end

        it 'should have message.length > 0' do
          skips[0][:message].length.must_be :>, 0
        end

        it 'should have non nil, non empty location' do
          skips[0][:location].wont_be_nil
          skips[0][:location].wont_be_empty
        end
      end
    end

    describe 'when running a failed test' do
      let(:bad) { FailTest.new }
#      before { setup_rpt(rpt) {|r|r.record(bad) }  }
      before { rpt.io = StringIO.new(''); rpt.start; rpt.record(bad) }
      subject { rpt.report; rpt.storage }
      it 'should be red' do
        subject[:status][:color].must_equal 'red'
      end

      it 'should have non-empty fails' do
        subject[:fails].wont_be_empty
      end

      it 'should have empty skips' do
        subject[:skips].must_be_empty
      end

      describe 'fails' do
        let(:fails) { rpt.record(bad); rpt.storage[:fails] }
        it 'should have non-empty location' do
          fails[0][:location].wont_be_empty
        end

        it 'should have class FailTest' do
          fails[0][:class].must_equal 'FailTest'
        end

        it 'should have message: bad juju' do
          fails[0][:message].must_equal 'bad juju'
        end

        it 'should have type: failure' do
          fails[0][:type].must_equal 'failure'
        end

        it 'should have name length > 0' do
          fails[0][:name].length.must_be :>, 0
        end

        it 'should have nil backtrace' do
          fails[0][:backtrace].must_be_nil
        end
      end
    end

    describe 'when running error test' do
      let(:err) { FaultyTest.new }
      before { setup_rpt(rpt) {|r| r.record(err) }  }
      subject { rpt.report; rpt.storage }

      it 'should be red' do
        subject[:status][:color].must_equal 'red' 
      end

      it 'should have skips:empty, fails == 1' do
        subject[:fails].wont_be_empty
        subject[:skips].must_be_empty
      end

      describe 'fails[0]' do
        let(:fails) { rpt.storage[:fails] }

        it 'should have type: error' do
          fails[0][:type].must_equal 'error'
        end

        it 'should have class: FaultyTest' do
          fails[0][:class].must_equal 'FaultyTest'
        end

        it 'should have name.length > 0' do
          fails[0][:name].length.must_be :>, 0
        end

        it 'should have location.length > 0' do
          fails[0][:location].length.must_be :>, 0
        end

        it 'should have non-empty backtrace' do
          fails[0][:backtrace].wont_be_nil
          fails[0][:backtrace].wont_be_empty
        end
      end
    end
  end

  describe 'report' do
    let(:io) { StringIO.new '' }
    let(:rpt) { Minitest::Reporters::JsonReporter.new }
    before { $stdout = io }
    subject { rpt.start }

    it 'should generate output to stdout' do
      subject
      rpt.report
      io.to_s.wont_be_empty
    end

    describe 'when recording a failing test' do
      let(:rpt_fail) { Minitest::Reporters::JsonReporter.new }
      before { rpt_fail.start; rpt_fail.record(FailTest.new) }
      subject { rpt_fail.report }
      it 'should have storage[:status][:code] == failed' do
        subject
        rpt_fail.storage[:status][:code].must_equal 'Failed'
      end
    end
  end

  describe 'statistics.assertions' do
    let(:rpt) { Minitest::Reporters::JsonReporter.new }
    before { $stdout = StringIO.new(''); rpt.start }
    subject { rpt.record(FakePasser.new); rpt.report }

    it 'should not be nil' do
      subject
      rpt.storage[:statistics][:assertions].wont_be_nil
    end
  end

  describe 'timings' do
    let(:rpt) { Minitest::Reporters::JsonReporter.new }
    before { $stdout = StringIO.new(''); rpt.start }
    subject { rpt.record(FakePasser.new); rpt.report }

    it 'should have timings.total_seconds > 0.0' do
      subject
      rpt.storage[:timings][:total_seconds].must_be :>, 0.0
    end

    it 'should have timings.runs_per_second > 1.0' do
      subject
      rpt.storage[:timings][:runs_per_second].must_be :>=, 1.0
    end

    it 'should have timings.assertions_per_second > 1.0' do
      subject
      rpt.storage[:timings][:assertions_per_second].must_be :>=, 0.0
    end
  end

  describe 'with verbose option' do
    let(:rpt) { Minitest::Reporters::JsonReporter.new verbose: true }
    before { setup_rpt(rpt) {|r| r.record(FakePasser.new) } }
    subject { rpt.report; rpt.storage }
    it 'should have non-nil passes' do
      subject[:passes].wont_be_nil
      subject[:passes].wont_be_empty
    end
  end
end
