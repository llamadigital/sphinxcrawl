require 'rexml/document'

module Sphinxcrawl
  class Stream
    include REXML

    attr_reader :pages

    def initialize(pages)
      @pages = Array(pages)
      @count = 0
    end

    def empty?
      pages.length == 0
    end

    def number_of_pages
      pages.length
    end

    def field_names
      @field_names ||= pages.map(&:field_names).flatten.uniq
    end

    def to_xml
      add_fields
      add_documents
      ''.tap { |xml| document.write(xml) }
    end

    private

    def next_id
      @count += 1
    end

    def add_fields
      field_names.each do |name|
        add_field(name)
      end
    end

    def add_documents
      pages.each do |page|
        add_document(page)
      end
    end

    def add_field(name)
      schema.add_element('sphinx:field').tap do |field|
        field.add_attribute('name', name)
      end
      schema.add_element('sphinx:attr').tap do |attr|
        attr.add_attributes('name' => field_to_attribute(name), 'type' => 'string')
      end
    end

    def add_document(page)
      if page.field_names.length > 0
        root.add_element('sphinx:document').tap do |doc|
          doc.add_attribute('id', next_id)
          doc.add_element('url').text = CData.new(page.url)
          field_names.each do |name|
            doc.add_element(name).text = CData.new(page.field(name))
            doc.add_element(field_to_attribute(name)).text = CData.new(page.field(name))
          end
        end
      end
    end

    def document
      @document ||= Document.new.tap do |doc|
        doc << XMLDecl.new('1.0', 'UTF-8')
        @docset = doc.add_element('sphinx:docset')
      end
    end

    def root
      document.root
    end

    def field_to_attribute(name)
      "#{name}_attr"
    end

    def schema
      @schema ||= root.add_element('sphinx:schema').tap do |sch|
        sch.add_element('sphinx:attr').add_attributes('name' => 'url', 'type' => 'string')
      end
    end
  end
end
