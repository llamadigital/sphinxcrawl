require 'spec_helper'

describe Sphinxcrawl::Crawler do
  let(:html) { 'spec/fixtures/test.html' }
  subject { Sphinxcrawl::Crawler.new(html) }

  its(:depth) { should be == 0 }
  specify { subject.pages.length.should be == 1 }

  context "with a depth of 1" do
    subject { Sphinxcrawl::Crawler.new(html, 1) }
    its(:depth) { should be == 1 }
    specify { subject.pages.length.should be == 2 }
  end
end
