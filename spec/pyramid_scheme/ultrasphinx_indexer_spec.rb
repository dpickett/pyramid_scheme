require 'spec_helper'

describe PyramidScheme::UltrasphinxIndexer do
  before(:each) do
    @indexer = PyramidScheme::UltrasphinxIndexer.new
  end

  it 'should have the default rake task of ultrasphinx:index' do
    @indexer.class.default_task_name.should eql('ultrasphinx:index')
  end

  it 'should default to the default rake task' do
    @indexer.rake_task_name.should eql(@indexer.class.default_task_name)
  end
end
