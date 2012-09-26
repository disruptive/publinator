Feature: Multiple Domain Names
  In order to publish multiple web sites 
  As a visitor
  I want to see the home page I requested
  
  Scenario: Visit example.com
    When I am using "example.com"
    And I visit the home page
    Then I should see "Example Home Page"
  
  Scenario: Visit dummy.dev
    When I am using "dummy.dev"
    When I visit the home page 
    I should see "Dummy Home Page"