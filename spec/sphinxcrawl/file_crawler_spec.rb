require 'spec_helper'

describe Sphinxcrawl::FileCrawler do
  let(:dir) { 'spec/fixtures' }
  let(:index) { 'index_file.html' }
  let(:html) { dir + '/' + index }
  subject { Sphinxcrawl::FileCrawler.new(html) }

  its(:depth) { should be == 0 }
  specify { subject.pages.length.should be == 1 }

  context "with a depth of 1" do
    subject { Sphinxcrawl::FileCrawler.new(html, 1) }
    its(:depth) { should be == 1 }
    specify { subject.pages.length.should be == 2 }
  end

  context "with a depth of 2" do
    subject { Sphinxcrawl::FileCrawler.new(html, 2) }
    its(:depth) { should be == 2 }
    specify { subject.pages.length.should be == 3 }
  end
end
