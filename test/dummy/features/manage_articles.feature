Feature: Manage Articles
  In order to create site content
  As a manager
  I want to see the home page I requested

  Background:
    Given "example.com" can publish "Articles"
    When  I visit the manage page
    And   I follow "Articles"
    And   I should see "Add Article"

  Scenario: Add an Article
    When I follow "Add Article"


