require 'spec_helper'

describe Sphinxcrawl::Stream do
  let(:html) { File.read('spec/fixtures/index_file.html') }
  let(:page) { Sphinxcrawl::Page.new('index_file.html', html) }
  subject { Sphinxcrawl::Stream.new(page) }
  let(:xml) { subject.to_xml }

  it { should_not be_empty }
  its(:number_of_pages) { should be == 1 }

  its(:field_names) { should be == %w[name description body] }

  its(:to_xml) { should include('name') }
  its(:to_xml) { should include('description') }
  its(:to_xml) { should include('body') }
  its(:to_xml) { should include('My name') }
  its(:to_xml) { should include('My description') }
  its(:to_xml) { should include('My body') }
end
