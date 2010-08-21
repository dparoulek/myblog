Feature: Comments
  In order to encourage audience participation and feedback to my site
  As an author
  I want others to be able to provide comments

  Background:
    Given I have set up a git repository inside "../tmp-git-repo"
    And that I have registered an account using "dparoulek@gmail" as username and "test" as password
    And that I am logged in
    When I create a node named "Recipes" based on "personal/cooking/grill.mkdwn"
    Then I follow "Logout"

  Scenario: Comment on an article
    When I go to the home page
    And I follow "Recipes"
    And I fill in "Dave" for "comment_username"
    And I fill in "We made the sauce last night and it was delicious!" for "comment_comment"
    And I press "submit"
    Then I should see "Thanks for your comment!"
    And I should see "We made the sauce last night and it was delicious!"
    And I should not see "Parent"

    
