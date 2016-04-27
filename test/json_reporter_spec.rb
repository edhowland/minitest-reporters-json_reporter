# json_reporter_spec.rb - specs for json_reporter

require_relative 'spec_helper'

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
  end
end
