# Sphinxcrawl

Simple command line tool gem to crawl a website and generate an xml stream for a
sphinx search index.

## Installation

Install it with:

    $ gem install sphinxcrawl

## Usage

After installation the sphinxcrawl command should be available.

Create a sphinx.conf file, for example


    source page
    {
      type = xmlpipe2
      xmlpipe_command = sphinxcrawl http://www.example.com -d 2 2>/dev/null
    }

    index page
    {
      source = page
      path = sphinx/page
      morphology = stem_en
      charset_type = utf-8
      html_strip = 1
    }

Install sphinx, with debianoid linuxes this is

    sudo apt-get install sphinxsearch

You should now have the indexer and search commands

    indexer -c sphinx.conf page

and you can search in the index with

    search -c sphinx.conf name

## Requirements

This gem is not Google! It uses nokogiri to parse html so will fail on badly
formed html. Also more importantly it only indexes part of the page marked with
a specific html attribute. This means you can only index sites that you control.
For example

    ...
    <div data-field="description">
    <p>This is a description</p>
    </div>
    ...

will index the text inside the div tag (stripping other tags) and put the text
in a sphinx field called description. All fields are aggregated from all the
pages from a site crawl.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
