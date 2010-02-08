require 'spec_helper'

describe PyramidScheme::IndexServer do
  include FakeFS::SpecHelpers

  before(:each) do
    @server = PyramidScheme::IndexServer.new
    @server.indexer.stub(:index)
    FileUtils.mkdir_p(PyramidScheme.configuration[:server_destination_path])
    FileUtils.mkdir_p(PyramidScheme.configuration[:client_source_path])
  end

  it 'should have an indexer' do
    @server.indexer.should_not be_nil
  end

  it 'should default to a thinking sphinx indexer' do
    @server.indexer.should be_kind_of(PyramidScheme::ThinkingSphinxIndexer)
  end

  it 'should allow me to specify an ultrasphinx indexer' do
    PyramidScheme.configure do |config|
      config.indexer_class = PyramidScheme::UltrasphinxIndexer
    end
    @server = PyramidScheme::IndexServer.new
    @server.indexer.should be_kind_of(PyramidScheme::UltrasphinxIndexer)
  end

  it 'should index via the indexer' do
    @server.indexer.expects(:index).once
    @server.index
  end

  it 'should touch a lock file before indexing' do
    FileUtils.should_receive(:touch)
    @server.index
  end

  it 'should remove the lock file after indexing' do
    FileUtils.should_receive(:rm_f)
    @server.index
  end

  it 'should have the index provider process the index' do
    @server.index_provider.expects(:process_index)
    @server.index
  end
end
