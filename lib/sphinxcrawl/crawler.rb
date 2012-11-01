module Sphinxcrawl
  class Crawler
    attr_reader :depth

    def initialize(index_file_name, depth=0)
      @index_file_name = index_file_name
      @depth = depth
    end

    def pages
      return [index] if depth==0
      paths = [index.url]
    end

    def index
      @index ||= Page.new(@index_file_name, File.read(@index_file_name))
    end
  end
end
