require 'spec_helper'

describe PyramidScheme::ThinkingSphinxIndexer do 
  before(:each) do
    @indexer = PyramidScheme::ThinkingSphinxIndexer.new
  end

  it 'should have the default rake task of ts:in' do
    @indexer.class.default_task_name.should eql('ts:in')
  end
end
