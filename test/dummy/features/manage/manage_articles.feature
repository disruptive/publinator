Feature: Manage Articles
  In order to create site content
  As a manager
  I want to see the home page I requested

  Scenario: Visit Articles Page
    Given "example.com" can publish "Articles"
    And   I visit the manage page
    And   I follow "Articles"
    Then  I should see "Add a New Article"

