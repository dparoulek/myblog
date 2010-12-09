Feature: My Blog

  I want to have a blog
  So that I can manage my notes and share some stuff on the interwebs

  Background:
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    And I visit "/files/notes/test/test-git-repo/personal/cooking/grill.mkdwn"
    And I press "Create and Publish"
    And I click "Logout"

  Scenario: Browse to Homepage
    When I go to the home page
    And I should see "Login"

  Scenario: About Page
    When I configure "grill.mkdwn" to be the About page
    And I follow "About"
    Then I should see "bbq"

  Scenario: See comments section on Home Page
    When I go to the home page
    And I fill in "Dave" for "comment_username"
    And I fill in "We made the sauce last night and it was delicious!" for "comment_comment"
    And I fill in the correct captcha
    And I press "submit"
    Then I should see "Thanks for your comment!"
    And I should see "Comments" 
    And I should see "We made the sauce last night and it was delicious!"
    And I should not see "Parent"

  Scenario: link to Twitter Account
 
  Scenario: RSS Feed
  