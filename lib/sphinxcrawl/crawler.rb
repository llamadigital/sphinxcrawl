require 'set'

module Sphinxcrawl
  class Crawler
    attr_reader :depth

    def initialize(depth=0)
      @depth = depth
    end

    def pages
      return @pages if @pages
      return [] unless index
      @pages = Set.new([index])
      return @pages if @depth == 0

      current_pages = Set.new([index])
      depth.times do
        links = current_pages.map(&:links).flatten.compact.uniq
        current_pages = Set.new(links.map{ |url| get_page(url) }.compact) - @pages
        @pages += current_pages
      end
      @pages
    end

    private

    def index
      nil
    end

    def get_page(url)
      nil
    end
  end
end
