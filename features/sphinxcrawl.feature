Feature: Generation of sphinx xml
  Scenario: help page
    When I get help for "sphinxcrawl"
    Then the exit status should be 0
    And the banner should be present
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|

  Scenario: xml for a nonexistent file
    When I run `sphinxcrawl spec/fixtures/blah.html`
    Then the exit status should be 1

  Scenario: xml for a nonexistent index
    When I run `sphinxcrawl spec`
    Then the exit status should be 1

  Scenario: xml for a single file
    Given a file named "test.html" with:
    """
    <html>
    <head>
    </head>
    <body>
    <h1 data-field="name">My name</h1>
    <p data-field="description">My description</p>
    <p data-field="body"><span>My</span><span>body</span></p>
    </body>
    </html>
    """
    When I run `sphinxcrawl test.html`
    Then the exit status should be 0
    And the output should contain "name"
    And the output should contain "description"
    And the output should contain "body"

  Scenario: index the xml
    Given a file named "test.html" with:
    """
    <html>
    <head>
    </head>
    <body>
    <h1 data-field="name">My name</h1>
    <p data-field="description">My description</p>
    <p data-field="body"><span>My</span><span>body</span></p>
    </body>
    </html>
    """
    And a file named "test.conf" with:
    """
    indexer
    {
    }
    source page
    {
    type = xmlpipe2
    xmlpipe_command = ../../bin/sphinxcrawl test.html 2>/dev/null
    }
    index page
    {
    source = page
    path = page
    morphology = stem_en
    charset_type = utf-8
    html_strip = 1
    }
    """
    When I run `indexer -c test.conf page`
    Then the exit status should be 0
