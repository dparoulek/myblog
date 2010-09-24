Feature: Authorization

  As the website owner
  I want to specify which users and groups can see each of my posts
  So that I can share notes with people I trust and keep other notes private

  Scenario: Admin Access

  Scenario: Anonymous Access
    Given I have set up a git repository by setting path to "." and setting name to "notes"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I login as "dparoulek@gmail" using password "test"
    When I create a node named "Recipes" based on "test/test-git-repo/personal/cooking/grill.mkdwn"
    And I go to the home page
    And I follow "Logout"
    And I follow "home"
    Then I should see "Recipes"   