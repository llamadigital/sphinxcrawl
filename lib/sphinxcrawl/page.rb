require 'nokogiri'

module Sphinxcrawl
  class Page
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

    def links
      @links ||= document.xpath('//a/@href').map(&:value).map do |url|
        # only local links (no http://)
        uri = URI.parse(url)
        uri.host.nil? && uri.scheme.nil? ? url : nil
      end.compact
    end

    def eql?(compare)
      url == compare.url
    end
    alias :== :eql?

    def hash
      url.hash
    end

    private

    def get_field(name)
      document.xpath("//*[@data-field='#{name}']//text()").map(&:content).join(' ')
    end

    def fields
      @fields ||= document.xpath('//*[@data-field]')
    end

    def document
      @document ||= Nokogiri::HTML(html)
    end
  end
end
