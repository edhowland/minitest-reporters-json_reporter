# json_reporter_spec.rb - specs for json_reporter

require_relative 'spec_helper'

describe MiniTest::Reporters::JsonReporter do
  let(:obj) { MiniTest::Reporters::JsonReporter.new }

  describe 'ctor' do
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


  end
end
