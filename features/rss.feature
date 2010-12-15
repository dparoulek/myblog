Feature: Wiki

  I want to provide rss feed to my blog
  So that people can use feed readers to subscribe and read articles

  Background:
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I create a node named "Recipes" based on "test/test-git-repo/personal/cooking/grill.mkdwn"
    Then I follow "Logout"
  
  Scenario: View rss feed
    When I visit "/rss" 
    Then I should see "Recipes"

