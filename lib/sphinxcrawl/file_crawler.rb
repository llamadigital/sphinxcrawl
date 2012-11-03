module Sphinxcrawl
  class FileCrawler < Crawler
    def initialize(index_file_name, depth=0)
      @directory = File.dirname(index_file_name)
      @basename = File.basename(index_file_name)
      super(depth)
    end

    private

    def index
      @index ||= get_page(@basename)
    end

    def get_page(url)
      html = File.read(@directory + '/' + url) rescue nil
      Page.new(url, html) if html
    end
  end
end
