# json_reporter_spec.rb - specs for json_reporter

require_relative 'spec_helper'
# TODO: class documentation
class FakeTest
    def initialize 
    @assertions = 0
  end

  attr_reader :assertions

    def passed?
    true
  end


    def skipped?
    false
  end

    def failure
    nil
  end

    def error?
    false
  end
end

# TODO: class documentation
class FakeException
    def message
    'failed test'
  end

  def backtrace
    ["xxxxx_test.rb:23"]
  end
end


# TODO: class documentation
class SkipTest < FakeTest
    def skipped?
    true
  end

    def passed?
    false
  end

  def failure
    FakeException.new
  end

  def name
    'skipped'
  end
end

# TODO: class documentation
class FailTest < SkipTest
    def skipped?
    false
  end
end


describe MiniTest::Reporters::JsonReporter do
  let(:obj) { MiniTest::Reporters::JsonReporter.new }

  describe 'initialize' do
    it 'should be an instance of MiniTest::Reporters::JsonReporter' do
      obj.must_be_instance_of MiniTest::Reporters::JsonReporter
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

    it 'should have metadata.generated_by == MiniTest::Reporters::JsonReporter' do
      obj.storage[:metadata][:generated_by].must_equal 'Minitest::Reporters::JsonReporter'
    end

    it 'should have metadata.version == [correct version]' do
      obj.storage[:metadata][:version].must_equal MiniTest::Reporters::JsonReporter::VERSION
    end    

    it 'should have metadata.time of length 20' do
      obj.storage[:metadata][:time].length.must_equal 20
    end    
  end

  describe 'record' do
  let(:rpt) { MiniTest::Reporters::JsonReporter.new }
    describe 'when running a passing test' do
    let(:passer) { FakeTest.new }
    subject { rpt.record(passer); rpt }

    it 'should be green' do
      subject.green?.must_equal true
    end

      it 'should have empty skips, fails' do
        subject.storage[:fails].must_be_empty
        subject.storage[:skips].must_be_empty
end
    end

    describe 'when running a skipped test' do
      let(:skipper) { SkipTest.new }
      subject { rpt.record(skipper); rpt }
      it 'should be yellow' do
        subject.yellow?.must_equal true
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

      end

end

    describe 'when running a failed test' do
      let(:bad) { FailTest.new }
      subject { rpt.record(bad); rpt }
      it 'should be red' do
        subject.red?.must_equal true
      end

      it 'should have non-empty fails' do
        subject.storage[:fails].wont_be_empty
      end

      it 'should have empty skips' do
        subject.storage[:skips].must_be_empty
      end

      describe 'fails' do
        let(:fails) { rpt.record(bad); rpt.storage[:fails] }
        it 'should have non-empty location' do
          fails[0][:location].wont_be_empty
        end

        it 'should have class FailTest' do
          fails[0][:class].must_equal 'FailTest'
        end

        it 'should have message: failed test' do
          fails[0][:message].must_equal 'failed test'
        end

        it 'should have type: failure' do
          fails[0][:type].must_equal 'failure'
        end

        it 'should have name length > 0' do
          fails[0][:name].length.must_be :>, 0
        end

      end

    end
  end
end
