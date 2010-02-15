require 'spec_helper'

describe PyramidScheme::Indexer::ThinkingSphinx do
  before(:each) do
    @indexer = PyramidScheme::Indexer::ThinkingSphinx.new
  end

  it 'should have the index rake task of ts:in' do
    @indexer.class.index_task_name.should eql('ts:in')
  end

  it 'should have the configure rake task of ts:config' do
    @indexer.class.configure_task_name.should eql('ts:config')
  end
end
