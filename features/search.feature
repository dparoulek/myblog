Feature: Search
  In order to find notes quickly
  As a blog owner
  I want to be able to search my notes

  Background: 
    Given I have set up a git repository by setting path to "../tmp-git-repo" and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I visit "/files/notes/personal/cooking/grill.mkdwn"
    And I press "Create and Publish"
    And I follow "Logout"

  Scenario: Search for private files
    Given that I login as "dparoulek@gmail" using password "test"
    When I search for "rare"
    Then I should see "grill.mkdwn"

  Scenario: Search for public posts

  Scenario: Specify location of search index directory

  Scenario: Rebuild Search Index
  
