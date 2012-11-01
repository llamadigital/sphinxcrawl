require 'rexml/document'

module Sphinxcrawl
  class Page
    include REXML

    attr_reader :html, :url

    def initialize(url, html)
      @url = url
      @html = html
      @field_data = {}
    end

    def empty?
      !html || html.empty?
    end

    def field_names
      fields.map do |n|
        n.attribute('data-field').value
      end.uniq
    end

    def field(name)
      @field_data[name] ||= get_field(name)
    end

    def children
      @children ||= XPath.match(document, '//a/@href').map(&:value)
    end

    private

    def get_field(name)
      XPath.match(document, "//*[@data-field='#{name}']//text()").map(&:value).join(' ')
    end

    def fields
      @fields ||= XPath.match(document, '//*[@data-field]')
    end

    def document
      @document ||= Document.new(html)
    end
  end
end
