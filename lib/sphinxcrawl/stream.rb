require 'rexml/document'

module Sphinxcrawl
  class Stream
    include REXML

    attr_reader :pages

    def initialize(pages)
      @pages = Array(pages)
    end

    def empty?
      pages.length == 0
    end

    def number_of_pages
      pages.length
    end

    def field_names
      pages.map(&:field_names).flatten
    end
  end
end
