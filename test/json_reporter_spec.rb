# json_reporter_spec.rb - specs for json_reporter

require_relative 'spec_helper'

describe MiniTest::Reporters::JsonReporter do
  describe 'ctor' do
      let(:obj) { MiniTest::Reporters::JsonReporter.new }

    it 'should be an instance of MiniTest::Reporters::JsonReporter' do
      obj.must_be_instance_of MiniTest::Reporters::JsonReporter
end
end
end
