Feature: Authentication

  As myself
  I want to be able to prevent others from accessing my notes
  So that no one else can see my notes

  Scenario: Able to login
    Given that I am not logged in
    When I go to the home page
    Then I should see "Login" 

  Scenario: Login via html form
    Given that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And I am on the login page
    When I fill in "dparoulek@gmail" for "email"
    And I fill in "test" for "password"
    And I press "Login"
    Then I should see "Logged In Successfully!"
    And I should see "Logout"

  Scenario: Logout
    Given that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I am on the login page
    And I follow "Logout"
    Then I should see "You logged out successfully"
    And I should see "Login"

  Scenario: Not able to access pages unless logged in
    Given that I am not logged in
    When I visit "/people"
    Then I should see "Please log in to see this page"
    And I should see "Login"

  Scenario: Register
    Given that I am not logged in
    When I am on the login page
    And I visit "/register"
    Then I should not see "Please log in to see this page"
    And I should see "Sign up for an account"
    
  Scenario: Prevent duplicate Registrations
    Given that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I am not logged in
    When I am on the login page
    And I visit "/register"
    And I fill in "dparoulek@gmail" for "email"
    And I fill in "test" for "password"
    And I press "Create"
    Then I should see "Email has already been taken"

  Scenario: Login via basic auth

  Scenario: Login via ssh key

  Scenario: Login via openid

  Scenario: Restrict access to pages

  Scenario: Redirect back to original page
  