require 'spec_helper'

describe Sphinxcrawl::Page do
  let(:html) { File.read('spec/fixtures/test.html') }
  subject { Sphinxcrawl::Page.new('/', html) }

  its(:html) { should be == html }
  it { should_not be_empty }

  its(:field_names) { should be == %w[name description body] }
  specify { subject.field('name').should be == 'My name' }
  specify { subject.field('description').should be == 'My description' }
  specify { subject.field('body').should be == 'My body' }

  its(:children) { should be == ['child.html'] }
end
