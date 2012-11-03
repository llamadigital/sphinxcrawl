require 'spec_helper'

describe Sphinxcrawl::Page do
  let(:html) { File.read('spec/fixtures/index_file.html') }
  let(:same) { Sphinxcrawl::Page.new(subject.url, 'blah') }
  subject { Sphinxcrawl::Page.new('index_file.html', html) }

  its(:html) { should be == html }
  it { should_not be_empty }

  its(:field_names) { should be == %w[name description body] }
  specify { subject.field('name').should be == 'My name' }
  specify { subject.field('description').should be == 'My description' }
  specify { subject.field('body').should be == 'My body' }

  its(:links) { should be == ['tree_file.html', 'index_file.html'] }

  specify { subject.should be == same }
  specify { subject.should eq(same) }
  specify { subject.should eql(same) }
  specify { subject.should_not equal same }
  specify { [subject, same].uniq.length.should be == 1 }
end
