require 'spec_helper'

describe Sphinxcrawl::Stream do
  let(:html) { File.read('spec/fixtures/test.html') }
  let(:page) { Sphinxcrawl::Page.new(html) }
  subject { Sphinxcrawl::Stream.new(page) }
  let(:xml) { subject.to_xml }

  it { should_not be_empty }
  its(:number_of_pages) { should be == 1 }

  its(:field_names) { should be == %w[name description body] }

  its(:xml) { should be }
end
