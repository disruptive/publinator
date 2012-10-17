Feature: Multiple Domain Names
  In order to publish multiple web sites 
  As a visitor
  I want to see the home page I requested
  
  Scenario: Visit example.com
    When  I am using "example.com"
    And   I visit the home page
    Then  I should see "Welcome to dummy!"
  
  Scenario: Visit dummy.dev
    When  I am using "dummy.dev"
    And   I visit the home page 
    Then  I should see "Welcome to dummy!"
  
  Scenario: Visit silly.dummy.dev
    When  I am using "silly.dummy.dev"
    And   I visit the home page 
    Then  I should see "Welcome to silly!"