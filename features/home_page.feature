Feature: Home Page

  So that I can learn about Dave
  As an anonymous user
  I want to view the blog's homepage

  Scenario: Browse to Homepage
    When I go to the home page
    Then I should see "Hello World"
  