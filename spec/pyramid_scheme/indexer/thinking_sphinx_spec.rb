require 'spec_helper'

describe PyramidScheme::Indexer::ThinkingSphinx do
  before(:each) do
    @indexer = PyramidScheme::Indexer::ThinkingSphinx.new
  end

  it 'should have the default rake task of ts:in' do
    @indexer.class.default_task_name.should eql('ts:in')
  end
end
