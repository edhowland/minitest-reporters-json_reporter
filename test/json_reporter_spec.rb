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
  end
end
