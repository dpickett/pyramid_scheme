require 'spec_helper'

describe PyramidScheme::Indexer::Ultrasphinx do
  before(:each) do
    @indexer = PyramidScheme::Indexer::Ultrasphinx.new
  end

  it 'should have the indexer task of ultrasphinx:index' do
    @indexer.class.index_task_name.should eql('ultrasphinx:index')
  end

  it 'should have the configure task of ultrasphinx:configure' do
    @indexer.class.configure_task_name.should eql('ultrasphinx:configure')
  end
end
