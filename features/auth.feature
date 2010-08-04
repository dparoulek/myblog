Feature: Authentication and Authorization

  As myself
  I want to be able to prevent others from accessing my notes
  So that no one else can see my notes

  Scenario: Able to login
    Given that I am not logged in
    When I go to the home page
    Then I should see "Login" 

  Scenario: Login via html form
    Given I am on the login page
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    When I fill in "dparoulek@gmail" for "Email"
    And I fill in "test" for "Password"
    And I press "Login"
    Then I should see "Logged In Successfully!"
    And I should see "Logout"

  Scenario: Logout
    Given that I have registered an account using "dparoulek@gmail" as username and "test" as password	
    And that I am logged in
    When I am on the login page
    And I press "Logout" 
    Then I should see "Logged Out Successfully!"
    And I should see "Login"

  Scenario: Login via basic auth

  Scenario: Login via ssh key

  Scenario: Login via openid

  Scenario: Create user

  Scenario: Restrict access to pages
    Given I am unauthorized to access a page
    When I attempt to navigate to that page
    Then I should be redirected to the login page

  Scenario: Redirect back to original page
    Given I am unauthorized to access a page
    When I am redirected to login page
    And I login successfully
    Then I should be taken back to the original page that I requested
  