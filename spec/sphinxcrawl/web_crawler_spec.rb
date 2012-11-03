require 'spec_helper'

describe Sphinxcrawl::WebCrawler do
  let(:dir) { 'spec/fixtures' }
  let(:domain) { 'http://www.example.com' }
  let(:index) { 'index_web.html' }
  let(:tree) { 'tree_web.html' }
  let(:child) { 'child_web.html' }

  before do
    stub_request(:get, domain+'/'+index).to_return(:body => File.new(dir+'/'+index), :status => 200)
    stub_request(:get, domain+'/'+tree).to_return(:body => File.new(dir+'/'+tree), :status => 200)
    stub_request(:get, domain+'/'+child).to_return(:body => File.new(dir+'/'+child), :status => 200)
  end

  subject { Sphinxcrawl::WebCrawler.new(domain+'/'+index) }

  its(:depth) { should be == 0 }
  specify { subject.pages.length.should be == 1 }

  context "with a depth of 1" do
    subject { Sphinxcrawl::WebCrawler.new(domain+'/'+index, 1) }
    its(:depth) { should be == 1 }
    specify { subject.pages.length.should be == 2 }
  end

  context "with a depth of 2" do
    subject { Sphinxcrawl::WebCrawler.new(domain+'/'+index, 2) }
    its(:depth) { should be == 2 }
    specify { subject.pages.length.should be == 3 }
  end
end
