Feature: Authorization

  As the website owner
  I want to specify which users and groups can see each of my posts
  So that I can share notes with people I trust and keep other notes private

  Scenario: Admin Access

  Scenario: Anonymous Access
    Given I have set up a git repository inside "../tmp-git-repo"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I am logged in
    When I create a node named "Recipes" based on "/notes/personal/cooking/grill.mkdwn"
    And I grant anonymous access to the node named "Recipes"
    And I logout
    And I go to the home page
    Then I should see the article



  