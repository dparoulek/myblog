Feature: Authentication and Authorization

  As myself
  I want to be able to prevent others from accessing my notes
  So that no one else can see my notes

  Scenario: Find Login Link
    Give that I am not logged in
    When I go to the home page
    Then I should see "Login"

  Scenario: Login Screen
    Given I am on the home page
    When I follow "Login"
    Then I should see "Login"
    And I should see "Email"
    And I should see "Password"

  Scenario: Authenticate via html form
    Given I am on the login page
    When I fill in "dparoulek" for "Email"
    And I fill in "dparoulek" for "Password"
    And I press "Login"
    Then I should be logged in

  Scenario: Authenticate via basic auth

  Scenario: Authenticate via ssh key
  