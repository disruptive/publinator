Feature: Sections
  In order to view content in a beneficial hierarchy
  As a user
  I want to see pages in sections
  
  Scenario: View a section named Pop Songs
    Given there is a section named "pop_songs"
    And   the "pop_songs" section has an "article" called "index"
    When  I am using "dummy.dev"
    And   I visit "/pop_songs"
    Then  show me the page
    Then  I should see "Pop songs Section"
    
  Scenario: View a page in section named "Pagers"
    Given there is a section named "pagers"
    And   the "pagers" section has a "page" called "index"
    When  I am using "dummy.dev"
    And   I visit "/pagers"
    Then  show me the page
    Then  I should see "Pagers Section Index Page"
