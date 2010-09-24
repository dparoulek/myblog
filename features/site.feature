Feature: My Blog

  I want to have a blog
  So that I can manage my notes and share some stuff on the interwebs

  Scenario: Browse to Homepage
    When I go to the home page
    Then I should see "Login"

  Scenario: About Page
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    And I visit "/files/notes/test/test-git-repo/personal/cooking/grill.mkdwn"
    And I press "Create and Publish"
    When I configure "grill.mkdwn" to be the About page
    And I follow "About"
    Then I should see "bbq"

  Scenario: link to Twitter Account
 
  Scenario: RSS Feed
  