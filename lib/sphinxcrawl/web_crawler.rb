require 'uri'
require 'net/http'

module Sphinxcrawl
  class WebCrawler < Crawler
    def initialize(url, depth=0)
      @uri = URI.parse(url)
      super(depth)
    end

    private

    def host
      @uri.host
    end

    def port
      @uri.port
    end

    def index_path
      @uri.path
    end

    def http
      Net::HTTP.new(host, port)
    end

    def index
      @index ||= get_page(index_path)
    end

    def get_page(path)
      path = path && !path.empty? ? path : '/'
      location = path
      begin
        response = http.request(Net::HTTP::Get.new(location))
      end while location = response.header['location']
      html = response.body
      Page.new(path, html) if html
    end
  end
end
