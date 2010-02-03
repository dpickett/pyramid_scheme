require 'spec_helper'

describe PyramidScheme::IndexServer do
  before(:each) do
    @server = PyramidScheme::IndexServer.new
  end

  it 'should have an indexer' do
    @server.indexer.should_not be_nil
  end

  it 'should default to a thinking sphinx indexer' do
    @server.indexer.should be_kind_of(PyramidScheme::ThinkingSphinxIndexer)
  end

  it 'should allow me to specify an ultrasphinx indexer' do
    @server = PyramidScheme::IndexServer.new(:indexer_class => PyramidScheme::UltrasphinxIndexer)
    @server.indexer.should be_kind_of(PyramidScheme::UltrasphinxIndexer)
  end

  it 'should index via the indexer' do
    @server.indexer.expects(:index).once
    @server.index
  end
end
